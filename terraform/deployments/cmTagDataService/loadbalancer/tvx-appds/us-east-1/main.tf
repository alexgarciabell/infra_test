terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/prod/hatsmaker/cmTagDataService/us-east-1/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-east-cmtagds" {
  source                       = "../../../../../modules/hatsmakerv2"
  user_data                    = "../../../../../scripts/user_data/hatsmaker/common/user_data_tvx_appds_template"
  vpc_id                       = "vpc-08b9236c"
  subnet_id                    = "subnet-da41b882"
  aws_region                   = "us-east-1"
  instance_type                = "c5.xlarge"
#tag-service-haproxy-east - sg-0b796cf112858b7ee
  security_groups              = ["sg-39f23949", "sg-784b7209", "sg-74212605", "sg-052433529d8e704f9", "sg-0b796cf112858b7ee"]
  single_subnet_instance_count = 12
  key_pair                     = "coast-master-key-prod"
  comcast_application_name     = "taggingservice"
  comcast_application_role     = "LoadBalancer"
  comcast_application_env      = "prod"
  comcast_iop_appid            = "31928"
  data_center                  = "ae"
  env_type                     = "prod"
  short_name                   = "lb-tagds"
  service_name                 = "cmTagDataService"
  elk_domain                   = "xvpcapitalservices"
  vector_log_index             = "logz-capitalservices-forwarder"
  haproxy_log_index            = "logz-capitalservices-hap-tagds"
  domain                       = "appds.xcal.tv"
  service_ssl_port             = "9481"
  service_ssl_ipv6_enabled     = "false"
  service_ssl_backend_enabled  = "false"
  cert_name                    = "cmTagDataService"
  env_certs                    = "true"
  #haproxy_template             = "haproxy_cmtagds_ftl.j2"
  haproxy_template             = "hap_template_services_general_logv2_ftl.j2"
  hats_id                      = "APPDS_AE_CMTAGDS_PROD"
  swidtag_file                 = "Tagging_Data_Service.swidtag"
  ads_tsp_cb_url               = "https://secure.api.comcast.net/ccp-appdiscoveryAdminService-prod/"
  ads_tsp_normal_url           = "https://current.applicationdiscoveryadminservice.ccp.xcal.tv/appdiscoveryAdminService/"
}

#For PROD, standard LB count is 12.
#Workspace naming format is tagds_lb_ae_(base date)_(iteration number)