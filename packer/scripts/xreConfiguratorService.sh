#!/bin/bash

# Exit on first error
set -o errexit
# Exit if we encounter uninitialized variable usage
set -o nounset

if [[ $# -lt 2 ]]; then
  echo "usage: xreConfiguratorService.sh <version> <account> <dry_run OR real_run>"
  echo "version = 1.2.3[-SNAPSHOT]"
  echo "account = appds | do"
  echo "Note: Packer should be on this path: /opt/xcal/apps/packers/packer_1.3.2/packer"
  exit 1
fi

version=$1
# Determine artifact repository
repo="https://artifactory.comcast.com/artifactory/x1IcsCoreServices-libs-releases/"
if [[ "${version}" == *"SNAPSHOT"* ]]; then
  repo="https://artifactory.comcast.com/artifactory/x1IcsCoreServices-libs-snapshots/"
fi

account=$2
# Set account parameters
if [[ "${account}" == "appds" ]]; then
  vpc_id="vpc-74695511"
  subnet="subnet-d5286a8c"
  region="us-west-2"
  vault_path=/secret/appds/aws/appds/iam_user_creds
else
  if [[ "${account}" == "do" ]]; then
    vpc_id="vpc-ffc0399a"
    subnet="subnet-ec739b9b"
    region="us-west-2"
    vault_path=/secret/appds/aws/do/iam_user_creds
  fi
fi

if [[ "$3" == "dry_run" ]]; then
  echo "Conducting a dry run of Packer invocation"
  dry_run=true
else
  echo "Running Packer to create AMIs"
  dry_run=false
fi

echo "version = ${version}"
echo "repository = ${repo}"
echo "vpc = ${vpc_id}"
echo "subnet = ${subnet}"
echo "region = ${region}"

# Read AWS credentials from Vault
vault_dn=current.vault.do.xcal.tv
aws_access_key=`ssh -q -T ${vault_dn} <<EOF
  vault read -field=access_key ${vault_path}
EOF
`
aws_secret_key=`ssh -q -T ${vault_dn} <<EOF
  vault read -field=secret_key ${vault_path}
EOF
`

# Run Packer
#packer=run_packer_1.3.2
packer=/opt/xcal/apps/packers/packer_1.3.2/packer
echo "Building xreConfiguratorService Packer template."
if [[ "$dry_run" == "true" ]]; then
  echo "${packer} build -var aws_access_key=${aws_access_key} -var aws_secret_key=${aws_secret_key} \
-var vpc_id=${vpc_id} -var subnet_id=${subnet} -var ec2_region=${region} \
-var artifact_version=${version} -var artifact_repo=${repo} \
../configs/xreConfiguratorService.json"
else
  ${packer} build -var aws_access_key=${aws_access_key} -var aws_secret_key=${aws_secret_key} \
-var vpc_id=${vpc_id} -var subnet_id=${subnet} -var ec2_region=${region} \
-var artifact_version=${version} -var artifact_repo=${repo} \
../configs/xreConfiguratorService.json
fi

echo "Done."
