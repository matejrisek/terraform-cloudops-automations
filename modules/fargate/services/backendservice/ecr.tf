resource "aws_ecr_repository" "ecr_repo" {
  #ts:skip=AWS.AER.DP.MEDIUM.0058 policy is at iam level so skip it
  #ts:skip=AWS.AER.DP.MEDIUM.0026 Default encryption is used
  count = var.create_ecr_rep ? 1 : 0
  name = "${var.application_code}-${var.microservice_code}-${var.env}"
}

resource "aws_ecr_lifecycle_policy" "ecr_repo_policy" {
  count = var.create_ecr_rep ? 1 : 0
  repository = aws_ecr_repository.ecr_repo[0].name
  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Keep last 3 images",
            "selection": {
                "tagStatus": "any",
                "countType": "imageCountMoreThan",
                "countNumber": 3
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}


resource "aws_ecr_repository_policy" "ecr_repo_policy" {
  count = var.create_ecr_rep && var.create_ecr_permission_policy ? 1 : 0
  repository = aws_ecr_repository.ecr_repo[0].name
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowPushPull",
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          "${var.ecs-task-execution-role-arn}", 
          "${var.code-deploy-role-arn}"
          ]
      },
      "Action": [
        "ecr:BatchCheckLayerAvailability",
        "ecr:BatchGetImage",
        "ecr:CompleteLayerUpload",
        "ecr:GetDownloadUrlForLayer",
        "ecr:InitiateLayerUpload",
        "ecr:PutImage",
        "ecr:UploadLayerPart"
      ]
    }
  ]
}
EOF
}