set IAC_TF_LIVE_CODE=%CD%\code
set IAC_TF_LIVE_CONFIG=%CD%\config\eu-north-1\dev

cd %IAC_TF_LIVE_CODE%\03_platform-bootstrap
terraform init -backend-config=%IAC_TF_LIVE_CONFIG%\terraform.tfbackend
terraform destroy -var-file=%IAC_TF_LIVE_CONFIG%\terraform.tfvars -input=false -compact-warnings -auto-approve

cd %IAC_TF_LIVE_CODE%\02_platform-foundation
terraform init -backend-config=%IAC_TF_LIVE_CONFIG%\terraform.tfbackend
terraform destroy -var-file=%IAC_TF_LIVE_CONFIG%\terraform.tfvars -input=false -compact-warnings -auto-approve

cd %IAC_TF_LIVE_CODE%\01_stage-shared
terraform init -backend-config=%IAC_TF_LIVE_CONFIG%\terraform.tfbackend
terraform destroy -var-file=%IAC_TF_LIVE_CONFIG%\terraform.tfvars -input=false -compact-warnings -auto-approve

