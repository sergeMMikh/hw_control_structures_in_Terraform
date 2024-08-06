resource "aws_vpc" "develop" {
  cidr_block       = var.default_cidr
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "develop" {
  tags = {
    Name = var.vpc_name
  }

  vpc_id            = aws_vpc.develop.id
  cidr_block        = var.default_cidr
  availability_zone = var.availability_zone

}
