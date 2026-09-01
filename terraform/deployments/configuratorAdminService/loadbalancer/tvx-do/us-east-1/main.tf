terraform {
  backend "s3" {
    bucket = "coast-infrastructure"
    key    = "coast/staging/hatsmaker/configadmin/us-east-1/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "ci-east-configadmin" {
  source                       = "../../../../../modules/hatsmakerv2"
  user_data                    = "../../../../../scripts/user_data/hatsmaker/common/user_data_tvx_appds_template"
  vpc_id                       = "vpc-0cb21169"
  subnet_id                    = "subnet-e42182bd"
  aws_region                   = "us-east-1"
  instance_type                = "c5.xlarge"
  security_groups              = ["sg-74b49806", "sg-a8e1eccd", "sg-13387267"]
  single_subnet_instance_count = 1
  key_pair                     = "coast-master-key-dev"
  comcast_application_name     = "xreconfigurator"
  comcast_application_role     = "haproxy"
  comcast_application_env      = "ci"
  data_center                  = "de"
  env_type                     = "ci"
  short_name                   = "lb-xreconfigadmin"
  service_name                 = "configuratorAdminService"
  elk_domain                   = "xreconfigurator"
  vector_log_index             = "logz-xreconfigurator-forwarder"
  haproxy_log_index            = "logz-xreconfigurator-hap-xreconfigadmin"
  domain                       = "do.xcal.tv"
  service_ssl_port             = "9443"
  service_ssl_ipv6_enabled     = "false"
  service_ssl_backend_enabled  = "false"
  cert_name                    = "configuratorAdminService"
  env_certs                    = "true"
  haproxy_template             = "hap_template_ui_general_logv2_ftl.j2"
  hats_id                      = "APPDS_DO_CONFIGURATORADMIN_CI"
  swidtag_file                 = "XRE_Configurator.swidtag"
  ads_tsp_cb_url               = "https://secure.api.comcast.net/ccp-appdiscoveryAdminService-ci/"
  ads_tsp_normal_url           = "https://ci.applicationdiscoveryadminservice.ccp.xcal.tv:9443/appdiscoveryAdminService/"
}

#For CI, standard LB count is 1.
#Workspace naming format is xreconfigadmin_lb_de_(base date)_(iteration number)