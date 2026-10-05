output "instance_public_ip" {
  value = aws_instance.abhishek.public_ip
}
# output "instance_id" {
#   value = aws_instance.abhishek.instance_id
#
output "instance_private_ip" {
  value = aws_instance.abhishek.private_ip
}