terraform {
  backend "s3" {
    bucket = "coast-infrastructure"
    key    = "coast/ccp-ci/loadbalancer/tagds/ccp-ho-az1/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "ci-hillsboro-tagds" {
  access_token             = var.access_token
  source                   = "../../../../../modules/hatsmakerv2CCP"
  cloud_init               = "../../../../../scripts/user_data/hatsmaker/common/user_data_tvx_appds_templateCCP"

  deployment_count         = 1
  account_id               = "ed38bd14-df31-416a-a72a-20c80f061b68"
  account_name             = "xvp_cs_ccp_tagsvc-non-prod"
  comcast_application_name = "tagging"
  comcast_application_role = "haproxy"
  comcast_application_env  = "ci"
  short_name               = "tagds"
  region                   = "hillsboro"
  data_center              = "th"
  az                       = "az1"
  description              = "Test terraform deployment"
  catalog_item_name        = "Linux Custom"
  instance_count           = 1
  flavor                   = "CC.4cpu-8GB"
  bootcapacity             = 50
  tenant                   = "xvp_capitalservices_ccp_test"
  rail                     = "public"
  cmi                      = "icfar-hatsmakerv2-07-Dec-2023-03-25-43"
  ipv                      = "IPv4_IPv6"

  service_name                 = "cmTagDataService"
  cert_name                    = "cmTagDataService"
  env_certs                    = "true"
  elk_domain                   = "xvpcapitalservices"
  vector_log_index             = "logz-capitalservices-forwarder"
  haproxy_log_index            = "logz-capitalservices-hap-tagds"
  #haproxy_template             = "haproxy_ads_ftl.j2"
  haproxy_template             = "hap_template_services_general_logv2_ftl.j2"
  service_ssl_port             = "9481"
  service_ssl_ipv6_enabled     = "false"
  service_ssl_backend_enabled  = "false"
  hats_id                      = "CCP_HO_TAGDS_CI"
  env_type                     = "ci"
  swidtag_file                 = "Tagging_Data_Service.swidtag"
  ads_tsp_cb_url               = "https://secure.api.comcast.net/ccp-appdiscoveryAdminService-ci/"
  ads_tsp_normal_url           = "https://dev.adsadmin.coast.xcal.tv:9443/appdiscoveryAdminService/"
  devhub_appid                 = 31928
  full_env                     = "ci"
  resource_type                = "load"
}
