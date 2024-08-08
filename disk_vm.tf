resource "aws_ebs_volume" "storage_disks" {
  count = 3

  availability_zone = data.aws_availability_zones.av_zone.names[0]
  size              = 1
  type              = "gp2"

  tags = {
    Name = "storage-disk-${count.index + 1}"
  }
}


resource "aws_instance" "storage" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  availability_zone = data.aws_availability_zones.av_zone.names[0]

  tags = {
    Name     = "storage"
    Owner    = var.Owner
    Project  = var.Project
    Platform = var.Platform
  }

  root_block_device {
    volume_size = 8
  }
}


resource "aws_volume_attachment" "ebs_attachments" {
  count = length(aws_ebs_volume.storage_disks)

  device_name = element(["/dev/sdf", "/dev/sdg", "/dev/sdh"], count.index)
  volume_id   = aws_ebs_volume.storage_disks[count.index].id
  instance_id = aws_instance.storage.id
}
