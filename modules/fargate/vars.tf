variable "ecs-task-execution-role-arn" { type = string }
variable "vpc_id" { type = string }
variable "vpc_private_subnets_serverless_list" { type = list(string) }
variable "application_code" { type = string }
variable "application_description" { type = string }
variable "env" { type = string }
variable "create_code_build" { type = bool }
variable "create_ecr_rep" { type = bool }
variable "code-build-role-arn" { type = string }
variable "code-deploy-role-arn" { type = string }
variable "code-pipe-line-role-arn" { type = string }
variable "https_certificate_arn" { type = string }
variable "kms_custom_managed_key_arn" { type = string }
variable "code-pipe-line-cw-role" { type = string }
variable "security_group_id_list" { type = list(string) }
variable "tag_cost_center" { type = string }
variable "tag_contact_email" { type = string }
variable "tag_application" { type = string }
variable "tag_owner_email" { type = string }
variable "tag_platform" { type = string }
variable "tag_purpose" { type = string }
variable "tag_business_function" { type = string }
variable "tag_env" { type = string }
variable "tag_namespace" {type = string}
variable "gitlab_repo_prefix" {type = string}
variable "gilab_connection_arn" {type = string}
variable "auto_trigger_pipeline" {type=bool}
variable "outputArtifactFormat" { type =string}


variable "auto_scale" {type = bool}
variable "auto_scale_max_capacity" { type = number}

variable "frontend_task_cpu" {type = number}
variable "frontend_task_memory" {type = number}
variable "frontend_service_image" {type = string}
variable "frontend_service_code" {type = string}
variable "frontend_service_description" {type = string}
variable "frontend_service_port" {type = number}
variable "frontend_service_branch_name" {type = string}
variable "frontend_service_count" {type = number}
variable "frontend_service_gitlab_repo" {type = string}

variable "micro_service_1_task_cpu" {type = number}
variable "micro_service_1_task_memory" {type = number}
variable "micro_service_1_service_image" {type = string}
variable "micro_service_1_service_code" {type = string}
variable "micro_service_1_service_description" {type = string}
variable "micro_service_1_service_port" {type = number}
variable "micro_service_1_service_branch_name" {type = string}
variable "micro_service_1_service_count" {type = number}
variable "micro_service_1_service_gitlab_repo" {type = string}
variable "micro_service_1_service_secrets" {
  default     = []
  description = "The secrets to pass to a container"
  type        = list(map(string))
}

variable "s3_prefix" {type = string}
variable "build_wait_time_minutes" {type = number}
variable "create_ecr_permission_policy" { type = bool}
variable "auto-scale-role-arn" { type = string }
