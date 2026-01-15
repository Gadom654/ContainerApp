# Azure Containers App v1

This repository contains a simple Flask application that is deployed to Azure Container Apps using Terraform.

## Repository Structure

.
├── README.md
├── app
│   ├── Dockerfile
│   ├── app.py
│   └── requirements.txt
├── locals.tf
├── main.tf
├── modules
│   ├── app_gateway
│   │   ├── locals.tf
│   │   ├── main.tf
│   │   ├── output.tf
│   │   ├── variables.tf
│   │   └── versions.tf
│   ├── container_app
│   │   ├── locals.tf
│   │   ├── main.tf
│   │   ├── output.tf
│   │   ├── variables.tf
│   │   └── versions.tf
│   ├── container_registry
│   │   ├── locals.tf
│   │   ├── main.tf
│   │   ├── output.tf
│   │   ├── variables.tf
│   │   └── versions.tf
│   ├── monitoring
│   │   ├── locals.tf
│   │   ├── main.tf
│   │   ├── output.tf
│   │   ├── variables.tf
│   │   └── versions.tf
│   └── network
│       ├── locals.tf
│       ├── main.tf
│       ├── output.tf
│       ├── variables.tf
│       └── versions.tf
├── provider.tf
├── terraform.tfvars
└── variables.tf

## Quick Start Guide
terraform init – Initializes the backend and downloads required modules/providers.

terraform plan – Previews the infrastructure changes and validates your configuration.

terraform apply – Provisions the Azure resources and outputs your site URL.
## Changelog
Version 1.1:
    - added CI/CD pipeline
Version 1.0:
    - 1st working version of application deployed with terraform