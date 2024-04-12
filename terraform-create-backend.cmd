set IAC_TF_LIVE_CODE=%CD%\code
set IAC_TF_LIVE_CONFIG=%CD%\config\eu-north-1\dev

cd %IAC_TF_LIVE_CODE%\00_terraform-backend
terraform init
terraform plan -out tf.plan -var-file=%IAC_TF_LIVE_CONFIG%\terraform.tfvars -compact-warnings -input=false
terraform apply -compact-warnings tf.plan
