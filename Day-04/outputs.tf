output "public-ip" {
 description = "this is the Ec2 instance public ip address"
   value = aws_instance.example.public_ip
 }
output "private_ip" {
    description = "this is the Ec2 instance private ip address"
    value = aws_instance.example.private_ip
}
output "public_dns" {
    description = "this is the Ec2 instance public dns"
    value = aws_instance.example.public_dns
}
output "private_dns" {
    description = "this is the Ec2 instance private dns"
    value = aws_instance.example.private_dns

}
output "instance_id" {
    description ="this is the Ec2 instance id"
    value = aws_instance.example.id
}
output "instance_arn" {
    description ="this is the Ec2 instance arn"
    value = aws_instance.example.arn
}
output "instance_tags" {
    description = "this is the Ec2 instance tags"
    value = aws_instance.example.tags
}