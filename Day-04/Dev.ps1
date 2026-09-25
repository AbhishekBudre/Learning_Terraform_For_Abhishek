$choice = Read-Host "Enter your choice: 1=Create Dev, 2=Destroy Dev, 3=Switch to Default"

if ($choice -eq "1") {
    terraform init
    terraform workspace new Dev
    terraform plan --var-file=Dev.tfvars
    terraform apply --var-file=Dev.tfvars --auto-approve
}
elseif ($choice -eq "2") {
    terraform destroy --var-file=Dev.tfvars --auto-approve
}
elseif ($choice -eq "3") {
    terraform workspace select default
    terraform workspace delete Dev
}
else {
    Write-Host "Invalid choice!"
}