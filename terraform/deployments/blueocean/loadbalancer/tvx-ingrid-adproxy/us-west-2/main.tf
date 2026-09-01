terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/prod/hatsmaker/blueocean/us-west-2/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-west-blueocean" {
  source                       = "../../../../../modules/hatsmakerv2altprof"
  user_data                    = "../../../../../scripts/user_data/hatsmaker/common/user_data_tvx_appds_template"
  vpc_id                       = "vpc-0d37635f180093974"
  subnet_id                    = "subnet-0527663451bb87223"
  aws_region                   = "us-west-2"
  instance_type                = "c5.xlarge"
#blueocean-haproxy-west          - sg-057640624336578b8
#blueocean-proxy-aw              - sg-0bf1a4a3b108c695e	- to be removed later
  security_groups              = ["sg-0cfb6afaf3b8e9d42", "sg-02464c313cf03993f", "sg-0bf1a4a3b108c695e", "sg-057640624336578b8"]
  single_subnet_instance_count = 4
  key_pair                     = "iap-oregon"
  comcast_application_name     = "blueocean"
  comcast_application_role     = "LoadBalancer"
  comcast_application_env      = "prod"
  comcast_iop_appid            = "67699"
  data_center                  = "aw"
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
  hats_id                      = "COAST_NEW_BLUEOCEAN_AW_PROD"
  ads_tsp_cb_url               = "https://secure.api.comcast.net/ccp-appdiscoveryAdminService-prod/"
  ads_tsp_normal_url           = "https://current.applicationdiscoveryadminservice.ccp.xcal.tv/appdiscoveryAdminService/"
  iam_instance_profile         = "CustomerManagedBasic_TaggingRole"
  aws_profile                  = "tvx-ingrid-adproxy_acct_02112025"
}

#For PROD, standard LB count is 4.
#Workspace naming format is blueocean_lb_aw_(base date)_(iteration number)