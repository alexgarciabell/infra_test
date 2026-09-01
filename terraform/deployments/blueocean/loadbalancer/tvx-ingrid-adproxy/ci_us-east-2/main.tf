terraform {
  backend "s3" {
    bucket = "coast-infrastructure"
    key    = "coast/staging/hatsmaker/blueocean/us-east-2/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "ci-ohio-blueocean" {
  source                       = "../../../../../modules/hatsmakerv2altprof"
  user_data                    = "../../../../../scripts/user_data/hatsmaker/common/user_data_tvx_appds_template"
  vpc_id                       = "vpc-0dc2bb57a8fde711a"
  subnet_id                    = "subnet-0776ec04ba261a419"
  aws_region                   = "us-east-2"
  instance_type                = "c5.xlarge"
  security_groups              = ["sg-019fa2459bfabcb15", "sg-0b009c3bcd4c2201b", "sg-0c16277223c7fa941", "sg-002ca9c5dfce4e08b", "sg-0c0f09127ecf581a7"]
  single_subnet_instance_count = 1
  key_pair                     = "iap-ohio"
  comcast_application_name     = "blueocean"
  comcast_application_role     = "LoadBalancer"
  comcast_application_env      = "ci"
  comcast_iop_appid            = "67699"
  data_center                  = "do"
  env_type                     = "ci"
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
  hats_id                      = "COAST_NEW_BLUEOCEAN_OH_CI"
  ads_tsp_cb_url               = "https://secure.api.comcast.net/ccp-appdiscoveryAdminService-ci/"
  ads_tsp_normal_url           = "https://ci.applicationdiscoveryadminservice.ccp.xcal.tv:9443/appdiscoveryAdminService/"
  iam_instance_profile         = "CustomerManagedBasic_TaggingRole"
  aws_profile                  = "tvx-ingrid-adproxy_acct_02112025"
}

#For CI, standard LB count is 1.
#Workspace naming format is blueocean_lb_do_(base date)_(iteration number)