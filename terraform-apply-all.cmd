set IAC_TF_LIVE_CODE=%CD%\code
set IAC_TF_LIVE_CONFIG=%CD%\config\eu-north-1\dev

cd %IAC_TF_LIVE_CODE%\01_stage-shared
terraform init -backend-config=%IAC_TF_LIVE_CONFIG%\terraform.tfbackend -reconfigure
terraform plan -out tf.plan -var-file=%IAC_TF_LIVE_CONFIG%\terraform.tfvars -compact-warnings -input=false -detailed-exitcode
if %ERRORLEVEL% equ 0 (
    echo "no changes detected; apply skipped"
) else if %ERRORLEVEL% equ 1 (
    echo "errors detected !!!"
) else if %ERRORLEVEL% equ 2 (
    terraform apply -compact-warnings tf.plan
)

cd %IAC_TF_LIVE_CODE%\02_platform-foundation
terraform init -backend-config=%IAC_TF_LIVE_CONFIG%\terraform.tfbackend
terraform plan -out tf.plan -var-file=%IAC_TF_LIVE_CONFIG%\terraform.tfvars -compact-warnings -input=false -detailed-exitcode
if %ERRORLEVEL% equ 0 (
    echo "no changes detected; apply skipped"
) else if %ERRORLEVEL% equ 1 (
    echo "errors detected !!!"
) else if %ERRORLEVEL% equ 2 (
    terraform apply -compact-warnings tf.plan
)

cd %IAC_TF_LIVE_CODE%\03_platform-bootstrap
terraform init -backend-config=%IAC_TF_LIVE_CONFIG%\terraform.tfbackend
terraform plan -out tf.plan -var-file=%IAC_TF_LIVE_CONFIG%\terraform.tfvars -compact-warnings -input=false -detailed-exitcode
if %ERRORLEVEL% equ 0 (
    echo "no changes detected; apply skipped"
) else if %ERRORLEVEL% equ 1 (
    echo "errors detected !!!"
) else if %ERRORLEVEL% equ 2 (
    terraform apply -compact-warnings tf.plan
)
