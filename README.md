## Mandatory Variables

`layer_name` unique name for your Lambda Layer.

`layer_directory` path to the function's deployment package within the local filesystem.

## Optional Variables

`compatible_runtimes` - list of runtimes this layer is compatible with. Up to 5 runtimes can be specified.

`skip_destroy` - Whether to retain the old version of a previously deployed Lambda Layer. Default is false. Forces deletion of the existing layer version and creation of a new layer version.

## Example #1 - Simple Lambda Function

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
  source            = "github.com/dmitrijslotko/terraform_layer_builder.git?ref=latest"
  layer_name        = "my_layer"
  layer_directory   = "./layer"
  package_directory = "./layer/nodejs"
}
```
