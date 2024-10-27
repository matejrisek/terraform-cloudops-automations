variable "env" {type = string}
variable "fargate_clstr_name" {type = string}
variable "alb_security_group_id_list" {type = list(string)}
variable "vpc_private_subnets_compute_list"{type = list(string) }
variable "https_certificate_arn" {type = string}
variable "application_description" {type = string}
variable "vpc_id"{type = string}
variable "application_code"{type = string}
variable "default_healthurl" {type = string}
variable "default_microservice_port" {type = string}