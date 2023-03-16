
locals {
  events_refresh_all = "${var.batch_job_parameter_refresh_all.job_name}-event"
}

resource "aws_cloudwatch_event_rule" "event_rule_refresh_all" {
  name                = local.events_refresh_all
  schedule_expression = "cron(00 16 * * ? *)" # jst 00
  is_enabled          = var.batch_job_parameter_refresh_all.is_enabled
  tags = {
    Name = local.events_refresh_all
  }
}

resource "aws_cloudwatch_event_target" "event_target_refresh_all" {
  target_id = var.batch_job_parameter_refresh_all.job_name
  arn       = var.batch_job_queue_arn
  rule      = aws_cloudwatch_event_rule.event_rule_refresh_all.name
  role_arn  = var.batch_service_event_target_role_arn
  batch_target {
    job_definition = var.batch_job_parameter_refresh_all.job_definition_arn
    job_name       = var.batch_job_parameter_refresh_all.job_name
  }
}
