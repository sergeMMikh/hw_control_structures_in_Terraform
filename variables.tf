variable "region" {
  type        = string
  description = "The instance region"
  sensitive   = true
}

variable "access_key" {
  type        = string
  description = "The access key"
  sensitive   = true
}

variable "secret_key" {
  type        = string
  description = "The secret access key"
  sensitive   = true
}

variable "key_name" {
  type        = string
  description = "The Key pair name"
  sensitive   = true
}

variable "vm_web_instance_type" {
  type        = string
  description = "The type of instance"
  default     = "t2.micro"
}

variable "Owner" {
  type        = string
  description = "The project owner"
  default     = "SMMikh"
}

variable "Project" {
  type        = string
  description = "Project_name"
  default     = "hw_control_structures_in_Terraform."
}

variable "Platform" {
  type        = string
  description = "The instance platform"
  default     = "Ubuntu"
}

