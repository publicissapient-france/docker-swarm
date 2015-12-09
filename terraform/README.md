Utilisation de terraform
========================

# Prérequis

Terraform doit être installé (terraform.io)

# Création de l'infra

```bash
export AWS_ACCESS_KEY_ID="YOUR_KEY_ID"
export AWS_SECRET_ACCESS_KEY="YOUR_ACCESS_KEY"
export AWS_REGION="eu-central-1"
terraform apply -var aws_keypair=nom_de_la_clé_ssh_amazon
```

En sortie, terraform affiche les URL docker de chaque machine :

```
Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

  docker_manager_url = tcp://52.29.88.249:2375
  docker_slave_1_url = tcp://52.29.61.102:2375
  docker_slave_2_url = tcp://52.29.98.114:2375
  docker_slave_3_url = tcp://52.28.205.98:2375
```

# Destruction de l'infra
```
terraform destroy -var aws_keypair=nom_de_la_clé_ssh_amazon
```
