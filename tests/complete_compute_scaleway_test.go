package test

import (
	"fmt"
	"testing"

	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

// An example of how to test the simple Terraform module in examples/terraform-basic-example using Terratest.
func TestTerraformComputeScalewayExample(t *testing.T) {
	t.Parallel()

	approvedRegions := "ams1"
	expectedName := fmt.Sprintf("test-compute-terraform-%s", random.UniqueId())
	expectedArch := "x86_64"
	expectedServerType := "VC1S"
	expectedImg := "Ubuntu Xenial"

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../modules/compute",

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"region":             approvedRegions,
			"name":               expectedName,
			"image_architecture": expectedArch,
			"server_type":        expectedServerType,
			"image_name":         expectedImg,
		},

		NoColor: true,
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the value of an output variable
	actualText := terraform.Output(t, terraformOptions, "server_name")

	// Verify we're getting back the variable we expect
	assert.Equal(t, expectedName, actualText)
}
