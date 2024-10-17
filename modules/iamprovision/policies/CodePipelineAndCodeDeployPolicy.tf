resource "aws_iam_policy" "codepipelineAndCodeDeployPolicy" {
  name        = "${var.NameSpace}_${var.AccountEnv}_codepipeline_codedeploy_access"
  path        = "/"
  description = "${var.NameSpace}_${var.AccountEnv}_codepipeline_codedeploy_access"

  # Terraform"s "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "UniversalAllowCodePipeline"
        Action = [
          "codepipeline:Get*",
          "codepipeline:List*",
          "codepipeline:AcknowledgeThirdPartyJob",
          "codepipeline:AcknowledgeJob",
          "codepipeline:PutJobSuccessResult",
          "codepipeline:PutJobFailureResult",
          "codepipeline:PollForThirdPartyJobs",
          "codepipeline:PutThirdPartyJobFailureResult",
          "codepipeline:PutThirdPartyJobSuccessResult"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Sid = "BoundedByNamespaceCodePipeline"
        Action = [
          "codepipeline:*"
        ]
        Effect   = "Allow"
        Resource =[
          "arn:aws:codepipeline:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:actiontype:*/*/${var.NameSpace}*/*",
          "arn:aws:codepipeline:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:webhook:${var.NameSpace}*",
          "arn:aws:codepipeline:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${var.NameSpace}*",
          "arn:aws:codepipeline:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${var.NameSpace}*/${var.NameSpace}*",
          "arn:aws:codepipeline:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${var.NameSpace}*/${var.NameSpace}*/*"
        ]
      },
      {
        Sid = "UniversalAllowCodeDeploy"
        Action = [
          "codedeploy:Get*",
          "codedeploy:*Get*",
          "codedeploy:List*",
          "codedeploy:BatchGetApplications",
          "codedeploy:ContinueDeployment"
        ]
        Effect   = "Allow"
        Resource ="*"
      },
      {
        Sid = "BoundedByNamespaceCodeDeploy"
        Action = [
          "codedeploy:*"
        ]
        Effect   = "Allow"
        Resource =[
          "arn:aws:codedeploy:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:application:${var.NameSpace}*",
          "arn:aws:codedeploy:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:instance:${var.NameSpace}*",
          "arn:aws:codedeploy:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:deploymentconfig:${var.NameSpace}*",
          "arn:aws:codedeploy:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:deploymentgroup:${var.NameSpace}*/${var.NameSpace}*"
        ]
      }
    ]
  })
}