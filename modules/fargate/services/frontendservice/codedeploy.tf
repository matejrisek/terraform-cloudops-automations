resource "aws_codedeploy_app" "cd_dply_prj" {
  compute_platform = "ECS"
  name             = "${var.application_code}-${var.microservice_code}-${var.env}"
}

resource "aws_codedeploy_deployment_group" "cd_dply_grp" {
  app_name               = aws_codedeploy_app.cd_dply_prj.name
  deployment_config_name = "CodeDeployDefault.ECSAllAtOnce"
  deployment_group_name  = "${var.application_code}-${var.microservice_code}-deploy-grp-${var.env}"
  service_role_arn       = var.code-deploy-role-arn

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  blue_green_deployment_config {
    deployment_ready_option {
      action_on_timeout = "CONTINUE_DEPLOYMENT"
      wait_time_in_minutes = 0
    }
    terminate_blue_instances_on_deployment_success {
      action                           = "TERMINATE"
      termination_wait_time_in_minutes = var.build_wait_time_minutes
    }
  }

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }

  ecs_service {
    cluster_name = var.fargate_cluster_name
    service_name = aws_ecs_service.ecs_serv.name
  }

  load_balancer_info {
    target_group_pair_info {

      prod_traffic_route {
        listener_arns = [var.alb_lstnr_arn]
      }

      target_group {
        name = var.alb_target_group_blue_name
      }
      target_group {
        name = var.alb_target_group_green_name
      }

      test_traffic_route {
        listener_arns = [var.alb_test_listener_arn]
      }
    }
  }
}
