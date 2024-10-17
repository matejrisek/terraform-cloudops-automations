resource "aws_iam_policy" "cloudWatchPolicy" {
  name        = "${var.NameSpace}_${var.AccountEnv}_cloudwatch_access"
  description = "${var.NameSpace}_${var.AccountEnv}_cloudwatch_access"

  # Terraform"s "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid = "UniversalAllow"
        Action = [
          "autoscaling:Describe*",
          "cloudwatch:Describe*",
          "cloudwatch:Get*",
          "cloudwatch:List*",
          "cloudwatch:PutMetricData",
          "cloudwatch:Link",
          "cloudwatch:PutManagedInsightRules",
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:PutRetentionPolicy",
          "logs:PutResourcePolicy",
          "logs:Describe*",
          "logs:Get*",
          "logs:List*",
          "logs:*Query*",
          "logs:StartQuery*",
          "logs:StopQuery",
          "logs:*LiveTail*",
          "logs:TestMetricFilter",
          "logs:FilterLogEvents",
          "events:PutPartnerEvents",
          "events:List*",
          "events:TestEventPattern",
          "scheduler:List*"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Sid = "BoundedCWByARN"
        Action = [
          "cloudwatch:*"
        ]
        Effect   = "Allow"
        Resource =[
          "arn:aws:cloudwatch:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:metric-stream/${var.NameSpace}*",
          "arn:aws:cloudwatch:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:insight-rule/${var.NameSpace}*",
          "arn:aws:cloudwatch::${data.aws_caller_identity.current.account_id}:dashboard/${var.NameSpace}*",
          "arn:aws:cloudwatch:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:alarm:${var.NameSpace}*"
        ]
      },
      {
        Sid = "CloudWatchEvents"
        Action = [
          "events:*"
        ]
        Effect   = "Allow"
        Resource =[
          "arn:aws:events:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:event-bus/${var.NameSpace}*",
          "arn:aws:events:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:event-bus/default",
          "arn:aws:events:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:event-source/${var.NameSpace}*",
          "arn:aws:events:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:rule/${var.NameSpace}*"
        ]
      },
      {
        Sid = "TagAndDeleteLogGroups"
        Action = [
          "logs:TagLogGroup",
          "logs:UntagLogGroup",
          "logs:DeleteLogGroup",
          "logs:DeleteResourcePolicy"
        ]
        Effect   = "Allow"
        Resource ="arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:*/${var.NameSpace}*"
      },
      {
        Sid = "CloudWatchScheduler"
        Action = [
          "scheduler:*"
        ]
        Effect   = "Allow"
        Resource =[
          "arn:aws:scheduler:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:schedule/${var.NameSpace}*/${var.NameSpace}*",
          "arn:aws:scheduler:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:schedule-group/${var.NameSpace}*"
        ]
      }
    ]
  })
}