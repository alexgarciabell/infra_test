terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/prod/hatsmaker/configuratorService/us-west-2-ingest/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-west-configds-ingest" {
  source                       = "../../../../../modules/hatsmakerv2"
  user_data                    = "../../../../../scripts/user_data/hatsmaker/common/user_data_tvx_appds_template"
  vpc_id                       = "vpc-74695511"
  subnet_id                    = "subnet-d5286a8c"
  aws_region                   = "us-west-2"
  instance_type                = "c5.xlarge"
  security_groups              = ["sg-8c46e3f0", "sg-e5cbb89f", "sg-affd71d5"]
  single_subnet_instance_count = 1
  key_pair                     = "coast-master-key-prod"
  comcast_application_name     = "xreconfigurator"
  comcast_application_role     = "LoadBalancer"
  comcast_application_env      = "prod"
  comcast_iop_appid            = "31865"
  data_center                  = "aw"
  env_type                     = "prod"
  short_name                   = "lb-xreconfigds"
  service_name                 = "xreConfiguratorService"
  elk_domain                   = "xreconfigurator"
  vector_log_index             = "logz-xreconfigurator-forwarder"
  haproxy_log_index            = "logz-xreconfigurator-hap-xreconfigds"
  domain                       = "appds.xcal.tv"
  service_ssl_port             = "9480"
  service_ssl_ipv6_enabled     = "false"
  service_ssl_backend_enabled  = "false"
  cert_name                    = "xreConfiguratorService"
  env_certs                    = "true"
  haproxy_template             = "hap_template_services_general_logv2_ftl.j2"
  hats_id                      = "APPDS_AW_CONFIGSERVICE_INGEST_PROD"
  swidtag_file                 = "XRE_Configurator.swidtag"
  ads_tsp_cb_url               = "https://secure.api.comcast.net/ccp-appdiscoveryAdminService-prod/"
  ads_tsp_normal_url           = "https://current.applicationdiscoveryadminservice.ccp.xcal.tv/appdiscoveryAdminService/"
}

#For PROD, standard LB count is 1.
#Workspace naming format is xreconfigds_ingest_lb_aw_(base date)_(iteration number)
#This is a special dedicated LB for the ingest.configuratorservice.coast.xcal.tv (xrecowfish.configuratorservice.appds.r53.xcal.tv) endpoint