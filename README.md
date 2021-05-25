# terraform-polkadot-user-data

<p class="callout danger">WIP</p>

## Features

This module builds user data scripts for polkadot nodes.  Includes some sane defaults for prometheus node exporter and
consul config.

## Terraform versions

For Terraform v0.12.0+

## Usage

```
module "this" {
    source = "github.com/robc-io/terraform-polkadot-user-data"
    type = "sentry"
}
```

## Examples

- [simple](https://github.com/robc-io/terraform-polkadot-user-data/tree/master/examples/simple)

## Known issues
No issue is creating limit on this module.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_template"></a> [template](#provider\_template) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [template_file.bastion_s3](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |
| [template_file.cloudwatch](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |
| [template_file.prometheus_consul](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |
| [template_file.sentry](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |
| [template_file.user_data](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |
| [template_file.validator](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloud_provider"></a> [cloud\_provider](#input\_cloud\_provider) | What provider is this node running on? | `string` | n/a | yes |
| <a name="input_disable_ipv6"></a> [disable\_ipv6](#input\_disable\_ipv6) | Disable ipv6 in grub | `bool` | `true` | no |
| <a name="input_driver_type"></a> [driver\_type](#input\_driver\_type) | The ebs volume driver - nitro or standard | `string` | `"nitro"` | no |
| <a name="input_enable_hourly_cron_updates"></a> [enable\_hourly\_cron\_updates](#input\_enable\_hourly\_cron\_updates) | n/a | `string` | `"false"` | no |
| <a name="input_envoy_enabled"></a> [envoy\_enabled](#input\_envoy\_enabled) | Configure Envoy proxy for Consul Connect | `bool` | `false` | no |
| <a name="input_keys_update_frequency"></a> [keys\_update\_frequency](#input\_keys\_update\_frequency) | n/a | `string` | `""` | no |
| <a name="input_log_config_bucket"></a> [log\_config\_bucket](#input\_log\_config\_bucket) | n/a | `string` | `""` | no |
| <a name="input_log_config_key"></a> [log\_config\_key](#input\_log\_config\_key) | n/a | `string` | `""` | no |
| <a name="input_mount_volumes"></a> [mount\_volumes](#input\_mount\_volumes) | Boolean to mount volume | `bool` | `true` | no |
| <a name="input_node_tags"></a> [node\_tags](#input\_node\_tags) | The tag to put into the node exporter for consul to pick up the tag of the instance and associate the proper metrics | `string` | `"prep"` | no |
| <a name="input_prometheus_enabled"></a> [prometheus\_enabled](#input\_prometheus\_enabled) | Download and start node exporter | `bool` | `false` | no |
| <a name="input_prometheus_password"></a> [prometheus\_password](#input\_prometheus\_password) | Password to pass through for node exporter | `string` | `""` | no |
| <a name="input_prometheus_user"></a> [prometheus\_user](#input\_prometheus\_user) | Username to pass through for node exporter | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | The region you are deploying into - only relevant for consul | `string` | `""` | no |
| <a name="input_s3_bucket_name"></a> [s3\_bucket\_name](#input\_s3\_bucket\_name) | n/a | `string` | `""` | no |
| <a name="input_s3_bucket_uri"></a> [s3\_bucket\_uri](#input\_s3\_bucket\_uri) | n/a | `string` | `""` | no |
| <a name="input_ssh_user"></a> [ssh\_user](#input\_ssh\_user) | n/a | `string` | `"ubuntu"` | no |
| <a name="input_type"></a> [type](#input\_type) | Type of node - ie sentry / validator, - more to come | `string` | `"sentry"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_user_data"></a> [user\_data](#output\_user\_data) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Authors

Module managed by [robc-io](github.com/robc-io)

## Credits

- [Anton Babenko](https://github.com/antonbabenko)

## License

Apache 2 Licensed. See LICENSE for full details.