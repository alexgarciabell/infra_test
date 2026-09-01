terraform {
  backend "s3" {
    bucket = "coast-infrastructure"
    key    = "coast/ccp-ci/loadbalancer/adsds/ccp-ho-az1/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "ci-hillsboro-adsds" {
  access_token             = var.access_token
  source                   = "../../../../../modules/hatsmakerv2CCP"
  cloud_init               = "../../../../../scripts/user_data/hatsmaker/common/user_data_tvx_appds_templateCCP"

  deployment_count         = 1
  account_id               = "2f9876dc-bd46-4d9f-ac12-28f9b94307c1"
  account_name             = "xvp_cs_ccp_ads-non-prod"
  comcast_application_name = "ads"
  comcast_application_role = "haproxy"
  comcast_application_env  = "ci"
  short_name               = "adsds"
  region                   = "hillsboro"
  data_center              = "th"
  az                       = "az1"
  description              = "Test terraform deployment"
  catalog_item_name        = "Linux Custom"
  instance_count           = 1
  flavor                   = "CC.4cpu-8GB"
  bootcapacity             = 50
  tenant                   = "xvp_capitalservices_ccp_ads_ci"
  rail                     = "public"
  cmi                     = "icfar-hatsmakerv2-12-Jul-2024-09-31-49"
  ipv                      = "IPv4_IPv6"

  service_name                 = "appdiscoveryService"
  cert_name                    = "appdiscoveryService"
  env_certs                    = "true"
  elk_domain                   = "xvpcapitalservices"
  vector_log_index             = "logz-capitalservices-forwarder"
  haproxy_log_index            = "logz-capitalservices-hap-adsds"
  #haproxy_template             = "haproxy_ads_ftl.j2"
  haproxy_template             = "hap_template_services_general_logv2_ftl.j2"
  service_ssl_port             = "9472"
  service_ssl_ipv6_enabled     = "false"
  service_ssl_backend_enabled  = "false"
  hats_id                      = "APPDS_HO_ADS_CI"
  env_type                     = "ci"
  swidtag_file                 = "Application_Discovery_Service.swidtag"
  ads_tsp_cb_url               = "https://secure.api.comcast.net/ccp-appdiscoveryAdminService-ci/"
  ads_tsp_normal_url           = "https://ci.applicationdiscoveryadminservice.ccp.xcal.tv:9443/appdiscoveryAdminService/"
  devhub_appid                 = 31851
  full_env                     = "ci"
  resource_type                = "load"
}
