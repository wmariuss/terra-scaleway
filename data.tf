data "scaleway_image" "find" {
  architecture = "${var.image_architecture}"
  name         = "${var.image_name}"
}