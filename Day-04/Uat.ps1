$choice = Read-Host "Enter your choice: 1=Create Dev, 2=Destroy Dev, 3=Switch to Default"

if ($choice -eq "1") {
    terraform init
    terraform workspace new uat
    terraform plan --var-file=uat.tfvars
    terraform apply --var-file=uat.tfvars --auto-approve
}
elseif ($choice -eq "2") {
    terraform destroy --var-file=uat.tfvars --auto-approve
}
elseif ($choice -eq "3") {
    terraform workspace select default
    terraform workspace delete uat
}
else {
    Write-Host "Invalid choice!"
}