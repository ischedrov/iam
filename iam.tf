resource "aws_iam_role" "task_role" {
  name               = var.iam_task_role_name
  assume_role_policy = file("${path.root}/policies/assume_role_ecs.json")

  inline_policy {
    name = "${var.project}-${var.product}-${var.pipeline_type}-${var.pipeline}-task-role-policy"
    policy = templatefile("${path.root}/policies/task_role.json",
      {
        shared_secret_arn   = "arn:aws:secretsmanager:${var.aws_region}:123456789012:secret:${var.environment_short_name}/shared/*"
        pipeline_secret_arn = "arn:aws:secretsmanager:${var.aws_region}:123456789012:secret:${var.environment_short_name}/${var.pipeline_simple_name}/*"
        s3_bucket_arn       = var.s3_bucket_arn
    })
  }
}