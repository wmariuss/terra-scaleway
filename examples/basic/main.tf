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

  // Depends of server_type, scaleway allow you to attach a limited number of valumes or size
  # additional_volumes = {
  #   "0" = ["volume1", 50, "l_ssd"]
  # }

 // Add rules to the security group
 additional_security_rules = {
   "0" = ["accept", "inbound", "0.0.0.0/0", "TCP", 80],
   "1" = ["accept", "inbound", "0.0.0.0/0", "TCP", 443]
 }
}
