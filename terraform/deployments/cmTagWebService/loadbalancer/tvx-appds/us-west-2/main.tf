terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/prod/hatsmaker/cmTagWebService/us-west-2/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-west-cmtagws" {
  source                       = "../../../../../modules/hatsmakerv2"
  user_data                    = "../../../../../scripts/user_data/hatsmaker/common/user_data_tvx_appds_template"
  vpc_id                       = "vpc-74695511"
  subnet_id                    = "subnet-d5286a8c"
  aws_region                   = "us-west-2"
  instance_type                = "c5.xlarge"
  security_groups              = ["sg-affd71d5", "sg-e5cbb89f", "sg-0a5b6a10db8c48585", "sg-052543314b6605f99"]
  single_subnet_instance_count = 1
  key_pair                     = "coast-master-key-prod"
  comcast_application_name     = "taggingservice"
  comcast_application_role     = "LoadBalancer"
  comcast_application_env      = "prod"
  comcast_iop_appid            = "31921"
  data_center                  = "aw"
  env_type                     = "prod"
  short_name                   = "lb-tagportal"
  service_name                 = "cmTagWebService"
  elk_domain                   = "xvpcapitalservices"
  vector_log_index             = "logz-capitalservices-forwarder"
  haproxy_log_index            = "logz-capitalservices-hap-tagportal"
  domain                       = "appds.xcal.tv"
  service_ssl_port             = "9482"
  service_ssl_ipv6_enabled     = "false"
  service_ssl_backend_enabled  = "false"
  cert_name                    = "cmTagWebService"
  env_certs                    = "true"
  #haproxy_template             = "haproxy_cmtagws_ftl.j2"
  haproxy_template             = "hap_template_ui_general_logv2_ftl.j2"
  hats_id                      = "APPDS_AW_TAGSP_PROD"
  swidtag_file                 = "Tagging_Data_Service.swidtag"
  ads_tsp_cb_url               = "https://secure.api.comcast.net/ccp-appdiscoveryAdminService-prod/"
  ads_tsp_normal_url           = "https://current.applicationdiscoveryadminservice.ccp.xcal.tv/appdiscoveryAdminService/"
}

#For PROD, standard LB count is 1.
#Workspace naming format is tagportal_lb_aw_(base date)_(iteration number)