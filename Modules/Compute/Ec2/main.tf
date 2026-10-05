resource "aws_instance" "abhishek" {
  ami           = var.instance_ami_id
  instance_type = var.instance_type
  subnet_id = var.subnet_id
  # count = var.no_of_instance
  associate_public_ip_address = var.associate_public_ip_address

  tags = {
    Name = "${var.environment}-Abhishek-web-server"
    Environment = var.environment
  }
}