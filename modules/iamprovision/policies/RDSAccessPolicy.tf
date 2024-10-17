resource "aws_iam_policy" "rdsPolicy" {
  name        = "${var.NameSpace}_${var.AccountEnv}_rds_access"
  path        = "/"
  description = "${var.NameSpace}_${var.AccountEnv}_rds_access"

  # Terraform"s "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "UniversalAllow"
        Action = [
          "ec2:Describe*",
          "rds:Describe*",
          "rds:RestoreDBInstanceFromDBSnapshot"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Sid = "MonitoringRoleBounded"
        Action = [
          "iam:PassRole"
        ]
        Effect   = "Allow"
        Resource ="arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/rds-monitoring-role"

      },
      {
        Sid = "RDSManagement"
        Action = [
          "rds:ModifyOptionGroup",
          "rds:RestoreDBClusterFromSnapshot",
          "rds:ResetDBParameterGroup",
          "rds:CreateOptionGroup",
          "rds:DeleteOptionGroup",
          "rds:ModifyDBParameterGroup",
          "rds:AddRoleToDBInstance",
          "rds:CreateDBInstance",
          "rds:CopyDBParameterGroup",
          "rds:AddRoleToDBCluster",
          "rds:ModifyDBInstance",
          "rds:ModifyDBClusterParameterGroup",
          "rds:ModifyDBClusterSnapshotAttribute",
          "rds:DeleteDBCluster",
          "rds:ResetDBClusterParameterGroup",
          "rds:DeleteDBInstance",
          "rds:CopyDBClusterParameterGroup",
          "rds:AddTagsToResource",
          "rds:CreateDBParameterGroup",
          "rds:CopyDBSnapshot",
          "rds:CopyDBClusterSnapshot",
          "rds:DeleteDBSnapshot",
          "rds:StopDBInstance",
          "rds:CopyOptionGroup",
          "rds:StartDBInstance",
          "rds:ModifyDBSnapshot",
          "rds:DeleteDBClusterSnapshot",
          "rds:CreateDBSnapshot",
          "rds:RebootDBInstance",
          "rds:CreateDBCluster",
          "rds:ModifyDBCluster",
          "rds:CreateDBClusterSnapshot",
          "rds:DeleteDBParameterGroup",
          "rds:CreateDBClusterParameterGroup",
          "rds:DeleteDBClusterParameterGroup",
          "rds:ModifyDBSnapshotAttribute",
          "rds:RemoveTagsFromResource"
        ]
        Effect   = "Allow"
        Resource =[
          "arn:aws:rds:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:cluster-pg:${var.NameSpace}*",
          "arn:aws:rds:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:cluster-pg:default*",
          "arn:aws:rds:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:og:${var.NameSpace}*",
          "arn:aws:rds:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:og:default*",
          "arn:aws:rds:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:snapshot:${var.NameSpace}*",
          "arn:aws:rds:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:pg:${var.NameSpace}*",
          "arn:aws:rds:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:pg:default*",
          "arn:aws:rds:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:cluster:${var.NameSpace}*",
          "arn:aws:rds:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:db:${var.NameSpace}*",
          "arn:aws:rds:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:cluster-snapshot:${var.NameSpace}*",
          "arn:aws:rds:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:subgrp:${var.AccountSubnet}"
        ]
      }
    ]
  })
}