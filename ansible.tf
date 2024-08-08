variable "web_provision" {
  type        = bool
  default     = true
  description = "ansible provision switch variable"
}



resource "local_file" "hosts_cfg" {
  content = templatefile("${path.module}/hosts.tftpl",
    {
      webservers = aws_instance.web,
      databases  = aws_instance.db,
      storage    = aws_instance.storage
    }
  )
  filename = "${abspath(path.module)}/hosts.cfg"
}

