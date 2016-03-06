Terraform usage
===============

# Prerequisites

Terraform needs to be installed (terraform.io)

# Creating the platform

```bash
export AWS_ACCESS_KEY_ID="YOUR_KEY_ID"
export AWS_SECRET_ACCESS_KEY="YOUR_ACCESS_KEY"
export AWS_REGION="eu-central-1"
terraform apply
```

Terraform will output the docker URL of each machine :

```
Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

  docker_manager_url = tcp://52.29.88.249:2375
  docker_slave_1_url = tcp://52.29.61.102:2375
  docker_slave_2_url = tcp://52.29.98.114:2375
  docker_slave_3_url = tcp://52.28.205.98:2375
```

# Connecting to the platform

An SSH key is embedded in this state declaration, available at `../ssh/`.
You'll need to use this key to connect to the machines, like that :

```bash
ssh -i ssh/swarm-insecure-keypair [machine_ip]
```

# Cleaning the platform

This will also remove the insecure SSH key from your AWS account.

```
terraform destroy
```
