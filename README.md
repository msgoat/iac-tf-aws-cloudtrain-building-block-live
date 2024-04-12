# Terraform Building Block Live Code for AWS

Terraform live code library which demonstrated the usage of Terraform Building Blocks on AWS.

## HOW the live code is organized

The common Terraform code to build a stage is located in directory `code`. Each Terraform execution unit
(i.e. each piece of Terraform code which need to be executed separately with its own `terraform apply` command)
has its own dedicated subdirectory. To express the order of the live code execution, each subdirectory name
starts with a sequence number.

The stage-specific Terraform configuration files for each stage are located in directory `config`.

Each stage has its own configuration directory within `config`:
* The first subdirectory represents the AWS region the stage is hosted in (like `eu-north-1`).
* The second subdirectory represents the actual stage (like `dev` for development).

## HOW to run the live code

To be continued...

