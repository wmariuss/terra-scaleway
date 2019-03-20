# terraform-scaleway-compute

Manage Scaleway compute resource.

## Requirements

* `terraform >= v0.11.11`
* Scaleway `Organization` and `Token` keys generated from your scaleway account

```shell
export SCALEWAY_ORGANIZATION=
export SCALEWAY_TOKEN=
```

## Usage

Input

| Parameter | Default value | Description | Type  | Required | Example |
|-----------|---------------|-------------|-------|----------|---------|
| source | | Module source | String | Yes | |
| region | `par1` | Region you want to create the server | String | No | par1 and ams1 |
| number_of_servers | `1` | How many servers you want to create | Number | No | |
| name | | Give a name for the server(s) | String | Yes | |
| server_type | `VC1S` | Type for the server you want to create | String | No | Check scaleway API |
| tags | | Give tags for server(s) | List | No | |
| additional_volumes | | Create additional volumes and attach them to the server(s) | Map | No | Check code example |
| image_architecture | `x86_64` | The image architecture you want to use to create the server(s) | String | No | arm or x86_64 |
| image_name | `Ubuntu Xenial` | Image name or name of os you want to use for the server(s) | String | No | Check scaleway API |
| security_group_name | | Give a name for security group | String | No | |
| security_group_desc | `Managed by Terraform` | Add description for security group | String | No | |
| enable_ip | `true` | Provides IP(s) for server(s) | Bool | No | |
| default_security | `true` | Set security group as default | Bool | No | |
| create_default_security_group | `true` | Apply default security group | Bool | No | |
| additional_security_rules | | Add additional rules to the security group | Map | No | Check code example |
| enable_ipv6 | `false` |Enable IPv6 | Bool | No | |
| server_state | `running` | The state of the server | String | No | stopped and running |

Output

| Parameter | Description   |
|-----------|---------------|
| module.compute.server_id | List server's ID |
| module.compute.server_name | List server's  name |
| module.compute.public_ip | List server's public IP |
| module.compute.private_ip | List server's private IP |

## Example

```hcl
# Example main.tf

module "compute" {
  // From Github repo
  # source = "git::https://github.com/wmariuss/terraform-scaleway-compute.git?ref=v1.0.1"
  // From Terraform registry
  source  = "wmariuss/compute/scaleway"
  version = "1.0.0"

  name               = "test-compute-terraform"
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

# Example output.tf

output "server_name" {
  value = "${module.compute.server_name}"
}

output "public_ip" {
  value = "${module.compute.public_ip}"
}

output "private_ip" {
  value = "${module.compute.private_ip}"
}
```

## Tests

* `go >= 1.11` and `dep >= 0.5.0`
* `dep ensure`

All tests

* `go test -timeout 30m`
* `go test -timeout 30m -p 1 ./... # For multiple tests with less log output`
* `GOCACHE=off go test -timeout 30m -p 1 ./... # without cache`

One test

* `cd tests/`
* `go test -v -run TestTerraformComputeScalewayExample # TestTerraformComputeScalewayExample = name of function`

## Authors

* [Marius Stanca](mailto:me@marius.xyz)