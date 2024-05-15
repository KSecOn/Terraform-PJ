resource "aws_instance" "public_instance" {
  ami           = "ami-04716897be83e3f04"
  availability_zone = "us-east-1"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public_subnet.id
}

resource "aws_instance" "private_instance" {
  ami           = "ami-04716897be83e3f04"
  availability_zone = "us-east-1"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.private_subnet.id
}