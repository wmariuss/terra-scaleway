# tf-scaleway

Terraform modules for Scaleway Cloud Platform.

## Requirements

* `terraform >= v0.11.11`
* Scaleway `Organization` and `Token` keys generated from your scaleway account

```shell
export SCALEWAY_ORGANIZATION=
export SCALEWAY_TOKEN=
```

## Docs

How to use tf_scaleway check [here](docs/)

## Development

* `go >= 1.11` and `dep >= 0.5.0`
* `dep ensure`

All tests

* `go test -timeout 30m`
* `go test -timeout 30m -p 1 ./... # For multiple tests with less log output`
* `GOCACHE=off go test -timeout 30m -p 1 ./... # without cache`

One test

* `cd tests/`
* `go test -v -run TestTerraformBasicExample # TestTerraformBasicExample = name of function`

## Authors

Marius Stanca <me@marius.xyz>