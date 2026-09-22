
resource "aws_instance" "example" {
  ami           = var.instance_ami_id
  instance_type = var.instance_type
  subnet_id = var.subnet_id

  tags = {
    Name = "${var.enviroment}-web-server"
    Enviroment = var.enviroment
  }
}