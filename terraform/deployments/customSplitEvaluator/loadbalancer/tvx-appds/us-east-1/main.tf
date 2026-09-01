terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/prod/hatsmaker/customSplitEvaluator/us-east-1/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-east-cseval" {
  source                       = "../../../../../modules/hatsmakerv2"
  user_data                    = "../../../../../scripts/user_data/hatsmaker/common/user_data_tvx_appds_template"
  vpc_id                       = "vpc-08b9236c"
  subnet_id                    = "subnet-da41b882"
  aws_region                   = "us-east-1"
  instance_type                = "c5.xlarge"
  security_groups              = ["sg-0d10804914e8efb76", "sg-39f23949", "sg-74212605"]
  single_subnet_instance_count = 2
  key_pair                     = "coast-master-key-prod"
  comcast_application_name     = "cseval"
  comcast_application_role     = "LoadBalancer"
  comcast_application_env      = "prod"
  comcast_iop_appid            = "103103"
  data_center                  = "ae"
  env_type                     = "prod"
  short_name                   = "lb-cseval"
  service_name                 = "customSplitEvaluator"
  elk_domain                   = "xvpcapitalservices"
  vector_log_index             = "logz-capitalservices-forwarder"
  haproxy_log_index            = "logz-capitalservices-hap-cse"
  domain                       = "appds.xcal.tv"
  service_ssl_port             = "443"
  service_ssl_ipv6_enabled     = "false"
  service_ssl_backend_enabled  = "false"
  cert_name                    = "customSplitEvaluator"
  env_certs                    = "true"
  #haproxy_template             = "haproxy_ads_ftl.j2"
  haproxy_template             = "hap_template_services_general_logv2_ftl.j2"
  hats_id                      = "ICFAR_AE_CSEVAL_PROD"
  swidtag_file                 = "Custom_Split_Evaluator.swidtag"
  ads_tsp_cb_url               = "https://secure.api.comcast.net/ccp-appdiscoveryAdminService-prod/"
  ads_tsp_normal_url           = "https://current.applicationdiscoveryadminservice.ccp.xcal.tv/appdiscoveryAdminService/"
}

#For PROD, standard LB count is 2.
#Workspace naming format is cse_lb_ae_(base date)_(iteration number)