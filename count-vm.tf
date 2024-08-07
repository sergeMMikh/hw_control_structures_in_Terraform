data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  count         = 2
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.vm_web_instance_type

  key_name = var.key_name


  subnet_id                   = aws_default_subnet.develop.id
  associate_public_ip_address = true

  availability_zone = data.aws_availability_zones.av_zone.names[0]

  tags = {
    Name     = " web-${count.index + 1}"
    Owner    = "SMMikh"
    Project  = "hw_control_structures_in_Terraform."
    Platform = "Ubuntu"
  }

  vpc_security_group_ids = [
    aws_security_group.example.id,
  ]

  lifecycle {
    create_before_destroy = true
  }
}
