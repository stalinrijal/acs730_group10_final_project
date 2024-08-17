# acs730_group10_final_project
acs730_group10_final_project


Terraform AWS Infrastructure Setup
Project Structure
variables.tf: Defines configurable variables for the project, including the AWS region, instance type, and AMI ID.
ec2.tf: Manages the EC2 instances, both in public and private subnets, with user data scripts to install and start Apache HTTP Server (httpd).
linux: Contains the SSH private key used for accessing EC2 instances. (Ensure this file is kept secure.)
loadbalancer.tf: Configures an AWS Elastic Load Balancer (ELB) to distribute incoming traffic across the EC2 instances.
main.tf: The primary configuration file that integrates all resources and provider settings.
outputs.tf: Defines output variables that provide information about the created resources, such as the load balancer's DNS name and EC2 public IPs.
security_groups.tf: Manages security groups for controlling inbound and outbound traffic to the EC2 instances.
vpc.tf: Configures the Virtual Private Cloud (VPC), including public and private subnets, route tables, an internet gateway, and a NAT gateway.
Prerequisites
Before using this Terraform configuration, ensure you have the following:
An AWS account with appropriate permissions.
Terraform installed on your local machine.
The SSH private key (linux) is securely stored.
Make a s3 bucket named “acs730-group10-bucket” to store data 
How to Use
Clone the Repository:
Open your terminal or command prompt and run the following commands:


git clone <repository-url>
cd <repository-directory>

Initialize Terraform:
In the terminal, run:

terraform init

Review and Customize Variables:
Review the variables.tf file and modify the variables as needed, such as aws_region, instance_type, and linux_ami_id.

Apply the Terraform Configuration:
Run the following command to create the infrastructure:

terraform apply
Terraform will prompt you to confirm the actions. Type yes to proceed.
The infrastructure will be created in your AWS account.


Access EC2 Instances:
Use the SSH private key (linux) to access the EC2 instances. For example:

ssh -i path/to/linux.pem ec2-user@<public-ip-address>


View Outputs:
After applying the configuration, view the outputs defined in outputs.tf to get the DNS of the load balancer and other useful information by running:

terraform output




Clean Up
To destroy the infrastructure and avoid incurring unnecessary costs, run:

terraform destroy

Security Considerations
Ensure the SSH private key (linux) is kept secure and not shared publicly.
Regularly review and update security group rules to maintain a secure environment.


README for Ansible Setup
This guide provides step-by-step instructions to install Ansible and the required dependencies on your system. Follow the instructions below according to your operating system.
Prerequisites
You need to have a user with sudo privileges.
Ensure that your system is connected to the internet.
1. Update the Package Manager
Before installing Ansible, update your package manager to ensure that you are installing the latest versions of the packages.

Amazon Linux/CentOS


sudo yum update

2. Install Ansible
Once the package manager is updated, install Ansible on your system.
Ubuntu/Debian


sudo apt install ansible
3. Verify the Installation
After the installation is complete, verify that Ansible is installed correctly by checking its version.

ansible --version

4. Install Additional Required Packages
Ansible may require additional packages depending on your environment. Below are the instructions to install Python, pip, and the AWS SDK for Python (boto3).
Install Python and pip
Ubuntu/Debian


sudo apt install python3 python3-pip

Install boto3 (AWS SDK for Python)
After installing Python and pip, you can install boto3 using pip3.

pip3 install boto3


Ansible playbook using a dynamic inventory for AWS EC2 instances.
Ansible-playbook -i aws_ec2.yml myplaybook.yml
