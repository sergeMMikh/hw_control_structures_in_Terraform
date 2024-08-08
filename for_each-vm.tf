variable "each_vm" {
  type = list(object(
    {
      vm_name = string,
      cpu     = string,
      #   ram         = number,
      disk_volume = number
    }
  ))
  default = [
    {
      vm_name = "main",
      cpu     = "t2.micro",
      #   ram         = 1,
      disk_volume = 8
    },
    {
      vm_name = "replica",
      cpu     = "t2.medium",
      #   ram         = 4,
      disk_volume = 10
    }
  ]
}

resource "aws_instance" "db" {
  for_each = { for vm in var.each_vm : vm.vm_name => vm }

  ami           = data.aws_ami.ubuntu.id
  instance_type = each.value.cpu

  root_block_device {
    volume_size = each.value.disk_volume
  }

  tags = {
    Name     = each.value.vm_name
    Owner    = var.Owner
    Project  = var.Project
    Platform = var.Platform
  }

  key_name = var.key_name

  subnet_id                   = aws_default_subnet.develop.id
  associate_public_ip_address = true

  availability_zone = data.aws_availability_zones.av_zone.names[0]

  vpc_security_group_ids = [
    aws_security_group.example.id,
  ]

  #   lifecycle {
  #     create_before_destroy = true
  #   }

  depends_on = [
    aws_instance.web
  ]
}

# resource "aws_instance" "db" {
#   count         = 2
#   ami           = data.aws_ami.ubuntu.id
#   instance_type = var.vm_web_instance_type

#   key_name = var.key_name


#   subnet_id                   = aws_default_subnet.develop.id
#   associate_public_ip_address = true

#   availability_zone = data.aws_availability_zones.av_zone.names[0]

#   tags = {
#     Name     = " web-${count.index + 1}"
#     Owner    = "SMMikh"
#     Project  = "hw_control_structures_in_Terraform."
#     Platform = "Ubuntu"
#   }

#   vpc_security_group_ids = [
#     aws_security_group.example.id,
#   ]

#   lifecycle {
#     create_before_destroy = true
#   }

#   depends_on = [
#     aws_instance.web
#   ]
# }
