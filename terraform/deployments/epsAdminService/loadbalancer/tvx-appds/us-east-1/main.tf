terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/prod/hatsmaker/epsadmin/us-east-1/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-east-epsadmin" {
  source                       = "../../../../../modules/hatsmakerv2"
  user_data                    = "../../../../../scripts/user_data/hatsmaker/common/user_data_tvx_appds_template"
  vpc_id                       = "vpc-08b9236c"
  subnet_id                    = "subnet-da41b882"
  aws_region                   = "us-east-1"
  instance_type                = "c5.xlarge"
  security_groups              = ["sg-996f84e0", "sg-021d7a7b", "sg-74212605", "sg-155c2360", "sg-0423a87fd69416428"]
  single_subnet_instance_count = 1
  key_pair                     = "coast-master-key-prod"
  comcast_application_name     = "epsadmin"
  comcast_application_role     = "LoadBalancer"
  comcast_application_env      = "prod"
  comcast_iop_appid            = "31858"
  data_center                  = "ae"
  env_type                     = "prod"
  short_name                   = "lb-epsadmin"
  service_name                 = "epsAdminService"
  elk_domain                   = "xvpcapitalservices"
  vector_log_index             = "logz-capitalservices-forwarder"
  haproxy_log_index            = "logz-capitalservices-hap-epsadmin"
  domain                       = "appds.xcal.tv"
  service_ssl_port             = "9443"
  service_ssl_ipv6_enabled     = "false"
  service_ssl_backend_enabled  = "false"
  cert_name                    = "epsAdminService"
  env_certs                    = "true"
  haproxy_template             = "hap_template_ui_general_logv2_ftl.j2"
  hats_id                      = "APPDS_AE_EPSADMIN_PROD"
  swidtag_file                 = "Entertainment_Policy_Service.swidtag"
  ads_tsp_cb_url               = "https://secure.api.comcast.net/ccp-appdiscoveryAdminService-prod/"
  ads_tsp_normal_url           = "https://current.applicationdiscoveryadminservice.ccp.xcal.tv/appdiscoveryAdminService/"
}

#For PROD, standard LB count is 1.
#Workspace naming format is epsadmin_lb_ae_(base date)_(iteration number)