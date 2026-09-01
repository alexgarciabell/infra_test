terraform {
  backend "s3" {
    bucket = "coast-infrastructure"
    key    = "coast/staging/hatsmaker/cmTagDataService/us-west-2/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "ci-west-cmtagds" {
  source                       = "../../../../../modules/hatsmakerv2"
  user_data                    = "../../../../../scripts/user_data/hatsmaker/common/user_data_tvx_appds_template"
  vpc_id                       = "vpc-ffc0399a"
  subnet_id                    = "subnet-66fb3103"
  aws_region                   = "us-west-2"
  instance_type                = "c5.xlarge"
  security_groups              = ["sg-0cb6b93c4d05f5c16","sg-28e5374f","sg-f57d2d91"]
  single_subnet_instance_count = 1
  key_pair                     = "coast-master-key-dev"
  comcast_application_name     = "taggingservice"
  comcast_application_role     = "LoadBalancer"
  comcast_application_env      = "ci"
  comcast_iop_appid            = "31928"
  data_center                  = "dw"
  env_type                     = "ci"
  short_name                   = "lb-tagds"
  service_name                 = "cmTagDataService"
  elk_domain                   = "xvpcapitalservices"
  vector_log_index             = "logz-capitalservices-forwarder"
  haproxy_log_index            = "logz-capitalservices-hap-tagds"
  domain                       = "do.xcal.tv"
  service_ssl_port             = "9481"
  service_ssl_ipv6_enabled     = "false"
  service_ssl_backend_enabled  = "false"
  cert_name                    = "cmTagDataService"
  env_certs                    = "true"
  #haproxy_template             = "haproxy_cmtagds_ftl.j2"
  haproxy_template             = "hap_template_services_general_logv2_ftl.j2"
  hats_id                      = "APPDS_DW_CMTAGDS_CI"
  swidtag_file                 = "Tagging_Data_Service.swidtag"
  ads_tsp_cb_url               = "https://secure.api.comcast.net/ccp-appdiscoveryAdminService-ci/"
  ads_tsp_normal_url           = "https://ci.applicationdiscoveryadminservice.ccp.xcal.tv:9443/appdiscoveryAdminService/"
}

#For CI, standard LB count is 1.
#Workspace naming format is tagds_lb_dw_(base date)_(iteration number)