
locals {
  batch_service_role_name              = "${var.project_name}-service-role"
  ecs_task_execution_role_name         = "${var.project_name}-ecs-task-execution-role"
  batch_service_event_target_role_name = "${var.project_name}-service-event-target-role"
}

resource "aws_iam_role" "batch_service_role" {
  name                = local.batch_service_role_name
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AWSBatchServiceRole"]
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "batch.amazonaws.com"
        }
      }
    ]
  })
  tags = {
    "Name" : local.batch_service_role_name,
  }
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name                = local.ecs_task_execution_role_name
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"]
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
  tags = {
    "Name" : local.ecs_task_execution_role_name,
  }
}

resource "aws_iam_role" "batch_service_event_target_role" {
  name                = local.batch_service_event_target_role_name
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AWSBatchServiceEventTargetRole"]
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "events.amazonaws.com"
        }
      }
    ]
  })
  tags = {
    Name : local.batch_service_event_target_role_name,
  }
}
