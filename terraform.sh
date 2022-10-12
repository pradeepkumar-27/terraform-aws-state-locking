#!/bin/bash

terraform fmt -recursive

terraform init -backend-config="./config/terraform_backend_config.hcl" -reconfigure

terraform plan -var-file="./config/terraform.tfvars"

echo "Do you want to apply the terraform configuration ? "
read answer
if [[ $answer == 'y' || $answer == 'Y' ]] ; then
  terraform apply -var-file="./config/terraform.tfvars" -auto-approve
fi