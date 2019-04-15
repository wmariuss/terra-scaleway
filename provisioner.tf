resource "null_resource" "provisioner" {
  count    = "${var.enable_provisioner ? var.number_of_servers : 0}"
  # Instance ID(s) for provisioning
  triggers {
    cluster_instance_ids = "${element(scaleway_server.this.*.id, count.index)}"
  }

  # IP(s) for connection
  connection {
    type        = "ssh"
    host        = "${var.provisioner_internal_execution ? element(scaleway_server.this.*.private_ip, count.index) : element(scaleway_server.this.*.public_ip, count.index)}"
    user        = "${var.provisioner_user}"
    private_key = "${file(var.provisioner_private_key)}"
    timeout     = "2m"
  }

  provisioner "file" {
    source      = "${var.provisioner_source_file}"
    destination = "${var.provisioner_destination_file}"
  }

  provisioner "remote-exec" {
    inline = "${var.provisioner_remote_cmds}"
  }

  depends_on = ["scaleway_server.this", "scaleway_ip.this", "scaleway_security_group_rule.default_in", "scaleway_volume_attachment.this"]
}
