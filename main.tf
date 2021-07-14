locals {
  ebs_attachment = contains(["sentry", "validator", "library"], var.type) && var.mount_volumes
}

data "template_file" "user_data" {
  template = <<-EOF
#cloud-boothook
#!/bin/bash
set +e
touch /home/ubuntu/user-data-started
${var.cloud_provider == "azure" && var.type == "library" ? file("${path.module}/templates/azure_api.tpl") : ""}
${var.cloud_provider == "gcp" && var.type == "library" ? file("${path.module}/templates/gcp_api.tpl") : ""}
${var.driver_type == "nitro" && local.ebs_attachment && var.cloud_provider == "aws" ? file("${path.module}/templates/nitro_ebs.tpl") : ""}
${var.driver_type == "standard" && local.ebs_attachment && var.cloud_provider == "aws" ? file("${path.module}/templates/standard_ebs.tpl") : ""}
${var.disable_ipv6 ? file("${path.module}/templates/disable_ipv6.tpl") : ""}
${var.prometheus_enabled ? data.template_file.prometheus_consul.rendered : ""}
${var.type == "validator" ? data.template_file.validator.rendered : ""}
${var.type == "sentry" ? data.template_file.sentry.rendered : ""}
${var.type == "bastion_s3" ? data.template_file.bastion_s3.rendered : ""}
${var.type == "library" ? file("${path.module}/templates/library.tpl") : ""}
touch /home/ubuntu/user-data-complete
EOF

  vars = {}
}

