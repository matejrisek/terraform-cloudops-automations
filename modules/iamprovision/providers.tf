terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.17.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.4.0"
    }
  }
  required_version = ">= 1.5.7"
}

provider "aws" {
  profile = "${var.iam_profile}"
  region = var.region
}