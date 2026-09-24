resource "aws_instance" "abhishek" {
  ami           = var.instance_ami_id
  instance_type = var.instance_type
  subnet_id = var.subnet_id
  # count = var.no_of_instance
  key_name = var.key_name
  vpc_security_group_ids = [aws_security_group.abhishek_sg.id]

provisioner "file" {
  source      = "D:\\Learning_Teraform_For_Abhishek\\Day-03\\index.html"
  destination = "/home/ubuntu/index.html"

  connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = file("D:\\Learning_Teraform_For_Abhishek\\Day-03\\ssh-key.pem")
    host     = self.public_ip
    timeout = "2m"
  }
}
  tags = {
    Name = "${var.environment}-web-server"
    Environment = var.environment
  }
}