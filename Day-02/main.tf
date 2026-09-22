resource "aws_instance" "example" {
  ami           = "ami-01a00762f46d584a1"
  instance_type = "t3.micro"
  subnet_id = "subnet-0c720d9563977ae68"

  tags = {
    Name = "tf_example-instance"
  }
}