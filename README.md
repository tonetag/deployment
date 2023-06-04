# Deployment
This repository contains the code for the deployment of Tonetag. The deployment is done with Terraform, Ansible and ArgoCD.  

## Terraform
The Terraform project in [terraform/hetzner/](./terraform/hetzner/) contains the code for the deployment of the Tonetag infrastructure on Hetzner Cloud. It also creates Cloudflare DNS records for the Tonetag domain.
The Terraform state is later used as Ansible inventory.  

To deploy the infrastructure, run the following commands:
```bash
cd terraform/hetzner
terraform init
terraform apply
```

## Ansible
The Ansible project in [ansible/](./ansible/) contains the code to install K3S and deploy ArgoCD with ArgoCD Kustomize SOPS plugin.  

To deploy the infrastructure, run the following commands:
```bash
cd ansible
ansible-galaxy install -r requirements.yml
ansible-playbook -i inventory/terraform playbooks/deploy.yml
```

That should be it! Wait a few minutes for the deployment to finish and then you should then see Tonetag deployed at the domain you specified in the Terraform variables!  

## ArgoCD
The ArgoCD project in [argocd/](./argocd/) contains the code to deploy the Tonetag application. It contains a Project and Application in [argocd/projects/](./argocd/projects/).  

The Application contains a Kustomization in [argocd/tonetag/](./argocd/tonetag/) that deploys the cert-manager Helm chart, certificates for the Tonetag domain, and the Tonetag application with Helm.  

The Helm chart for the Tonetag application is in the [tonetag/charts](https://github.com/tonetag/charts) repository.  