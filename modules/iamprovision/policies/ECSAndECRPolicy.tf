resource "aws_iam_policy" "ecsAndEcrPolicy" {
  name        = "${var.NameSpace}_${var.AccountEnv}_ecs_ecr_access"
  path        = "/"
  description = "${var.NameSpace}_${var.AccountEnv}_ecs_ecr_access"

  # Terraform"s "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "UniversalAllowECR"
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:DescribeRepositories",
          "ecr:CreateRepository"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Sid = "BoundedByNamespaceECR"
        Action = [
          "ecr:*"
        ]
        Effect   = "Allow"
        Resource ="arn:aws:ecr:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:repository/${var.NameSpace}*"
      },
      {
        Sid = "UniversalAllowECS"
        Action = [
          "ecs:Describe*",
          "ecs:List*",
          "ecs:RegisterTaskDefinition",
          "ecs:DeregisterTaskDefinition",
          "ecs:CreateCluster",
          "ecs:CreateTaskSet"
        ]
        Effect   = "Allow"
        Resource ="*"
      }
    ]
  })
}