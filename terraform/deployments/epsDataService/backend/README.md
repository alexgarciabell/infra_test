# Commands to create ASG 

Pre-requisite - Use Terraform Version 0.13

#From icfar_deployment_infra repo execute the below commands

#command to intialize the workspace

terraform init

#command to create a new workspace

terraform workspace new <workspace_name>

#command to list the available workspaces

terraform workspace list

#command to execute terraform plan

terraform plan -var "application_version=value" -var "version_id=value"

#command to execute terraform apply

terraform apply -var "application_version=value" -var "version_id=value"

