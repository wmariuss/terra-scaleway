// Example create scaleway server

module "compute" {
  source = "../../"

  name               = "terraform-compute-test"
  number_of_servers  = 1
  region             = "ams1"
  server_type        = "VC1S"
  image_architecture = "x86_64"
  image_name         = "Ubuntu Xenial"
  tags               = ["Terraform"]

  // Start provisioning
  enable_provisioner           = true
  provisioner_user             = "root"
  provisioner_private_key      = "/Users/mariuss/.ssh/mariuss"
  provisioner_source_file      = "run.sh"
  provisioner_destination_file = "/opt/run.sh"
  provisioner_remote_cmds      = [
      "bash /opt/run.sh"
  ]
}
