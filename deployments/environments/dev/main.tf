terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "ap-northeast-1"
  default_tags {
    # service全体で適用する共通タグ. 同一キーで上書きしたい場合module単位でprovider定義することで上書き可能
    tags = {
      "Group" : var.project_name
    }
  }
}

module "roles" {
  source       = "../../modules/roles"
  project_name = var.project_name
}

module "batch" {
  source                      = "../../modules/batch"
  project_name                = var.project_name
  batch_vpc_id                = var.batch_vpc_id
  batch_subnet_ids            = var.batch_subnet_ids
  batch_service_role_arn      = module.roles.batch_service_role_arn
  ecs_task_execution_role_arn = module.roles.ecs_task_execution_role_arn
  container_image             = var.container_image
  container_image_version     = var.image_version

}

module "events" {
  source                              = "../../modules/events"
  project_name                        = var.project_name
  batch_service_event_target_role_arn = module.roles.batch_service_event_target_role_arn
  batch_job_queue_arn                 = module.batch.batch_job_queue_arn
  batch_job_parameter_refresh_all = {
    is_enabled         = false
    job_name           = module.batch.batch_job_definition_name_refresh_all
    job_definition_arn = module.batch.batch_job_definition_arn_refresh_all
  }
}