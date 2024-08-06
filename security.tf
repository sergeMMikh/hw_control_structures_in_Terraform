variable "security_group_ingress" {
  description = "secrules ingress"
  type = list(object(
    {
      protocol       = string
      description    = string
      v4_cidr_blocks = list(string)
      port           = optional(number)
      from_port      = optional(number)
      to_port        = optional(number)
  }))
  default = [
    {
      name           = "ssh_rule"
      protocol       = "TCP"
      description    = "allow incoming ssh"
      v4_cidr_blocks = ["0.0.0.0/0"]
      port           = 22
    },
    {
      name           = "http_rule"
      protocol       = "TCP"
      description    = "allow incoming http"
      v4_cidr_blocks = ["0.0.0.0/0"]
      port           = 80
    },
    {
      name           = "https_rule"
      protocol       = "TCP"
      description    = "allow incoming https"
      v4_cidr_blocks = ["0.0.0.0/0"]
      port           = 443
    },
  ]
}


variable "security_group_egress" {
  description = "secrules egress"
  type = list(object(
    {
      protocol       = string
      description    = string
      v4_cidr_blocks = list(string)
      port           = optional(number)
      from_port      = optional(number)
      to_port        = optional(number)
  }))
  default = [
    {
      name           = "allow_all_rule"
      protocol       = "TCP"
      description    = "allow all outbound traffic"
      v4_cidr_blocks = ["0.0.0.0/0"]
      from_port      = 0
      to_port        = 65365
    }
  ]
}


resource "aws_security_group" "example" {

  # vpc_id = aws_vpc.develop.id
  vpc_id = data.aws_vpc.develop.id

  # Incoming trafic
  dynamic "ingress" {
    # for_each = ["80", "443", "22"]
    for_each = var.security_group_ingress
    content {
      from_port   = lookup(ingress.value, "port", null)
      to_port     = lookup(ingress.value, "port", null)
      protocol    = lookup(ingress.value, "protocol", null)
      cidr_blocks = lookup(ingress.value, "v4_cidr_blocks", null)
      description = lookup(ingress.value, "description", null)
    }
  }

  # Out trafic
  dynamic "egress" {
    for_each = var.security_group_egress
    content {
      protocol    = lookup(egress.value, "protocol", null)
      from_port   = lookup(egress.value, "from_port", null)
      to_port     = lookup(egress.value, "to_port", null)
      cidr_blocks = lookup(egress.value, "v4_cidr_blocks", null)
    }
  }
  # egress {
  #   from_port   = 0
  #   to_port     = 0
  #   protocol    = "-1"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  tags = {
    Name        = "example_dynamic"
    description = "allow ssh on 22 & http on port 80 & http on port 443"
  }
}
