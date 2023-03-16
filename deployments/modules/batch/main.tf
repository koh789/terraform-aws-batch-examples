
locals {
  batch_sg_name                    = "${var.project_name}-sg"
  batch_compute_environment_name   = "${var.project_name}-compute-environment"
  batch_job_queue_name             = "${var.project_name}-job-queue"
  batch_job_definition_refresh_all = "${var.project_name}-refresh-all"
}


resource "aws_security_group" "batch_security_group" {
  name        = local.batch_sg_name
  description = local.batch_sg_name
  vpc_id      = var.batch_vpc_id
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = local.batch_sg_name
  }
}

resource "aws_batch_compute_environment" "batch_compute_environment" {
  compute_environment_name = local.batch_compute_environment_name
  type                     = "MANAGED"
  state                    = "ENABLED"
  service_role             = var.batch_service_role_arn
  compute_resources {
    max_vcpus          = 256
    security_group_ids = [aws_security_group.batch_security_group.id]
    subnets            = var.batch_subnet_ids
    type               = "FARGATE"
  }
  tags = {
    Name : local.batch_compute_environment_name
  }
}
resource "aws_batch_job_queue" "batch_job_queue" {
  name     = local.batch_job_queue_name
  priority = 1
  state    = "ENABLED"
  compute_environments = [
    aws_batch_compute_environment.batch_compute_environment.arn
  ]
  tags = {
    Name : local.batch_job_queue_name
  }
}

resource "aws_batch_job_definition" "batch_job_definition_refresh_all" {
  name                  = local.batch_job_definition_refresh_all
  type                  = "container"
  platform_capabilities = ["FARGATE"]
  propagate_tags        = true
  parameters = {
    SummaryTypes : "-",
    StartAt : "-",
    EndAt : "-",
    AccountId : "-",
    AccountControlStatuses : "-",
    UpdatedSinceAt : "-"
  }
  container_properties = jsonencode({
    command = [
      "--proc", "all",
      "--start", "Ref::StartAt",
      "--end", "Ref::EndAt",
      "--summaryTypes", "Ref::SummaryTypes",
      "--updatedSince", "Ref::UpdatedSinceAt",
      "--aid", "Ref::AccountId",
      "--accountStatuses", "Ref::AccountControlStatuses"
    ],
    image = "${var.container_image}:${var.container_image_version}"

    resourceRequirements = [
      {
        type  = "VCPU"
        value = "16"
      },
      {
        type  = "MEMORY"
        value = "32768"
      }
    ],
    executionRoleArn = var.ecs_task_execution_role_arn
    networkConfiguration = {
      assignPublicIp = "ENABLED"
    }
  })
  tags = {
    Name : local.batch_job_definition_refresh_all
  }
}
