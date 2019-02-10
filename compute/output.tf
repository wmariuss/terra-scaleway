
output "server_id" {
  value = "${scaleway_server.this.*.id}"
}

output "server_name" {
  value = "${scaleway_server.this.*.name}"
}

output "public_ip" {
  value = "${scaleway_server.this.*.public_ip}"
}

output "private_ip" {
  value = "${scaleway_server.this.*.private_ip}"
}