terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/prod/hatsmaker/configadmin/us-east-1/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-east-configadmin" {
  source                       = "../../../../../modules/hatsmakerv2"
  user_data                    = "../../../../../scripts/user_data/hatsmaker/common/user_data_tvx_appds_template"
  vpc_id                       = "vpc-08b9236c"
  subnet_id                    = "subnet-da41b882"
  aws_region                   = "us-east-1"
  instance_type                = "c5.xlarge"
  security_groups              = ["sg-39f23949", "sg-74212605", "sg-72760807", "sg-08a21a9fc9e3448b2"]
  single_subnet_instance_count = 1
  key_pair                     = "coast-master-key-prod"
  comcast_application_name     = "xreconfigurator"
  comcast_application_role     = "haproxy"
  comcast_application_env      = "prod"
  data_center                  = "ae"
  env_type                     = "prod"
  short_name                   = "lb-xreconfigadmin"
  service_name                 = "configuratorAdminService"
  elk_domain                   = "xreconfigurator"
  vector_log_index             = "logz-xreconfigurator-forwarder"
  haproxy_log_index            = "logz-xreconfigurator-hap-xreconfigadmin"
  domain                       = "appds.xcal.tv"
  service_ssl_port             = "9443"
  service_ssl_ipv6_enabled     = "false"
  service_ssl_backend_enabled  = "false"
  cert_name                    = "configuratorAdminService"
  env_certs                    = "true"
  haproxy_template             = "hap_template_ui_general_logv2_ftl.j2"
  ##GDJ - There is currently no deployment of XRE Configurator Admin in PROD East
  hats_id                      = "APPDS_AE_CONFIGURATORADMIN_PROD"
  swidtag_file                 = "XRE_Configurator.swidtag"
  ads_tsp_cb_url               = "https://secure.api.comcast.net/ccp-appdiscoveryAdminService-prod/"
  ads_tsp_normal_url           = "https://current.applicationdiscoveryadminservice.ccp.xcal.tv/appdiscoveryAdminService/"
}

#For PROD, standard LB count is 1.
#Workspace naming format is xreconfigadmin_lb_ae_(base date)_(iteration number)
#Currently not deployed to East.