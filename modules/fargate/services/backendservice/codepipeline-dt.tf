resource "aws_codepipeline" "ecs_pipeline" {
  name     = "${var.application_code}-${var.microservice_code}-${var.env}"
  role_arn = var.code-pipe-line-role-arn
  tags = {
    Environment = var.env
  }
  artifact_store {
    encryption_key {
      id   = var.kms_custom_managed_key_arn
      type = "KMS"
    }
    location = "${var.s3_prefix}.${var.env}"
    type     = "S3"
  }
  stage {
    name = "Source"
    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      run_order        = 1
      output_artifacts = ["SourceArtifact"]
      configuration = {
        ConnectionArn    =   var.gilab_connection_arn
        FullRepositoryId       =  "${var.gitlab_repo_prefix}${var.gitlab_repo_id}"
        BranchName           = var.branch_name
        OutputArtifactFormat = var.outputArtifactFormat
        DetectChanges = var.auto_trigger_pipeline
      }
    }
  }
  stage {
    name = "Build"
    action {
      category = "Build"
      configuration = {
        "ProjectName" = aws_codebuild_project.cd_bld_prj[0].name
      }
      input_artifacts = [
        "SourceArtifact"
      ]
      name = "Build"
      output_artifacts = [
        "BuildArtifact"
      ]
      owner     = "AWS"
      provider  = "CodeBuild"
      run_order = 1
      version   = "1"
    }
  }
  stage {
    name = "Deploy"
    action {
      name      = "Deploy"
      category  = "Deploy"
      owner     = "AWS"
      provider = "CodeDeployToECS"
      version   = "1"
      run_order = 1
      input_artifacts = [
        "BuildArtifact"
      ]
      configuration = {
        ApplicationName                = aws_codedeploy_app.cd_dply_prj.name
        DeploymentGroupName            = aws_codedeploy_deployment_group.cd_dply_grp.deployment_group_name
        TaskDefinitionTemplateArtifact = "BuildArtifact"
        TaskDefinitionTemplatePath     = var.pipelineTaskDefinitionTemplatePath
        AppSpecTemplateArtifact        = "BuildArtifact"
        AppSpecTemplatePath            = var.pieplineAppSepecTemplatePath
        Image1ArtifactName             = "BuildArtifact"
        Image1ContainerName            = "IMAGE1_NAME"
      }
    }
  }
}