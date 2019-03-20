// compute module
// Marius Stanca <me@marius.xyz>

provider "scaleway" {
  version = ">= 1.9.1, <= 1.9.1"
  region  = "${var.region}"
}

// Create VM(s)
resource "scaleway_server" "this" {
  count = "${var.name != "" ? var.number_of_servers : 0}"

  name           = "${var.number_of_servers > 1 ? format("%s-%d", var.name, count.index+1): var.name}"
  image          = "${data.scaleway_image.find.id}"
  type           = "${var.server_type}"
  enable_ipv6    = "${var.enable_ipv6}"
  state          = "${var.server_state}"
  security_group = "${element(scaleway_security_group.default.*.id, count.index)}"
  tags           = "${var.tags}"
}

// Setup volume(s)
resource "scaleway_volume" "this" {
  count = "${length(var.additional_volumes) > 0 ? length(var.additional_volumes) : 0}"

  name       = "${element(var.additional_volumes[count.index], 0)}"
  size_in_gb = "${element(var.additional_volumes[count.index], 1)}"
  type       = "${element(var.additional_volumes[count.index], 2)}"
}

// Attach the volume(s)
resource "scaleway_volume_attachment" "this" {
  count = "${length(var.additional_volumes) > 0 ? length(var.additional_volumes) : 0}"

  server = "${element(scaleway_server.this.*.id, count.index)}"
  volume = "${element(scaleway_volume.this.*.id, count.index)}"
}

// Give an IP
resource "scaleway_ip" "this" {
  count = "${var.enable_ip && var.name != "" ? var.number_of_servers : 0}"

  server = "${element(scaleway_server.this.*.id, count.index)}"
}

// Security Groups
resource "scaleway_security_group" "default" {
  count = "${var.name != "" || var.security_group_name != "" ? 1 : 0}"

  name                    = "${var.security_group_name != "" ? var.security_group_name : var.name}"
  enable_default_security = "${var.default_security}"
  description             = "${var.security_group_desc}"
}

// Default security group rule
resource "scaleway_security_group_rule" "default_in" {
  count = "${var.create_default_security_group ? 1 : 0}"

  security_group = "${scaleway_security_group.default.id}"

  action    = "accept"
  direction = "inbound"
  ip_range  = "0.0.0.0/0"
  protocol  = "TCP"
  port      = 22
}

resource "scaleway_security_group_rule" "custom" {
  count = "${length(var.additional_security_rules) > 0 ? length(var.additional_security_rules) : 0}"

  security_group = "${scaleway_security_group.default.id}"

  action    = "${element(var.additional_security_rules[count.index], 0)}"
  direction = "${element(var.additional_security_rules[count.index], 1)}"
  ip_range  = "${element(var.additional_security_rules[count.index], 2)}"
  protocol  = "${element(var.additional_security_rules[count.index], 3)}"
  port      = "${element(var.additional_security_rules[count.index], 4)}"
}