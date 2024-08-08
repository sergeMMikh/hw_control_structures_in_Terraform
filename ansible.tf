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

# resource "null_resource" "web_hosts_provision" {
#   count = var.web_provision == true ? 1 : 0
#   #Ждем создания инстанса
#   depends_on = [aws_instance.web, aws_instance.storage, aws_instance.db]

#   #Добавление ПРИВАТНОГО ssh ключа в ssh-agent
#   provisioner "local-exec" {
#     command    = "eval $(ssh-agent) && cat ./.ssh/id_ed25519 | ssh-add -"
#     on_failure = continue #Продолжить выполнение terraform pipeline в случае ошибок

#   }
# }

# resource "local_file" "hosts_cfg" {
#   content = templatefile("${path.module}/hosts.tftpl",
#     { webservers = [aws_instance.web]
#       databases  = [aws_instance.db]
#     storage = [aws_instance.storage] }
#   )
#   filename = "${abspath(path.module)}/hosts.cfg"
# }
