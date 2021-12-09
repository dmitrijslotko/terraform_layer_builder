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
  filename            = data.archive_file.dependencies.output_path
  layer_name          = var.layer_name
  source_code_hash    = fileexists(data.archive_file.dependencies.output_path) ? filebase64sha256(data.archive_file.dependencies.output_path) : data.archive_file.dependencies.output_base64sha256
  compatible_runtimes = var.compatible_runtimes
  skip_destroy        = var.skip_destroy
}
