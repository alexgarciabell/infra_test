provider "aws" {
  region  = "us-west-2"
  version = "2.0.0"
}

resource "aws_security_group" "ads-backend-west" {
  name        = "ads-backend"
  description = "Terraform Managed Internally - Do Not Manually Modify"
  vpc_id      = "vpc-74695511"

  ingress {
    from_port   = 9472
    to_port     = 9472
    protocol    = "tcp"
    cidr_blocks = "${var.AWS_Oregon}"
    description = "Oregon - TVX-APPDS - SSL Port"
  }

  ingress {
    from_port   = 10232
    to_port     = 10232
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
    ComcastApplicationName        = "ADS"
    ComcastApplicationRole        = "appDiscoveryService"
    ComcastApplicationEnvironment = "Prod"
    DeploymentType                = "Terraform"
    Name                          = "ads-backend-west"
  }
}

resource "aws_security_group" "ads-haproxy-west" {
  name        = "ads-haproxy"
  description = "Terraform Managed Internally - Do Not Manually Modify"
  vpc_id      = "vpc-74695511"

  ingress {
    from_port   = 9472
    to_port     = 9472
    protocol    = "tcp"
    cidr_blocks = "${var.XRE}"
    description = "XRE"
  }

  ingress {
    from_port   = 9472
    to_port     = 9472
    protocol    = "tcp"
    cidr_blocks = "${var.Codebig_TVX_PO}"
    description = "Codebig TVX-PO"
  }

  ingress {
    from_port   = 9472
    to_port     = 9472
    protocol    = "tcp"
    cidr_blocks = "${var.Codebig_TVX_CH}"
    description = "Codebig TVX-CH"
  }

  ingress {
    from_port   = 9472
    to_port     = 9472
    protocol    = "tcp"
    cidr_blocks = "${var.Codebig_AS_D_HO_C_Openstack}"
    description = "Codebig AS-D and HO-C in Openstack"
  }

  ingress {
    from_port   = 9472
    to_port     = 9472
    protocol    = "tcp"
    cidr_blocks = "${var.Overcast}"
    description = "Overcast"
  }

  ingress {
    from_port   = 9472
    to_port     = 9472
    protocol    = "tcp"
    cidr_blocks = "${var.Perseus}"
    description = "Perseus"
  }

  ingress {
    from_port   = 9472
    to_port     = 9472
    protocol    = "tcp"
    cidr_blocks = "${var.DVR}"
    description = "DVR"
  }

  ingress {
    from_port   = 9472
    to_port     = 9472
    protocol    = "tcp"
    cidr_blocks = "${var.AWS_N_Virginia}"
    description = "N. Virginia - TVX-APPDS - SSL Port"
  }

  ingress {
    from_port   = 9472
    to_port     = 9472
    protocol    = "tcp"
    cidr_blocks = "${var.AWS_Ohio}"
    description = "Ohio - TVX-APPDS - SSL Port"
  }

  ingress {
    from_port   = 9472
    to_port     = 9472
    protocol    = "tcp"
    cidr_blocks = "${var.AWS_Oregon}"
    description = "Oregon - TVX-APPDS - SSL Port"
  }

  ingress {
    from_port   = 9472
    to_port     = 9472
    protocol    = "tcp"
    cidr_blocks = "${var.XRE_xCloud_Ashburn}"
    description = "XRE - xCloud - Ashburn"
  }

  ingress {
    from_port   = 9472
    to_port     = 9472
    protocol    = "tcp"
    cidr_blocks = "${var.XRE_xCloud_Chicago}"
    description = "XRE - xCloud - Chicago"
  }

  ingress {
    from_port   = 9472
    to_port     = 9472
    protocol    = "tcp"
    cidr_blocks = "${var.XRE_xCloud_Hillsboro}"
    description = "XRE - xCloud - Hillsboro"
  }

  ingress {
    from_port   = 9472
    to_port     = 9472
    protocol    = "tcp"
    cidr_blocks = "${var.CodeBig_CCP_Public_Ashburn}"
    description = "CodeBig CCP (xCloud) - Public - Ashburn"
  }

  ingress {
    from_port   = 9472
    to_port     = 9472
    protocol    = "tcp"
    cidr_blocks = "${var.CodeBig_CCP_Public_Chicago}"
    description = "CodeBig CCP (xCloud) - Public - Chicago"
  }

  ingress {
    from_port   = 9472
    to_port     = 9472
    protocol    = "tcp"
    cidr_blocks = "${var.CodeBig_CCP_Public_Hillsboro}"
    description = "CodeBig CCP (xCloud) - Public - Hillsboro"
  }

  ingress {
    from_port   = 9472
    to_port     = 9472
    protocol    = "tcp"
    cidr_blocks = "${var.CodeBig_CCP_Public_Ashburn_Ex}"
    description = "CodeBig CCP (xCloud) - Public - Ashburn Extra"
  }

  ingress {
    from_port   = 9472
    to_port     = 9472
    protocol    = "tcp"
    cidr_blocks = "${var.CodeBig_CCP_Public_Chicago_Ex}"
    description = "CodeBig CCP (xCloud) - Public - Chicago Extra"
  }

  ingress {
    from_port   = 9472
    to_port     = 9472
    protocol    = "tcp"
    cidr_blocks = "${var.CodeBig_CCP_Public_Hillsboro_Ex}"
    description = "CodeBig CCP (xCloud) - Public - Hillsboro Extra"
  }

  ingress {
    from_port   = 9472
    to_port     = 9472
    protocol    = "tcp"
    cidr_blocks = "${var.XRE_Thor_xCloud_Chicago_1}"
    description = "OTTX/XRE (Thor) - xCloud - Chicago AZ1a"
  }

   ingress {
    from_port   = 9472
    to_port     = 9472
    protocol    = "tcp"
    cidr_blocks = "${var.XRE_Thor_xCloud_Hillsboro_1}"
    description = "OTTX/XRE (Thor) - xCloud - Hillsboro AZ1a"
  }

  ingress {
    from_port   = 9472
    to_port     = 9472
    protocol    = "tcp"
    cidr_blocks = "${var.XRE_Thor_xCloud_Ashburn_1}"
    description = "OTTX/XRE (Thor) - xCloud - Ashburn AZ1a"
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags {
    ComcastApplicationName        = "ADS"
    ComcastApplicationRole        = "Haproxy"
    ComcastApplicationEnvironment = "Prod"
    DeploymentType                = "Terraform"
    Name                          = "ads-haproxy-west"
  }
}
