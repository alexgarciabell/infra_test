terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/ccp-prod/loadbalancer/adsds/ccp-as-az1/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-ashburn-adsds" {
  access_token             = var.access_token
  source                   = "../../../../../modules/hatsmakerv2CCP"
  cloud_init               = "../../../../../scripts/user_data/hatsmaker/common/user_data_tvx_appds_templateCCP"

  deployment_count         = 1
  account_id               = "e0490ad5-59af-4a6c-a0b2-6e88167cfca3"
  account_name             = "xvp_cs_ccp_ads-prod"
  comcast_application_name = "ads"
  comcast_application_role = "haproxy"
  comcast_application_env  = "prod"
  short_name               = "adsds"
  region                   = "ashburn"
  data_center              = "pa"
  az                       = "az1"
  description              = "Test terraform deployment"
  catalog_item_name        = "Linux Custom"
  instance_count           = 12
  flavor                   = "CC.4cpu-8GB"
  bootcapacity             = 50
  tenant                   = "xvp_capitalservices_ccp_prod_set1"
  rail                     = "protected"
  cmi                     = "icfar-hatsmakerv2-23-Oct-2024-15-03-50"
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
  hats_id                      = "CCP_AS_ADSDS_PROD"
  env_type                     = "prod"
  swidtag_file                 = "Application_Discovery_Service.swidtag"
  ads_tsp_cb_url               = "https://secure.api.comcast.net/ccp-appdiscoveryAdminService-prod/"
  ads_tsp_normal_url           = "https://current.applicationdiscoveryadminservice.ccp.xcal.tv/appdiscoveryAdminService/"
  devhub_appid                 = 31851
  full_env                     = "prod"
  resource_type                = "load"
}
