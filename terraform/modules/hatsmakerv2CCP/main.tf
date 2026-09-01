provider "vra" {
  url = "https://api.ccp.comcast.com/api/terraformassist/v1/vRA/${var.region}/${var.az}/${var.account_id}/"
  access_token = var.access_token

  # insecure - Do not try to validate the vRA Certficate
  insecure = "false"
}

data "vra_project" "this" {
  name = "${var.account_name}-${var.account_id}"
}

data "vra_catalog_item" "this" {
  name            = var.catalog_item_name
  expand_versions = true
}

resource "random_string" "stacknamestring" {
  length  = 2
  upper   = false
  lower   = true
  special = false
}

data "template_file" "cloud_init" {
  template = "${file("${var.cloud_init}")}"

  vars = {
    service_name                = "${var.service_name}"
    cert_name                   = "${var.cert_name}"
    env_certs                   = "${var.env_certs}"
    elk_domain                  = "${var.elk_domain}"
    vector_log_index            = "${var.vector_log_index}"
    haproxy_log_index           = "${var.haproxy_log_index}"
    haproxy_template            = "${var.haproxy_template}"
    service_ssl_port            = "${var.service_ssl_port}"
    service_ssl_ipv6_enabled    = "${var.service_ssl_ipv6_enabled}"
    service_ssl_backend_enabled = "${var.service_ssl_backend_enabled}"
    hats_id                     = "${var.hats_id}"
    env_type                    = "${var.env_type}"
    swidtag_file                = "${var.swidtag_file}"
    ads_tsp_cb_url              = "${var.ads_tsp_cb_url}"
    ads_tsp_normal_url          = "${var.ads_tsp_normal_url}"
  }
}

resource "vra_deployment" "this" {
  count           = var.deployment_count
  project_id      = data.vra_project.this.id
  name            = "${var.prefix_name}-${var.data_center}-${random_string.stacknamestring.result}-${var.short_name}"
  description     = var.description
  catalog_item_id = data.vra_catalog_item.this.id
  inputs = {
    inCount        = var.instance_count
    vmName         = "${var.prefix_name}-${var.data_center}-${random_string.stacknamestring.result}-${var.short_name}"
    inFlavor       = var.flavor
    inTenant       = var.tenant
    inRail         = var.rail
    inTags         = "ComcastApplicationName:${var.comcast_application_name},ComcastApplicationRole:${var.comcast_application_role},ComcastApplicationEnvironment:${var.comcast_application_env},DeploymentType:${var.deployment_type},TerraformWorkSpace:${terraform.workspace},FromCMI:${var.cmi},cmdb_app_id:${var.devhub_appid},cmdb_app_environment:${var.full_env},cmdb_app_tier:${var.resource_type}"
    inCMI          = "MasterCMILibrary / ${var.cmi}"
    inIpv          = var.ipv
    inBootCapacity = var.bootcapacity
    inConfig       = "${data.template_file.cloud_init.rendered}"
    devhub_appid   = "${var.devhub_appid}"
    full_env       = "${var.full_env}"
    resource_type  = "${var.resource_type}"
  }

  timeouts {
    create = var.tcreate
    delete = var.tdelete
    update = var.tupdate
  }
}

locals {
  vm_name_with_ip = {
    for resource in flatten(vra_deployment.this[*].resources) :
    jsondecode(resource.properties_json).resourceName => jsondecode(resource.properties_json).address
    if resource.type == "Cloud.vSphere.Machine"
  }
  #vm_name_with_v6ip = {
  #    for resource in flatten(vra_deployment.this[*].resources) :
  #    jsondecode(resource.properties_json).resourceName => jsondecode(resource.properties_json).networks.0.ipv6Addresses.0
  #    if resource.type == "Cloud.vSphere.Machine"
  #}
  vm_names = keys(local.vm_name_with_ip)
  ip_addresses = values(local.vm_name_with_ip)
  #v6_addresses = values(local.vm_name_with_v6ip)
}
