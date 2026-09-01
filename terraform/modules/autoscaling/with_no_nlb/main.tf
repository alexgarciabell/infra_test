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


resource "random_string" "stacknamestring" {
  length  = 2
  special = false
  upper   = false
}

#resource "random_integer" "rand_host_num" {
#  min = 100
#  max = 999
#
#  keepers = {
#    new_num_val = var.name
#  }
#}

data "template_file" "user_data" {
  template = "${var.user_data}"

  vars = {
    data_center              = "${var.data_center}"
    random_string            = "${random_string.stacknamestring.result}"
    comcast_application_name = "${var.comcast_application_name}"
    comcast_application_role = "${var.comcast_application_role}"
    domain_name              = "${var.domain}"
    role_id                  = var.role_id
    secret_id                = var.secret_id
  }
}

###############################################################################################
# EC2 Instance pulling latest image
###############################################################################################
data "aws_ami" "application_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["icfar-${var.comcast_service_name}-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "tag:stable"
    values = ["true"]
  }

  owners = ["self"]
}

###############################################################################################
# EC2 Instance Auto-scaling-launchtemplate
###############################################################################################

resource "aws_launch_template" "icfar-asg-ec2-lt" {
  name                        = "${var.comcast_application_name}-${var.comcast_application_env}-${var.application_version}-${var.version_id}"
  image_id                    = "${data.aws_ami.application_ami.id}"
  instance_type               = "${var.aws_instance_type}"
  network_interfaces {
    associate_public_ip_address = false
    security_groups             = "${var.aws_security_groups}"
  }
  user_data                     = "${base64encode(data.template_file.user_data.rendered)}"
  iam_instance_profile           { name = "${var.iam_instance_profile}" }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens = "required"
  }
}

###############################################################################################
# EC2 Instance Auto-scaling-notification
###############################################################################################

#resource "aws_autoscaling_notification" "asg_notification" {
#  group_names = [
#    "${aws_autoscaling_group.icfar-asg-ec2-hostgroup.name}",
#  ]

#  notifications = [
#    "autoscaling:EC2_INSTANCE_LAUNCH",
#    "autoscaling:EC2_INSTANCE_TERMINATE",
#    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
#    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
#  ]

##  topic_arn = "${aws_sns_topic.email_id.arn}"
#}

# resource "aws_sns_topic" "email_id" {
#   name = "${var.comcast_application_name}_autoscaling"
# }

###############################################################################################
# EC2 Instance Auto-scaling
###############################################################################################

resource "aws_autoscaling_group" "icfar-asg-ec2-hostgroup" {
  name                 = "${var.comcast_application_name}-${var.comcast_application_env}-${var.application_version}-${var.version_id}"
  vpc_zone_identifier  = "${var.aws_subnets}"
  min_size             = "${var.min_size}"
  max_size             = "${var.max_size}"
  desired_capacity     = "${var.desired_capacity}"
  health_check_type    = "${var.health_check_type}"
  launch_template {
    id      = aws_launch_template.icfar-asg-ec2-lt.id
    version = aws_launch_template.icfar-asg-ec2-lt.latest_version
  }

  enabled_metrics = ["GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupMaxSize",
    "GroupMinSize",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances",
  ]

  tags = [
    {
      key                 = "Name"
      value               = "${var.name}-${var.data_center}-${random_string.stacknamestring.result}-${var.comcast_service_name}-asghost.${var.domain}"
      propagate_at_launch = true
    },
    {
      key                 = "ComcastApplicationEnvironment"
      value               = "${var.comcast_application_env}"
      propagate_at_launch = true
    },
    {
      key                 = "ComcastApplicationName"
      value               = "${var.comcast_application_name}"
      propagate_at_launch = true
    },
    {
      key                 = "ComcastApplicationRole"
      value               = "${var.comcast_application_role}"
      propagate_at_launch = true
    },
    {
      key                 = "ComcastIOPApplicationID"
      value               = "${var.comcast_iop_appid}"
      propagate_at_launch = true
    },
    {
      key                 = "DeploymentType"
      value               = "${var.deployment_type}"
      propagate_at_launch = true
    },
    {
      key                 = "Description"
      value               = "${var.description}"
      propagate_at_launch = true
    },
    {
      key                 = "TerraformWorkSpace"
      value               = "${terraform.workspace}"
      propagate_at_launch = true
    },
	{
      key                 = "IsTargetGroupAttached"
      value               = "false"
      propagate_at_launch = true
    },
	{
      key                 = "ApplicationVersion"
      value               = "${var.application_version}"
      propagate_at_launch = true
    },
    {
      key                 = "Version"
      value               = "${var.version_id}"
      propagate_at_launch = true
    }
  ]

  lifecycle {
    create_before_destroy = true
    ignore_changes        = ["name"]
  }
}

resource "aws_autoscaling_policy" "icfar-asg-ec2-policy-max" {
  //  count                  = "${var.regular_scaling == "yes" ? "1" : "0"}"
  name                   = "icfar-asgpolicy-${var.comcast_application_name}-${var.application_version}-${var.version_id}-max"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = "${aws_autoscaling_group.icfar-asg-ec2-hostgroup.name}"
}

resource "aws_autoscaling_policy" "icfar-asg-ec2-policy-min" {
  //  count                  = "${var.regular_scaling == "yes" ? "1" : "0"}"
  name                   = "icfar-asgpolicy-${var.comcast_application_name}-${var.application_version}-${var.version_id}-min"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = "${aws_autoscaling_group.icfar-asg-ec2-hostgroup.name}"
}

###############################################################################################
# ECS Instance CloudWatch Alarms
###############################################################################################

resource "aws_cloudwatch_metric_alarm" "icfar-cloudwatch-cpu-max" {
  //  count               = "${var.regular_scaling == "yes" ? "1" : "0"}"
  alarm_name          = "icfar-${var.comcast_application_name}-${var.application_version}-${var.version_id}-max_cpu"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "${var.cpu_max}"

  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.icfar-asg-ec2-hostgroup.name}"
  }

  alarm_description = "Metric to check max total CPU usage on EC2 resources"

  alarm_actions = ["${aws_autoscaling_policy.icfar-asg-ec2-policy-max.arn}"]
}

resource "aws_cloudwatch_metric_alarm" "icfar-cloudwatch-cpu-min" {
  //  count               = "${var.regular_scaling == "yes" ? "1" : "0"}"
  alarm_name          = "icfar-${var.comcast_application_name}-${var.application_version}-${var.version_id}-min_cpu"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "5"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "${var.cpu_min}"

  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.icfar-asg-ec2-hostgroup.name}"
  }

  alarm_description = "Metric to check min total CPU usage on EC2 resources"

  alarm_actions = ["${aws_autoscaling_policy.icfar-asg-ec2-policy-min.arn}"]
}
