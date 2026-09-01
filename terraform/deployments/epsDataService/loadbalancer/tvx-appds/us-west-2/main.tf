terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/prod/hatsmaker/epsDataService/us-west-2/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-west-epsds" {
  source                       = "../../../../../modules/hatsmakerv2"
  user_data                    = "../../../../../scripts/user_data/hatsmaker/common/user_data_tvx_appds_template"
  vpc_id                       = "vpc-74695511"
  subnet_id                    = "subnet-d5286a8c"
  aws_region                   = "us-west-2"
  instance_type                = "c5.xlarge"
  security_groups              = ["sg-dd441da1", "sg-e5cbb89f", "sg-affd71d5", "sg-05d76a6ba22571d14"]
  single_subnet_instance_count = 10
  key_pair                     = "coast-master-key-prod"
  comcast_application_name     = "eps"
  comcast_application_role     = "LoadBalancer"
  comcast_application_env      = "prod"
  comcast_iop_appid            = "31858"
  data_center                  = "aw"
  env_type                     = "prod"
  short_name                   = "lb-epsds"
  service_name                 = "epsDataService"
  elk_domain                   = "xvpcapitalservices"
  vector_log_index             = "logz-capitalservices-forwarder"
  haproxy_log_index            = "logz-capitalservices-hap-epsds"
  domain                       = "appds.xcal.tv"
  service_ssl_port             = "9483"
  service_ssl_ipv6_enabled     = "false"
  service_ssl_backend_enabled  = "false"
  cert_name                    = "epsDataService"
  env_certs                    = "true"
  haproxy_template             = "hap_template_services_general_logv2_ftl.j2"
  hats_id                      = "APPDS_AW_EPSDS_PROD"
  swidtag_file                 = "Entertainment_Policy_Service.swidtag"
  ads_tsp_cb_url               = "https://secure.api.comcast.net/ccp-appdiscoveryAdminService-prod/"
  ads_tsp_normal_url           = "https://current.applicationdiscoveryadminservice.ccp.xcal.tv/appdiscoveryAdminService/"
}

#For PROD, standard LB count is 10.
#Workspace naming format is epsds_lb_aw_(base date)_(iteration number)