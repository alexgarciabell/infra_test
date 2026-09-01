terraform {
  backend "s3" {
    bucket = "coast-infrastructure"
    key    = "coast/staging/hatsmaker/adsadmin/us-west-2/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "ci-west-adsadmin" {
  source                       = "../../../../../modules/hatsmakerv2"
  user_data                    = "../../../../../scripts/user_data/hatsmaker/common/user_data_tvx_appds_template"
  vpc_id                       = "vpc-ffc0399a"
  subnet_id                    = "subnet-66fb3103"
  aws_region                   = "us-west-2"
  instance_type                = "c5.xlarge"
  security_groups              = ["sg-d8da89a5", "sg-b0000dcc", "sg-28e5374f"]
  single_subnet_instance_count = 1
  key_pair                     = "coast-master-key-dev"
  comcast_application_name     = "adsadmin"
  comcast_application_role     = "haproxy"
  comcast_application_env      = "ci"
  data_center                  = "dw"
  env_type                     = "ci"
  short_name                   = "lb-adsadmin"
  service_name                 = "appdiscoveryAdminService"
  elk_domain                   = "xvpcapitalservices"
  vector_log_index             = "logz-capitalservices-forwarder"
  haproxy_log_index            = "logz-capitalservices-hap-adsadmin"
  domain                       = "do.xcal.tv"
  service_ssl_port             = "9443"
  service_ssl_ipv6_enabled     = "false"
  service_ssl_backend_enabled  = "false"
  cert_name                    = "appdiscoveryAdminService"
  env_certs                    = "true"
  #haproxy_template             = "haproxy_ads_ftl.j2"
  haproxy_template             = "hap_template_tsp_admin_ftl.j2"
  hats_id                      = "APPDS_DW_ADSADMIN_CI"
  swidtag_file                 = "Application_Discovery_Service.swidtag"
  #ads_tsp_cb_url               = "https://secure.api.comcast.net/ccp-appdiscoveryAdminService-ci/"
  #ads_tsp_normal_url           = "https://ci.applicationdiscoveryadminservice.ccp.xcal.tv:9443/appdiscoveryAdminService/"
}

#For CI, standard LB count is 1.
#Workspace naming format is adsadmin_lb_dw_(base date)_(iteration number)