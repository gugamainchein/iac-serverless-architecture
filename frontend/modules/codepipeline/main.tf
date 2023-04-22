resource "aws_codepipeline" "codepipeline" {
  name     = "${var.global_stage}-${var.project}-${var.pipeline_name}-${var.global_app_name}"
  role_arn = var.codepipeline_role

  artifact_store {
    location = var.s3_codepipeline
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        RepositoryName = var.repo_name
        BranchName     = var.global_stage
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]

      configuration = {
        ProjectName = "${var.nome_codebuild}"
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "S3"
      version         = "1"
      input_artifacts = ["build_output"]

      configuration = {
        BucketName = var.s3_codepipeline
        Extract    = "true"
      }
    }
  }
}
