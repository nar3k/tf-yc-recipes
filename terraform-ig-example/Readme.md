# Terraform and instance groups example

## Prerequisites
This example provides basic info and starter files to start working with instance groups

Example consists of multiple files
- terraform.tfvars_example - see Getting Started yandex_compute_image
- network.tf - has network config
- sa.tf - has service account config
- ig.tf - has instnace groups tf


cloud-init.yaml has some loging implemented to run instance group - at the begging VM with docker installed is created. Than docker image that is written to docker_image variable is started
- at the start multiple users with their keys are created (keys are derived from ~/.ssh/id_rsa.pub by default)
- at the start multiple files in VM are created
* /home/centos/docker.sh - starting scrips that installs docker ( starts once after machine creation)
* /home/centos/docker.sh - reboot script. At the start of VM stops all containers and start new one
* /etc/cron.d/docker - file that makes docker-restart.sh scripts run on every boot


## Getting started

- Copy this repo
- copy terraform.tfvars_example to terraform.tfvars file
- fill  terraform.tfvars vars with yours cloud id , folder id and token
- perform `terraform apply`

## Experiments

- try to login to VMS with multiple logins
- try change docker_image key in cloud-init.tpl.yaml file ( for example change it from 'nginx' to 'httpd') - you will see that rolling update is restarting instances one by one and changing nginx web server docker to httpd server docker


## Troubleshooting
- its possible than right after first start of the playbook instance group VMs wouldn't be able to install softsware because of DNS problems. You will that messages in serial console output. It happended because it requers some time for dns to work after network has been created. So if experices this - just make `terraform destroy -target=yandex_compute_instance_group.ig` than after deletion execute `terraform apply again`
