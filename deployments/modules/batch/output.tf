output "batch_job_queue_arn" {
  value       = aws_batch_job_queue.batch_job_queue.arn
  description = "AWS Batch job queue arn"
}

output "batch_job_definition_arn_refresh_all" {
  value       = aws_batch_job_definition.batch_job_definition_refresh_all.arn
  description = "AWS Batch job definition arn for refresh_all"
}

output "batch_job_definition_name_refresh_all" {
  value       = aws_batch_job_definition.batch_job_definition_refresh_all.name
  description = "AWS Batch job definition name for refresh_all"
}
