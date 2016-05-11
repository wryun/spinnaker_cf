#!/bin/bash

# Must not have a '-' (otherwise fun things happen).
STACK_NAME=spinnaker

pause() {
  read -n1 -p 'Press c to continue...' key
  if [ "$key" != 'c' ]; then
    echo ' Quitting.'
    exit 1
  fi
  echo
}

if [ -z "${AWS_DEFAULT_REGION}" ]; then
  echo 'Must set AWS_DEFAULT_REGION'
  exit 2
fi

set -ue -o pipefail

echo "Deploying Spinnaker as CloudFormation stack '$STACK_NAME' in ${AWS_DEFAULT_REGION}..."
pause

aws cloudformation create-stack --stack-name "$STACK_NAME" --template-body 'file://spinnakercf.template' --capabilities CAPABILITY_IAM

echo 'Run the following command to see the current state:'
echo "  aws cloudformation describe-stacks --stack-name '$STACK_NAME'"
