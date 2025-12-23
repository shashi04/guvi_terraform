locals {
  instance_type = var.instance_type
  region        = var.region
}

provider "aws" {
  region = local.region
}

data "aws_security_group" "existing_sg" {
  id = "sg-0abc1234def567890" # replace with your actual SG ID
}

resource "aws_instance" "demo_ec2" {
  ami           = "ami-0abcdef12345"
  instance_type = local.instance_type
  key_name      = "my-key-pair"

  vpc_security_group_ids = [
    data.aws_security_group.existing_sg.id
  ]
  tags = {
    Name = var.instance_name
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("my-key.pem")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y nginx",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx"
    ]
  }
}

resource "aws_s3_bucket" "demo_bucket" {
  bucket = "my-demo-bucket-123456"
}

