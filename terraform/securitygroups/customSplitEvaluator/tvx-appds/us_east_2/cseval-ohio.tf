provider "aws" {
  region  = "us-east-2"
  version = "2.0.0"
}

resource "aws_security_group" "cseval-backend-ohio" {
  name        = "cseval-backend"
  description = "Terraform Managed Internally - Do Not Manually Modify"
  vpc_id      = "vpc-8918a4e1"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = "${var.AWS_N_Virginia}"
    description = "N. Virginia - TVX-APPDS - SSL Port"
  }

  ingress {
    from_port   = 10847
    to_port     = 10847
    protocol    = "tcp"
    cidr_blocks = "${var.AWS_N_Virginia}"
    description = "N. Virginia - TVX-APPDS - Service Port"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = "${var.AWS_Ohio}"
    description = "Ohio - TVX-APPDS - SSL Port"
  }

  ingress {
    from_port   = 10847
    to_port     = 10847
    protocol    = "tcp"
    cidr_blocks = "${var.AWS_Ohio}"
    description = "Ohio - TVX-APPDS - Service Port"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = "${var.AWS_Oregon}"
    description = "Oregon - TVX-APPDS - SSL Port"
  }

  ingress {
    from_port   = 10847
    to_port     = 10847
    protocol    = "tcp"
    cidr_blocks = "${var.AWS_Oregon}"
    description = "Oregon - TVX-APPDS - Service Port"
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags {
    ComcastApplicationName        = "CSEVAL"
    ComcastApplicationRole        = "customSplitEvaluator"
    ComcastApplicationEnvironment = "Prod"
    DeploymentType                = "Terraform"
    Name                          = "cseval-backend-ohio"
  }
}

resource "aws_security_group" "cseval-haproxy-ohio" {
  name        = "cseval-haproxy"
  description = "Terraform Managed Internally - Do Not Manually Modify"
  vpc_id      = "vpc-8918a4e1"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = "${var.AWS_N_Virginia}"
    description = "N. Virginia - TVX-APPDS - SSL Port"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = "${var.AWS_Ohio}"
    description = "Ohio - TVX-APPDS - SSL Port"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = "${var.AWS_Oregon}"
    description = "Oregon - TVX-APPDS - SSL Port"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = "${var.xQube}"
    description = "xQube"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = "${var.Overcast}"
    description = "Overcast"
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags {
    ComcastApplicationName        = "CSEVAL"
    ComcastApplicationRole        = "Haproxy"
    ComcastApplicationEnvironment = "Prod"
    DeploymentType                = "Terraform"
    Name                          = "cseval-haproxy-ohio"
  }
}
