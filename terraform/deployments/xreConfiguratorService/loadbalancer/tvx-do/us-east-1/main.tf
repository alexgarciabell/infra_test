terraform {
  backend "s3" {
    bucket = "coast-infrastructure"
    key    = "coast/staging/hatsmaker/configds/us-east-1/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "ci-east-configds" {
  source                       = "../../../../../modules/hatsmakerv2"
  user_data                    = "../../../../../scripts/user_data/hatsmaker/common/user_data_tvx_appds_template"
  vpc_id                       = "vpc-0cb21169"
  subnet_id                    = "subnet-e42182bd"
  aws_region                   = "us-east-1"
  instance_type                = "c5.xlarge"
  security_groups              = ["sg-a8e1eccd", "sg-49fcba2c", "sg-88b78bed", "sg-13387267"]
  single_subnet_instance_count = 1
  key_pair                     = "coast-master-key-dev"
  comcast_application_name     = "xreconfigurator"
  comcast_application_role     = "LoadBalancer"
  comcast_application_env      = "ci"
  comcast_iop_appid            = "31865"
  data_center                  = "ae"
  env_type                     = "ci"
  short_name                   = "lb-xreconfigds"
  service_name                 = "xreConfiguratorService"
  elk_domain                   = "xreconfigurator"
  vector_log_index             = "logz-xreconfigurator-forwarder"
  haproxy_log_index            = "logz-xreconfigurator-hap-xreconfigds"
  domain                       = "do.xcal.tv"
  service_ssl_port             = "9480"
  service_ssl_ipv6_enabled     = "false"
  service_ssl_backend_enabled  = "false"
  cert_name                    = "xreConfiguratorService"
  env_certs                    = "true"
  haproxy_template             = "hap_template_services_general_logv2_ftl.j2"
  hats_id                      = "APPDS_DO_CONFIGSERVICE_CI"
  swidtag_file                 = "XRE_Configurator.swidtag"
  ads_tsp_cb_url               = "https://secure.api.comcast.net/ccp-appdiscoveryAdminService-ci/"
  ads_tsp_normal_url           = "https://ci.applicationdiscoveryadminservice.ccp.xcal.tv:9443/appdiscoveryAdminService/"
}

#For CI, standard LB count is 1.
#Workspace naming format is xreconfigds_lb_de_(base date)_(iteration number)