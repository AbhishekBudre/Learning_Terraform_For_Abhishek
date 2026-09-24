resource "aws_instance" "abhishek" {
  ami           = var.instance_ami_id
  instance_type = var.instance_type
  subnet_id = var.subnet_id
  # count = var.no_of_instance
  key_name = var.key_name
  vpc_security_group_ids = [aws_security_group.abhishek_sg.id]

  provisioner "local-exec" {
    command = "echo Instance is Running and public Ip is ${self.public_ip} and private Ip is ${self.private_ip} >> instance-info.txt"
  }

  tags = {
    Name = "${var.environment}-web-server"
    Environment = var.environment
  }
}