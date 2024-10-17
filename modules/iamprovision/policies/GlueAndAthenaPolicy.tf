resource "aws_iam_policy" "glueAndAthenaPolicy" {
  name        = "${var.NameSpace}_${var.AccountEnv}_glue_athena_access"
  description = "${var.NameSpace}_${var.AccountEnv}_glue_athena_access"

  # Terraform"s "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "UniversalAllow"
        Action = [
          "glue:*Table*",
          "glue:*Database",
          "glue:*Connection*",
          "glue:*Job*",
          "glue:*Crawler*",
          "glue:*Connection*",
          "glue:*Trigger*",
          "glue:*Workflow*",
          "glue:*Schema*",
          "glue:*Regist*"
        ]
        Effect   = "Allow"
        Resource = [
          "arn:aws:glue:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:database/${var.NameSpace}*",
          "arn:aws:glue:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/${var.NameSpace}*/*",
          "arn:aws:glue:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:job/${var.NameSpace}*",
          "arn:aws:glue:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:connection/${var.NameSpace}*",
          "arn:aws:glue:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:crawler/${var.NameSpace}*",
          "arn:aws:glue:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:trigger/${var.NameSpace}*",
          "arn:aws:glue:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:workflow/${var.NameSpace}*",
          "arn:aws:glue:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:schema/${var.NameSpace}*",
          "arn:aws:glue:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:registry/${var.NameSpace}*",
          "arn:aws:glue:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:devEndpoint/${var.NameSpace}*",
          "arn:aws:glue:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:userDefinedFunction/${var.NameSpace}*/${var.NameSpace}*",
          "arn:aws:glue:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:blueprint/${var.NameSpace}*",
          "arn:aws:glue:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:database/default",
          "arn:aws:glue:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:catalog"
        ]
      },
      {
        Sid = "UniversalAccess"
        Action = [
          "glue:List*",
          "glue:*Get*",
          "glue:BatchCreatePartition",
          "glue:CreateJob",
          "glue:DeleteJob",
          "glue:ResetJobBookmark",
          "glue:StartJobRun",
          "glue:BatchStopJobRun",
          "glue:UpdateCrawlerSchedule",
          "glue:StartCrawlerSchedule",
          "glue:StopCrawlerSchedule",
          "glue:CreateTrigger",
          "glue:CreateWorkflow",
          "glue:CreateCrawler",
          "glue:CreateScript",
          "glue:CheckSchemaVersionValidity",
          "glue:CreateClassifier",
          "glue:CreateBlueprint",
          "glue:DeleteClassifier",
          "glue:CreateSession",
          "glue:UpdateClassifier",
          "glue:CreateWorkflow",
          "glue:CreateMLTransform"
        ]
        Effect   = "Allow"
        Resource ="*"

      },
      {
        Sid = "OtherPermission"
        Action = [
          "ec2:DescribeVpcEndpoints",
          "ec2:DescribeRouteTables",
          "ec2:CreateNetworkInterface",
          "ec2:DeleteNetworkInterface",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeSubnets",
          "ec2:DescribeVpcAttribute",
          "iam:ListRolePolicies",
          "iam:GetRole",
          "iam:GetRolePolicy",
          "cloudwatch:PutMetricData"
        ]
        Effect   = "Allow"
        Resource ="*"
      },
      {
        Sid = "AthenaUniversalAccess"
        Action = [
          "athena:Get*",
          "athena:List*",
          "athena:StartQueryExecution",
          "athena:CreateNamedQuery",
          "athena:StopQueryExecution",
          "athena:BatchGetQueryExecution"
        ]
        Effect   = "Allow"
        Resource ="*"
      },
      {
        Sid = "LogGroupAccess"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource ="*arn:aws:logs:*:*:/aws-glue/*"
      }
    ]
  })
}