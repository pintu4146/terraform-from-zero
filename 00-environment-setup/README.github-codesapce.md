# Run Terraform keypair example (LocalStack)

This file documents the steps performed to run the Terraform example in `01-keypair-with-terraform` and includes a small helper script for reusability.

Prerequisites
- Docker installed and running
- Terraform installed and available on PATH

Files added
- `script.sh` — starts LocalStack (if needed) and runs `terraform init` + `terraform apply` in the `01-keypair-with-terraform` module.

Quick usage
1. From the repository root run:

```bash
cd 00-environment-setup
bash script.sh
```

2. The script will ensure LocalStack is running on port 4566, wait for it to be healthy, then run the Terraform commands in `01-keypair-with-terraform`.

Outputs and cleanup
- The generated private key (if created) is saved at `01-keypair-with-terraform/devops-key.pem`.
- To stop LocalStack (if left running by the script):

```bash
docker stop localstack_test
```

Notes
- The provider in `01-keypair-with-terraform/provider.tf` points to LocalStack endpoints. If you want to target real AWS, remove the `endpoints` block and configure real credentials.
- The script is intentionally simple and idempotent; it will start an existing LocalStack container or create one if none exists.
