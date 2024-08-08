locals {
  ssh_key = file("${path.module}/.ssh/id_rsa.pub")
}
