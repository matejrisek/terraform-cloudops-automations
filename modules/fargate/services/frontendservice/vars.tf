variable "init_image" {type = string }
variable "microservice_code" {type = string  }
variable "microservice_description" { type = string }
variable "microservice_port" { type = string }
variable "application_code"{type = string }
variable "application_description" {type = string }
variable "vpc_id"{type = string }
variable "vpc_private_subnets_containers_list"{type = list(string) }
variable "fargate_cluster_name" {type = string }
variable "fargate_cluster_id" {type = string }
variable "alb_lstnr_arn" {type = string }
variable "alb_test_listener_arn" {type = string}
variable "env" { type = string }
variable "code-deploy-role-arn" {type = string }
variable "code-build-role-arn" {type = string }
variable "ecs-task-execution-role-arn" {type = string }
variable "code-pipe-line-role-arn" {type = string }
variable "create_code_build" {type = bool }
variable "create_ecr_rep" {type = bool }
variable "kms_custom_managed_key_arn" {type = string }
variable "code-pipe-line-cw-role" {type = string }
variable "security_group_id_list" {type = list(string) }
variable "s3_prefix" {type = string}
variable "branch_name" {type = string}
variable "alb_target_group_blue_name" {type = string}
variable "alb_target_group_green_name" {type = string }
variable "ecs_lb_blue_target_group_arn" {type = string }
variable "service_count" {type=number}
variable "build_wait_time_minutes" {type = number}

data "aws_availability_zones" "available" {}
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

variable "task_cpu" {type = number}
variable "task_memory" {type = number}

variable "task_secrets" {
  default     = []
  description = "The secrets to pass to a container"
  type        = list(map(string))
}
variable "outputArtifactFormat" { type =string}
variable "gilab_connection_arn" {type = string}
variable "gitlab_repo_id" {type = string}
variable "gitlab_repo_prefix" {type = string}
variable "auto_trigger_pipeline" {type=bool}
variable "auto_scale" {type = bool}
variable "auto_scale_max_capacity" { type = number}
variable "create_ecr_permission_policy" { type = bool}
variable "auto-scale-role-arn" { type = string }

