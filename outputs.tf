output "hosts_config" {
  value = nonsensitive(templatefile("${path.module}/hosts.tftpl",
    {
      webservers = aws_instance.web,
      databases  = aws_instance.db,
      storage    = aws_instance.storage
    }
    )
  )
}

