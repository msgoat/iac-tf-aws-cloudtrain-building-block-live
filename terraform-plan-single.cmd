set IAC_TF_LIVE_CODE=%CD%\code
set IAC_TF_LIVE_CONFIG=%CD%\config\eu-north-1\dev

cd code\%1
terraform init -backend-config=%IAC_TF_LIVE_CONFIG%\terraform.tfbackend
terraform plan -out tf.plan -var-file=%IAC_TF_LIVE_CONFIG%\terraform.tfvars -compact-warnings -input=false
