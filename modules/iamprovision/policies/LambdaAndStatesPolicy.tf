resource "aws_iam_policy" "lambdaAndStatesPolicy" {
  name        = "${var.NameSpace}_${var.AccountEnv}_lambda_stepfunctions_access"
  description = "${var.NameSpace}_${var.AccountEnv}_lambda_stepfunctions_access"

  # Terraform"s "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "UniversalAllowStepFunctions"
        Action = [
          "states:SendTaskSuccess",
          "states:ListStateMachines",
          "states:SendTaskFailure",
          "states:ListActivities",
          "states:CreateActivity",
          "states:StopExecution",
          "states:SendTaskHeartbeat",
          "states:CreateStateMachine"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Sid = "BoundedByNamespaceStepFunctions"
        Action = [
          "states:*",
        ]
        Effect   = "Allow"
        Resource = [
          "arn:aws:states:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:activity:${var.NameSpace}*",
          "arn:aws:states:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:execution:${var.NameSpace}*:*",
          "arn:aws:states:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:stateMachine:${var.NameSpace}*",
          "arn:aws:states:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:stateMachine:${var.NameSpace}*:*",
          "arn:aws:states:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:stateMachine:${var.NameSpace}*:${var.NameSpace}*",
          "arn:aws:states:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:mapRun/${var.NameSpace}*/*:*",
          "arn:aws:states:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:express/${var.NameSpace}*:*:*"
        ]
      },
      {
        Sid = "UniversalAllowLambda"
        Action = [
          "lambda:Get*",
          "lambda:List*",
          "lambda:PublishLayerVersion",
          "lambda:DeleteLayerVersion"
        ]
        Effect   = "Allow"
        Resource = "*"

      },
      {
        Sid = "BoundedByNamespaceLambda"
        Action = [
          "lambda:*"
        ]
        Effect   = "Allow"
        Resource = [
          "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:function:${var.NameSpace}*",
          "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:layer:${var.NameSpace}*",
          "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:layer:${var.NameSpace}*:*"
        ]
      },
      {
        Sid = "EventSourceMappingBoundedByNamespaceLambda"
        Action = [
          "lambda:CreateEventSourceMapping",
          "lambda:UpdateEventSourceMapping",
          "lambda:DeleteEventSourceMapping"
        ]
        Effect   = "Allow"
        Resource = "*"
        Condition = {
          StringLike = {
            "lambda:FunctionArn" : "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:function:${var.NameSpace}*"
          }
        }

      },
      {
        Sid = "OtherPermissionsIAM"
        Action = [
          "cloudformation:DescribeResources",
          "iam:ListRoles",
          "iam:GetPolicy",
          "iam:GetPolicyVersion",
          "iam:GetRole",
          "iam:GetRolePolicy",
          "iam:ListAttachedRolePolicies",
          "iam:ListRolePolicies",
          "ec2:Describe*",
          "ec2:CreateNetworkInterface",
          "ec2:DeleteNetworkInterface",
          "ec2:AssignPrivateIpAddresses",
          "ec2:UnassignPrivateIpAddresses",
          "kms:ListAliases"
        ]
        Effect   = "Allow"
        Resource = "*"
      }

    ]
  })
}