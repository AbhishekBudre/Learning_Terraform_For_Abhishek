output "vpc_1_id" {
  value = aws_vpc.production_vpc_1.id
}
output "vpc_2_id" {
    value = aws_vpc.production_vpc_2.id
}
output "subnet_1_id" {
    value = aws_subnet.production_vpc_1_subnet.id
}
output "subnet_2_id" {
    value = aws_subnet.production_vpc_2_subnet.id
}
output "vpc_3_id" {
  value = aws_vpc.production_vpc_3.id
}
output "subnet_3_id" {
    value = aws_subnet.production_vpc_3_subnet.id
}
