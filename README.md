## Mandatory Variables

`layer_name` unique name for your Lambda Layer.

`layer_directory` path to the function's deployment package within the local filesystem.

## Optional Variables

`compatible_runtimes` - list of runtimes this layer is compatible with. Up to 5 runtimes can be specified.

`skip_destroy` - Whether to retain the old version of a previously deployed Lambda Layer. Default is false. Forces deletion of the existing layer version and creation of a new layer version.

`bucket` - The name of a bucket where to save the layer.

`key` - The path in the bucket where to save the layer.

## Example #1 - Simple Lambda Layer

Assuming:

- you have a folder with code of a layer located in the root directory.
- it hase subfolder `nodejs`.

```hcl
   root_directory/
   |── layer/
      |── nodejs/
         |── helper_methods.js
         |── package.json
```

```hcl
module "lambda_layer" {
  source            = "github.com/dmitrijslotko/terraform_layer_builder.git?ref=v1.1.1_LTS"
  layer_name        = "my_layer"
  layer_directory   = "./layer"
  modules_directory = "./layer/nodejs"
}

module "lambda" {
  source                = "github.com/dmitrijslotko/terraform_lambda_builder.git?ref=v3.2.0_LTS"
  function_name         = "function_name"
  filename              = "./src/function_name"
  layers                = [module.lambda_layer.layer_output.arn]
}
```

## Example #2 - S3 Lambda Layer

Assuming:

- you have a folder with code of a layer located in the root directory.
- it hase subfolder `nodejs`.

```hcl
   root_directory/
   |── layer/
      |── nodejs/
         |── helper_methods.js
         |── package.json
```

```hcl
module "lambda_layer" {
  source            = "github.com/dmitrijslotko/terraform_layer_builder.git?ref=v1.1.2"
  layer_name        = "my_layer"
  layer_directory   = "./layer"
  modules_directory = "./layer/nodejs"
  bucket          = "bucket-name"
  key             = "project_name/my_layer"
}
```
