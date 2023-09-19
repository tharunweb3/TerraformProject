Basic Terraform Project

This repository contains a basic Terraform project that demonstrates infrastructure as code (IAC) principles using Terraform to provision resources on a cloud provider. This project creates a simple AWS EC2 instance as an example.
Prerequisites

Before you begin, ensure you have the following prerequisites:

    Terraform installed locally.
    AWS account credentials with appropriate permissions configured. You can set these credentials using the AWS CLI or environment variables.

    Project Structure

The project structure is organized as follows:

terraform-basic-project/
│ README.md
│ main.tf
│ variables.tf
│ outputs.tf
│ terraform.tfvars

    main.tf: This file contains the Terraform configuration code for provisioning AWS resources.
    variables.tf: Define variables in this file that can be used to customize your infrastructure.
    outputs.tf: Define outputs here to display useful information after Terraform applies the configuration.
    terraform.tfvars: You can set variable values in this file instead of hardcoding them in your main.tf.

    Usage

Follow these steps to use this Terraform project:

    Clone this repository to your local machine:
    git clone https://github.com/yourusername/terraform-basic-project.git

Change into the project directory:
cd terraform-basic-project

Initialize the Terraform working directory:
terraform init

Review and customize the terraform.tfvars file with your own variable values if necessary.
Apply the Terraform configuration to create the resources:
terraform apply

Confirm the changes by typing yes when prompted.

After Terraform successfully applies the configuration, it will display outputs. You can use these outputs to access the provisioned resources.

To destroy the created resources when they are no longer needed, run:
terraform destroy

Confirm the destruction by typing yes when prompted.

Cleanup

After using this project, remember to run terraform destroy to ensure that all resources created by Terraform are removed to avoid incurring unnecessary charges.
Contributing

If you'd like to contribute to this project, please fork the repository and submit a pull request.
License

This project is licensed under the MIT License - see the LICENSE file for details.
