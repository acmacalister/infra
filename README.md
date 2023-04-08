# infra
personal terraform infra for all my apps and sites. Open source to hopefully provide useful examples for others looking at their DevOps setups. 

## Arch

Uses Packer for building base images, Terraform for the IaC and Ansible for provisioning and configuration management.

Terraform configurations sit at the root with main.tf. Most every piece of cloud ifrastructure provisioned by Terraform is broken out into a module to keep things tidy and composble. 

The images directory contains all the Packer images for provisioning base images to be used by various services as needed. Those services are setup with an ansible playbook imported from the configuration-management section.
After the initial deployment of an image, the configurations are kept up to date using Ansible.

The configuration management piece is handled by ansible. It follows the best practices for repo layout in the configuration-management directory. If you haven't used Ansible before, the short story is ansible is filesystem aware,
so things are auto imported into various files based on their structure on disk.

See https://docs.ansible.com/ansible/2.8/user_guide/playbooks_best_practices.html for more details.

## Install

```bash
brew install packer
brew install terraform
brew install ansible
brew install age
brew install sops
```

## Setup

### Setup Terraform Cloud account. 

### Install ansible Galaxy modules:

```bash
cd configuration-management
ansible-galaxy install -r requirements.yml
```

### Setup age

```bash
mkdir /Users/username/Library/Application\ Support/age
age-keygen -o /Users/username/Library/Application\ Support/age/keys.txt
```
Take your public key and send it to an existing member of the team. They will add it to the .sops.yml so you can decrypt the secrets going forward

## Build Packer images

inside the images directory select an image you want to build and run:

```bash
packer init . # you only have to do this once
packer fmt . # formats the files
packer validate --var-file=variables.hcl . # ensures your config is correct
packer build --var-file=variables.hcl . # start the build and uploads the image if successful
```

## Deployments

```bash
terrafrom login # get an account from the infra team
terraform init # you only have to do this once
terraform plan
terraform apply
```

## Access

Remote access to the VM is managed through Tailscale SSH

## Testing

To test Ansible playbooks, you will need to install macpine () and multipass. macpine for testing Alpine images and multipass for testing Ubuntu images. So more info here:

https://github.com/beringresearch/macpine
https://medium.com/@paulrobu/how-to-run-ubuntu-22-04-vms-on-apple-m1-arm-based-systems-for-free-c8283fb38309
https://multipass.run/docs/mac-tutorial

(make you have [Homebrew](https://brew.sh) installed)

```bash
brew install qemu
brew install macpine
brew install multipass
```

## Services

- [] Nats Server
- [] Web Server
- [] K8 cluster
- [] BleveSearch
- [] Vault Server

## TODO:

- [] Move static sites behind Monsoon. 
- [] Deploy k8 cluster for testing Monsoon ingress controller.
- [] Spin down all hand provisioned DO service running sites currently.
- [] Fix Alpine Linux image deployment.
- [] Setup CD/CI for Terraform, Packer and Ansible.
