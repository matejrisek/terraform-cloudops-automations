resource "aws_ecs_task_definition" "ecs_tsk_def" {
  family             = "${var.application_code}-${var.microservice_code}-${var.env}"
  execution_role_arn = var.ecs-task-execution-role-arn
  task_role_arn      = var.ecs-task-execution-role-arn
  cpu                = var.task_cpu
  memory             = var.task_memory
  network_mode       = "awsvpc"
  requires_compatibilities = [
    "FARGATE"
  ]

  runtime_platform {
    operating_system_family = "LINUX"
  }

  container_definitions = jsonencode([
    {
      name      = "${var.application_code}-${var.microservice_code}"
      image     = "${var.init_image}"
      cpu       = var.task_cpu
      memory    = var.task_memory
      essential = true
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          awslogs-group         = "/ecs/${var.application_code}-${var.microservice_code}-${var.env}",
          awslogs-region        = "${data.aws_region.current.name}",
          awslogs-stream-prefix = "ecs",
          awslogs-create-group  = "true"
        }
      }
      secrets = var.task_secrets

      portMappings = [
        {
          containerPort = tonumber(var.microservice_port)
          protocol = "tcp"
          hostPort      = tonumber(var.microservice_port)
        }
      ]
    }
  ])
}