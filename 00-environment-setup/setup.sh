#!/bin/bash

# Terraform LocalStack Environment Setup Script
# This script sets up environment variables and starts LocalStack for local development

echo "Setting up Terraform LocalStack environment..."

# Set dummy AWS credentials for LocalStack
export AWS_ACCESS_KEY_ID="test"
export AWS_SECRET_ACCESS_KEY="test"
export AWS_DEFAULT_REGION="us-east-1"

# Export to make them available in current session
echo "AWS_ACCESS_KEY_ID=test" >> ~/.bashrc
echo "AWS_SECRET_ACCESS_KEY=test" >> ~/.bashrc
echo "AWS_DEFAULT_REGION=us-east-1" >> ~/.bashrc

# Also set globally for all users/sessions
echo "AWS_ACCESS_KEY_ID=test" | sudo tee -a /etc/environment > /dev/null
echo "AWS_SECRET_ACCESS_KEY=test" | sudo tee -a /etc/environment > /dev/null
echo "AWS_DEFAULT_REGION=us-east-1" | sudo tee -a /etc/environment > /dev/null

echo "Environment variables set:"
echo "AWS_ACCESS_KEY_ID: $AWS_ACCESS_KEY_ID"
echo "AWS_SECRET_ACCESS_KEY: [HIDDEN]"
echo "AWS_DEFAULT_REGION: $AWS_DEFAULT_REGION"

# Check if LocalStack is already running
if docker ps | grep -q localstack; then
    echo "LocalStack is already running."
else
    echo "Starting LocalStack..."
    docker run --rm -d --name localstack -p 4566:4566 localstack/localstack:3.0
    echo "LocalStack started. Waiting for services to be ready..."
    sleep 10
fi

# Verify setup
echo "Verifying setup..."
terraform --version
aws --version
docker ps | grep localstack

echo "Setup complete! You can now run Terraform commands."
echo "Example: cd 01-keypair-with-terraform && terraform init && terraform apply"