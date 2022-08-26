locals {
  s3_layer = var.bucket != null && var.key != null
}
resource "null_resource" "node_dependencies" {
  provisioner "local-exec" {
    working_dir = var.layer_directory
    command     = "npm install"
  }

  triggers = {
    trigger_every_time = timestamp()
  }
}

data "archive_file" "dependencies" {
  type        = "zip"
  source_dir  = var.layer_directory
  output_path = "${path.module}/.build/${var.layer_name}.zip"

  depends_on = [
    null_resource.node_dependencies
  ]
}
resource "aws_lambda_layer_version" "lambda_layer" {
  layer_name          = var.layer_name
  source_code_hash    = local.s3_layer ? aws_s3_object.object[0].etag : fileexists(data.archive_file.dependencies.output_path) ? filebase64sha256(data.archive_file.dependencies.output_path) : data.archive_file.dependencies.output_base64sha256
  compatible_runtimes = var.compatible_runtimes
  skip_destroy        = var.skip_destroy
  s3_bucket           = local.s3_layer ? aws_s3_object.object[0].bucket : null
  s3_key              = local.s3_layer ? aws_s3_object.object[0].key : null
  filename            = local.s3_layer ? null : data.archive_file.dependencies.output_path
}

resource "aws_s3_object" "object" {
  count  = local.s3_layer ? 1 : 0
  bucket = var.bucket
  key    = var.key
  source = data.archive_file.dependencies.output_path
}