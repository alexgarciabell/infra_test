terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/prod/hatsmaker/cmTagDataService/us-east-2/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-ohio-cmtagds" {
  source                       = "../../../../../modules/hatsmakerv2"
  user_data                    = "../../../../../scripts/user_data/hatsmaker/common/user_data_tvx_appds_template"
  vpc_id                       = "vpc-8918a4e1"
  subnet_id                    = "subnet-918f79eb"
  aws_region                   = "us-east-2"
  instance_type                = "c5.xlarge"
#tag-service-haproxy-ohio - sg-0ac560ce709040bb6
  security_groups              = ["sg-0d23099147f350ce3", "sg-6ed1db05", "sg-d6a544bc", "sg-01082ccfa43c59529", "sg-0ac560ce709040bb6"]
  single_subnet_instance_count = 12
  key_pair                     = "coast-master-key-prod"
  comcast_application_name     = "taggingservice"
  comcast_application_role     = "LoadBalancer"
  comcast_application_env      = "prod"
  comcast_iop_appid            = "31928"
  data_center                  = "ao"
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
  hats_id                      = "APPDS_AC_CMTAGDS_PROD"
  swidtag_file                 = "Tagging_Data_Service.swidtag"
  ads_tsp_cb_url               = "https://secure.api.comcast.net/ccp-appdiscoveryAdminService-prod/"
  ads_tsp_normal_url           = "https://current.applicationdiscoveryadminservice.ccp.xcal.tv/appdiscoveryAdminService/"
}

#For PROD, standard LB count is 12.
#Workspace naming format is tagds_lb_ao_(base date)_(iteration number)
