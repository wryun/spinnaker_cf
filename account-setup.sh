#!/bin/bash

# This must have this name, as it corresponds to the account used
# by the default spinnaker AMIs (Spinnaker extrapolates from the account name
# to the keypair name).
KEYPAIR_NAME=my-aws-account-keypair

set -ue -o pipefail

if [ -z "${AWS_DEFAULT_REGION}" ]; then
  echo 'Must set AWS_DEFAULT_REGION'
  exit 1
fi

echo 'Creating BaseIAMRole...'
aws iam create-role --role-name BaseIAMRole --assume-role-policy-document '{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}'

if [ ! -e "${KEYPAIR_NAME}.pem" ]; then
  echo 'Creating KeyPair (private key in ${KEYPAIR_NAME}.pem)...'
  aws ec2 create-key-pair --key-name "$KEYPAIR_NAME" --output text --query 'KeyMaterial' > "${KEYPAIR_NAME}.pem"
  chmod 400 "${KEYPAIR_NAME}.pem"
else
  echo 'Assuming existence of ${KEYPAIR_NAME}.pem means you already have a keypair.'
fi
