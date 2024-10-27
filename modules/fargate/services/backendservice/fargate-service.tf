resource "aws_ecs_service" "ecs_serv" {
  name            = "${var.application_code}-${var.microservice_code}-${var.env}"
  cluster         = var.fargate_cluster_id
  desired_count   = var.service_count
  task_definition = aws_ecs_task_definition.ecs_tsk_def.arn
  launch_type     = "FARGATE"
  health_check_grace_period_seconds = 247
  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent = 200
  enable_execute_command = true

  network_configuration {
    subnets          = var.vpc_private_subnets_containers_list
    security_groups  = var.security_group_id_list
    assign_public_ip = false
  }

  deployment_controller {
    type = "CODE_DEPLOY"
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.ecs_blue_target_service_group.arn
    container_name   = "${var.application_code}-${var.microservice_code}"
    container_port   = "${var.microservice_port}"
  }

  lifecycle {
    ignore_changes = [
      task_definition,
      desired_count,
      load_balancer,
    ]
  }

  tags = {
    name = "Trak LeadManagement ECS Fargate Service ${var.env}"
  }
  
}
