output "server_name" {
  value = "${module.compute.server_name}"
}

output "public_ip" {
  value = "${module.compute.public_ip}"
}

output "private_ip" {
  value = "${module.compute.private_ip}"
}
