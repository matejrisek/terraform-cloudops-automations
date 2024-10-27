resource "aws_appautoscaling_target" "ecs_plsy_target" {
  count = var.auto_scale ? 1 : 0
  max_capacity = var.auto_scale_max_capacity
  min_capacity = 1
  resource_id = "service/${var.fargate_cluster_name}/${aws_ecs_service.ecs_serv.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace = "ecs"
  role_arn = var.auto-scale-role-arn
}

resource "aws_appautoscaling_policy" "ecs_plsy_memory" {
  count = var.auto_scale ? 1 : 0
  name               = "${var.application_code}-${var.microservice_code}-${var.env}-scale-mem"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_plsy_target[0].resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_plsy_target[0].scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_plsy_target[0].service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }
    target_value       = 80
  }
}

resource "aws_appautoscaling_policy" "ecs_plsy_cpu" {
  count = var.auto_scale ? 1 : 0
  name = "${var.application_code}-${var.microservice_code}-${var.env}-scale-cpu"
  policy_type = "TargetTrackingScaling"
  resource_id = aws_appautoscaling_target.ecs_plsy_target[0].resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_plsy_target[0].scalable_dimension
  service_namespace = aws_appautoscaling_target.ecs_plsy_target[0].service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
    target_value = 75
  }
}