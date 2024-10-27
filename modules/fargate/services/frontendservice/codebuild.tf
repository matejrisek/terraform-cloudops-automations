# code build
resource "aws_codebuild_project" "cd_bld_prj" {
  count = var.create_code_build ? 1 : 0
  name           = "${var.application_code}-${var.microservice_code}-${var.env}"
  description    = "codebuild project for ${var.microservice_code} ${var.env}"
  build_timeout  = "30"
  service_role   =  var.code-build-role-arn
  concurrent_build_limit = 1

  artifacts {
    type = "CODEPIPELINE"
  }


  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/standard:7.0"
    type            = "LINUX_CONTAINER"
    privileged_mode = true

    environment_variable {
      name  = "AWS_DEFAULT_REGION"
      value = data.aws_region.current.name
    }
    environment_variable {
      name  = "AWS_ACCOUNT_ID"
      value = data.aws_caller_identity.current.account_id
    }
    environment_variable {
      name  = "IMAGE_REPO_NAME"
      value = "${var.application_code}-${var.microservice_code}-${var.env}"
    }

    environment_variable {
      name  = "IMAGE_REPO_NAME_DEPLOY"
      value = "${var.application_code}-${var.microservice_code}-test"
    }

    environment_variable {
      name  = "ENV"
      value = var.env
    }
  }

  vpc_config {
    vpc_id = var.vpc_id
    subnets = var.vpc_private_subnets_containers_list
    security_group_ids = var.security_group_id_list
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec-${var.env}.yml"
  }

}

