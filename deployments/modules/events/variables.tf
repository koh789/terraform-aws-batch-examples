variable "project_name" {
  type     = string
  nullable = false
}

variable "batch_service_event_target_role_arn" {
  type     = string
  nullable = false
}

variable "batch_job_queue_arn" {
  type     = string
  nullable = false
}


variable "batch_job_parameter_refresh_all" {
  type = object({
    is_enabled         = bool
    job_name           = string
    job_definition_arn = string
  })
  nullable = false
}
