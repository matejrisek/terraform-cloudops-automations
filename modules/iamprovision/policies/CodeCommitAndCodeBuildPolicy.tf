resource "aws_iam_policy" "codecommitAndCodeBuildPolicy" {
  name        = "${var.NameSpace}_${var.AccountEnv}_codecommit_codebuild_access"
  path        = "/"
  description = "${var.NameSpace}_${var.AccountEnv}_codecommit_codebuild_access"

  # Terraform"s "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "UniversalAllowCodeCommit"
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
        Sid = "BoundedByNamespaceCodeCommit"
        Action = [
          "codecommit:*"
        ]
        Effect   = "Allow"
        Resource ="arn:aws:codecommit:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${var.NameSpace}*"
      },
      {
        Sid = "UniversalAllowCodeBuild"
        Action = [
          "codebuild:Get*",
          "codebuild:List*",
          "codebuild:ImportSourceCredentials",
          "codebuild:DeleteOAuthToken",
          "codebuild:DeleteSourceCredentials",
          "codebuild:PersistOAuthToken",
          "ec2:Describe*",
          "ec2:CreateNetworkInterface",
          "ec2:DeleteNetworkInterface",
          "ec2:AssignPrivateIpAddresses",
          "ec2:UnassignPrivateIpAddresses",
          "ec2:CreateNetworkInterfacePermission"
        ]
        Effect   = "Allow"
        Resource ="*"
      },
      {
        Sid = "BoundedByNamespaceCodeBuild"
        Action = [
          "codebuild:*"
        ]
        Effect   = "Allow"
        Resource =[
          "arn:aws:codebuild:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:report-group/${var.NameSpace}*",
          "arn:aws:codebuild:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:project/${var.NameSpace}*"
        ]
      }
    ]
  })
}