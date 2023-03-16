
output "batch_service_role_arn" {
  value       = aws_iam_role.batch_service_role.arn
  description = "AWS Batch service role. Used in a computing environment."
}

output "ecs_task_execution_role_arn" {
  value       = aws_iam_role.ecs_task_execution_role.arn
  description = "Role for executing ecs task of AWS Batch."
}

output "batch_service_event_target_role_arn" {
  value       = aws_iam_role.batch_service_event_target_role.arn
  description = "Role for event bridge."
}