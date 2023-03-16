variable "batch_vpc_id" {
  type     = string
  nullable = false
}

variable "batch_subnet_ids" {
  type     = list(string)
  nullable = false
}

variable "project_name" { # tagやnameで使用しています
  type     = string
  nullable = false
}

variable "container_image" {
  type     = string
  nullable = false
}

variable "image_version" {
  type     = string
  nullable = false
}