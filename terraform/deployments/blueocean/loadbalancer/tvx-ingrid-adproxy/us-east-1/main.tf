terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/prod/hatsmaker/blueocean/us-east-1/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-east-blueocean" {
  source                       = "../../../../../modules/hatsmakerv2altprof"
  user_data                    = "../../../../../scripts/user_data/hatsmaker/common/user_data_tvx_appds_template"
  vpc_id                       = "vpc-0a3f2e0d219051aa2"
  subnet_id                    = "subnet-025e9088237ac3a15"
  aws_region                   = "us-east-1"
  instance_type                = "c5.xlarge"
#blueocean-haproxy-east          - sg-0bdbd5975608fb2a0
#blueocean-proxy-ae              - sg-0d86b84be1c81c3e8 - to be removed later
  security_groups              = ["sg-0689c92048bc8ddf3", "sg-0036586f83e920cf7", "sg-0d86b84be1c81c3e8", "sg-0bdbd5975608fb2a0"]
  single_subnet_instance_count = 4
  key_pair                     = "iap-virginia"
  comcast_application_name     = "blueocean"
  comcast_application_role     = "LoadBalancer"
  comcast_application_env      = "prod"
  comcast_iop_appid            = "67699"
  data_center                  = "ae"
  env_type                     = "prod"
  short_name                   = "lb-bo"
  service_name                 = "blueocean"
  elk_domain                   = "blueocean"
  vector_log_index             = "logz-blueocean-forwarder"
  haproxy_log_index            = "logz-blueocean-hap-blueocean"
  domain                       = "iap.xcal.tv"
  service_ssl_port             = "443"
  service_ssl_ipv6_enabled     = "false"
  service_ssl_backend_enabled  = "false"
  cert_name                    = "blueocean"
  env_certs                    = "true"
  #haproxy_template             = "haproxy_bo_ftl.j2"
  haproxy_template             = "hap_template_services_general_logv2_ftl.j2"
  hats_id                      = "COAST_NEW_BLUEOCEAN_AE_PROD"
  ads_tsp_cb_url               = "https://secure.api.comcast.net/ccp-appdiscoveryAdminService-prod/"
  ads_tsp_normal_url           = "https://current.applicationdiscoveryadminservice.ccp.xcal.tv/appdiscoveryAdminService/"
  iam_instance_profile         = "CustomerManagedBasic_TaggingRole"
  aws_profile                  = "tvx-ingrid-adproxy_acct_02112025"
}

#For PROD, standard LB count is 4.
#Workspace naming format is blueocean_lb_ae_(base date)_(iteration number)