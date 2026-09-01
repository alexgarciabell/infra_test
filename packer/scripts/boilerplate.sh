#!/bin/bash

# Exit on first error
set -o errexit
# Exit if we encounter uninitialized variable usage
set -o nounset

echo "Building boilerplate Packer template."
if [[ $# -eq 1 ]] ; then
  packer build \
    -var "ec2_region=$1" \
    ../configs/boilerplate.json
else
  packer build \
    ../configs/boilerplate.json
fi
echo "Done."
