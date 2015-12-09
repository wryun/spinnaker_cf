# spinnaker_cf
Cloudformation template to launch spinnaker in non-prod environment on similar to the instructions here http://spinnaker.io/documentation/getting_started.html

Instructions to run Spinnaker using this Cloudformation:

1. Create an EC2 role - BaseIAMRole.
  Goto Console > AWS Identity & Access Management > Roles.
  Click Create New Role.
  Set Role Name to BaseIAMRole. Click Next Step.
  On Select Role Type screen, hit Select for Amazon EC2.
  Click Next Step.
  On Review screen, click Create Role.
  EC2 instances launched with Spinnaker will be associated with this role.
  
2.Create an EC2 Key Pair for connecting to your instances.
  Goto Console > EC2 > Key Pairs.
  Click Create Key Pair.
  Name the key pair my-aws-account-keypair. (Note: this must match your account name plus “-keypair”)
  AWS will download file my-aws-account-keypair.pem to your computer. chmod 400 the file.
  
3.Copy the "config" file and place it in this folder ~/.ssh/ and replace <> with your instance info ---See sample in the repository
   
4. Copy the spinnaker-tunnel.sh file with the following content, and give it execute permissions

5. Run Spinnaker on AWS using Cloudformation
   On AWS Console go to Cloudformation > Create new Stack
   Select the template file > Click Next
   Select the key previously created, enter password for a credential to be created, and optionally change VPC and subnet info if needed
   Accept IAM warning and click Submit
   
6. Execute the script to start your Spinnaker tunnel
    ./spinnaker-tunnel.sh start
    Open browser to http://localhost:9000 to access Spinnaker
  You can also stop your Spinnaker tunnel
    ./spinnaker-tunnel.sh stop
    
