provider "aws" {
  region  = "us-east-1"
  version = "2.0.0"
}

resource "aws_security_group" "cseval-backend-east" {
  name        = "cseval-backend"
  description = "Terraform Managed Internally - Do Not Manually Modify"
  vpc_id      = "vpc-0cb21169"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = "${var.AWS_N_Virginia}"
    description = "N. Virginia - TVX-DO - SSL Port"
  }

  ingress {
    from_port   = 10847
    to_port     = 10847
    protocol    = "tcp"
    cidr_blocks = "${var.AWS_N_Virginia}"
    description = "N. Virginia - TVX-DO - Service Port"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = "${var.AWS_Oregon}"
    description = "Oregon - TVX-DO - SSL Port"
  }

  ingress {
    from_port   = 10847
    to_port     = 10847
    protocol    = "tcp"
    cidr_blocks = "${var.AWS_Oregon}"
    description = "Oregon - TVX-DO - Service Port"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = "${var.Localhost}"
    description = "Localhost"
  }

  ingress {
    from_port   = 10847
    to_port     = 10847
    protocol    = "tcp"
    cidr_blocks = "${var.Localhost}"
    description = "Localhost"
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
    ComcastApplicationEnvironment = "CI"
    DeploymentType                = "Terraform"
    Name                          = "cseval-backend-east"
  }

}

resource "aws_security_group" "cseval-haproxy-east" {
  name        = "cseval-haproxy"
  description = "Terraform Managed Internally - Do Not Manually Modify"
  vpc_id      = "vpc-0cb21169"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = "${var.AWS_N_Virginia}"
    description = "N. Virginia - TVX-DO - SSL Port"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = "${var.AWS_Oregon}"
    description = "Oregon - TVX-DO - SSL Port"
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

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = "${var.Localhost}"
    description = "Localhost"
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
    ComcastApplicationEnvironment = "CI"
    DeploymentType                = "Terraform"
    Name                          = "cseval-haproxy-east"
  }
}
