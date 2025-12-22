#!/usr/bin/env bash
set -euo pipefail

# Reusable script to start LocalStack and run Terraform in the
# 01-keypair-with-terraform module. Designed to be idempotent.

BASEDIR="$(cd "$(dirname "$0")" && pwd)"
LOCALSTACK_NAME="localstack_test"
LOCALSTACK_IMAGE="localstack/localstack:latest"
LOCALSTACK_PORT=4566

echo "== Environment setup script =="

if ! command -v docker >/dev/null 2>&1; then
  echo "docker is required but not found. Install Docker and retry." >&2
  exit 1
fi

function start_localstack() {
  if [ -z "$(docker ps -q -f name=${LOCALSTACK_NAME})" ]; then
    if [ -n "$(docker ps -aq -f name=${LOCALSTACK_NAME})" ]; then
      echo "Starting existing LocalStack container ${LOCALSTACK_NAME}..."
      docker start ${LOCALSTACK_NAME} >/dev/null
    else
      echo "Pulling and starting LocalStack container ${LOCALSTACK_NAME}..."
      docker run --rm -d --name ${LOCALSTACK_NAME} -p ${LOCALSTACK_PORT}:${LOCALSTACK_PORT} ${LOCALSTACK_IMAGE} >/dev/null
    fi
  else
    echo "LocalStack ${LOCALSTACK_NAME} already running."
  fi

  echo -n "Waiting for LocalStack health..."
  until curl -sS http://localhost:${LOCALSTACK_PORT}/health >/dev/null 2>&1; do
    echo -n "."; sleep 1
  done
  echo " ready"
}

function run_terraform_module() {
  MODULE_DIR="${BASEDIR}/../01-keypair-with-terraform"
  if [ ! -d "${MODULE_DIR}" ]; then
    echo "Terraform module directory not found: ${MODULE_DIR}" >&2
    exit 1
  fi

  pushd "${MODULE_DIR}" >/dev/null
  echo "Running: terraform init"
  terraform init -input=false

  echo "Running: terraform apply -auto-approve"
  terraform apply -auto-approve -input=false
  popd >/dev/null
}

start_localstack
run_terraform_module

echo "== Done. Private key (if created) is at 01-keypair-with-terraform/devops-key.pem =="
