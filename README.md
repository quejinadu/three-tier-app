## This is a repository that will be used to spin up a VPC as well as a three tier web architecture

## Setup VPC
1. Change directory to the VPC folder
2. Run the following commands
  - terraform 'init'
  - terraform 'plan'
  - terraform 'apply'
 This should create the VPC where the application will be installed

## Deploy the Application
1. Change directory to the Application folder
2. Run the following commands
  - terraform 'init'
  - terraform 'plan'
  - terraform 'apply'
 This should create the three tier application

## Questions
1. How would a future application obtain the load balancer's DNS name if it wanted to use this service
 'Ans'- The value of the Load balancer dns name will be put in an output.tf file. Then use terraform remote state to retrieve this value from your other terraform configuration.

2. What aspects need to be considered to make the code work in a CD pipeline (how does it successfully and safely get into production)?
 'Ans' Before moving my workload to Prod, I will consider the below:
       - Codes should be scanned before pushing into production to ensure they are in line with InfoSec policies. Sentinel in Terraform Enterprise can be used to define these rules. 
       - Ensure test is done thoroughly in dev environment and signed off by product owners.
       - For authentication token and secret parameters, these should be stored in external        identity-based secrets management system like Harshicorp Vault.
       - When the code is pushed to the code repository on a feature branch, it has to go through the process of peer review by at least two reviewers. Once approved, it can then be merged to the appropriate branch
 
My pipeline of choice that I have worked with is Jenkins. For this deployment, I will create a pipeline for the different environment and the builds in these environment will be triggered by a webhook after code has been merged into the respective branch. These branches can also be segmented in Terraform by using different 'tfvars' file for the different environment (Prod, Qual, Stage, Dev)