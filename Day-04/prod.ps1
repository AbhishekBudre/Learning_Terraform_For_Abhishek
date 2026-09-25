$choice = Read-Host "Enter your choice: 1=Create Dev, 2=Destroy Dev, 3=Switch to Default"

if ($choice -eq "1") {
    terraform init
    terraform workspace new prod
    terraform plan --var-file=prod.tfvars
    terraform apply --var-file=prod.tfvars --auto-approve
}
elseif ($choice -eq "2") {
    terraform destroy --var-file=prod.tfvars --auto-approve
}
elseif ($choice -eq "3") {
    terraform workspace select default
    terraform workspace delete prod
}
else {
    Write-Host "Invalid choice!"
}