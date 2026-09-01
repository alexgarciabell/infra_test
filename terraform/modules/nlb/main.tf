# Specify the provider and access details

terraform {
  required_version = ">= 0.13"

  required_providers {
    aws = {
       source  = "hashicorp/aws"
      version = "~> 3.0"
     }
   }
 }

 provider "aws" {
  region  = "${var.aws_region}"
}

###############################################################################################
# AWS Load Balancer TargetGroup
###############################################################################################
resource "aws_lb_target_group" "icfar-tg" {
  name                 = "${var.comcast_application_name}-${var.comcast_application_env}-tg-${substr(timestamp(),0,10)}-${var.iteration}"
  port                 = "${var.application_port}"
  protocol             = "TCP"
  vpc_id               = "${var.aws_vpc}"

  health_check {
    protocol            = "${var.hc_call_protocol}"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 10
    interval            = 30
    path                = "${var.health_api}"
    port                = 9999
    matcher             = "200-399"
  }

  tags = {
    ComcastApplicationEnvironment = "${var.comcast_application_env}"
    ComcastApplicationName        = "${var.comcast_application_name}-tg"
    ComcastApplicationRole        = "${var.comcast_application_role}-tg"
    ComcastIOPApplicationID       = "${var.comcast_iop_appid}"
    DeploymentType                = "${var.deployment_type}"
    TerraformWorkSpace            = "${terraform.workspace}"
    Description                   = "${var.description}"
    Iteration                     = "${var.iteration}"
  }
}

###############################################################################################
# AWS Network Load Balancer
###############################################################################################

resource "aws_lb" "icfar-nlb" {
  name                              = "${var.comcast_application_name}-${var.comcast_application_env}-nlb-${substr(timestamp(),0,10)}-${var.iteration}"
  internal                          = true
  load_balancer_type                = "network"
  subnets                           = "${var.aws_subnets}"
  enable_deletion_protection        = "${var.enable_deletion_protection}"
  enable_cross_zone_load_balancing  = "${var.enable_cross_zone_load_balancing}"

  tags = {
    ComcastApplicationEnvironment = "${var.comcast_application_env}"
    ComcastApplicationName        = "${var.comcast_application_name}-nlb"
    ComcastApplicationRole        = "${var.comcast_application_role}-nlb"
    ComcastIOPApplicationID       = "${var.comcast_iop_appid}"
    DeploymentType                = "${var.deployment_type}"
    TerraformWorkSpace            = "${terraform.workspace}"
    Description                   = "${var.description}"
    Iteration                     = "${var.iteration}"
  }
}

resource "aws_lb_listener" "icfar-lb-listener" {
  load_balancer_arn = "${aws_lb.icfar-nlb.arn}"
  port              = "${var.application_port}"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.icfar-tg.arn}"
  }
}
