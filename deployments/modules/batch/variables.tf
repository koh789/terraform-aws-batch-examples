variable "project_name" {
  type     = string
  nullable = false
}

variable "batch_vpc_id" {
  type     = string
  nullable = false
  validation {
    condition     = startswith(var.batch_vpc_id, "vpc-")
    error_message = "VpcId must be prefixed with vpc-"
  }
}

variable "batch_subnet_ids" {
  type     = list(string)
  nullable = false
  validation {
    condition = alltrue([
      for sid in var.batch_subnet_ids : startswith(sid, "subnet-")
    ])
    error_message = "SubnetId must be prefixed with subnet-."
  }
}

variable "batch_service_role_arn" {
  type     = string
  nullable = false
}

variable "ecs_task_execution_role_arn" {
  type     = string
  nullable = false
}

variable "container_image" {
  type     = string
  nullable = false
}

variable "container_image_version" {
  type     = string
  nullable = false
  default  = "latest"
}