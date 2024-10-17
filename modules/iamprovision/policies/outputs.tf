output "customer_managed_policies_arns" {
  value = [
    aws_iam_policy.cloudformationPolicy.arn,
    aws_iam_policy.cloudWatchPolicy.arn,
    aws_iam_policy.codecommitAndCodeBuildPolicy.arn,
    aws_iam_policy.codepipelineAndCodeDeployPolicy.arn,
    aws_iam_policy.dynamodbPolicy.arn,
    aws_iam_policy.ecsAndEcrPolicy.arn,
    aws_iam_policy.elbPolicy.arn,
    aws_iam_policy.glueAndAthenaPolicy.arn,
    aws_iam_policy.dynamodbPolicy.arn,
    aws_iam_policy.ecsAndEcrPolicy.arn,
    aws_iam_policy.elbPolicy.arn,
    aws_iam_policy.glueAndAthenaPolicy.arn,
    aws_iam_policy.iamPassRolePolicy.arn,
    aws_iam_policy.lambdaAndStatesPolicy.arn,
    aws_iam_policy.parameterStroeAndSecretsManagerPolicy.arn,
    aws_iam_policy.rdsPolicy.arn,
    aws_iam_policy.s3AndKmsPolicy.arn,
    aws_iam_policy.sqsAndSnsPolicy.arn

  ]

}