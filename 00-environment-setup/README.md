# Environment Setup Guide

This guide provides setup instructions for using the Terraform from Zero repository in different environments.

## Prerequisites

- Git
- Visual Studio Code with Dev Containers extension
- Container runtime: Docker or Podman

## Setup Options

### Option 1: Local Laptop Setup

#### 1. Install Prerequisites
- **Docker**: Download and install [Docker Desktop](https://www.docker.com/products/docker-desktop)
- **Podman** (Alternative to Docker):
  - Ubuntu/Debian: `sudo apt update && sudo apt install podman`
  - macOS: `brew install podman`
  - Windows: Install Podman Desktop
- **VS Code**: Install [Visual Studio Code](https://code.visualstudio.com/)
- **Dev Containers Extension**: Install "Dev Containers" extension in VS Code

#### 2. Clone and Open Repository
```bash
git clone https://github.com/pintu4146/terraform-from-zero.git
cd terraform-from-zero
code .
```

#### 3. Open in Dev Container
- In VS Code, when prompted "Reopen in Container", click "Reopen in Container"
- If not prompted, use Command Palette: `Dev Containers: Reopen in Container`
- **For Podman users**: Set VS Code setting `dev.containers.dockerPath` to `podman` (or full path)

#### 3. Run Automated Setup Script
After opening in dev container (or for local setup), run the automated setup script:
```bash
/workspaces/terraform-from-zero/00-environment-setup/setup.sh
```
This script will:
- Set AWS environment variables globally
- Start LocalStack automatically
- Verify the setup

**Note**: If you open a new terminal, the environment variables are set globally, so no need to run the script again.

#### 4. Verify Setup
The setup script automatically verifies the installation. You should see:
- Environment variables confirmed
- Terraform and AWS CLI versions
- LocalStack container running

### Option 2: GitHub Codespaces Setup

#### 1. Open in Codespace
- Go to the repository on GitHub
- Click "Code" → "Codespaces" → "Create codespace on main"
- Codespace will automatically use the dev container configuration

#### 2. Run Automated Setup Script
In the Codespace terminal:
```bash
/workspaces/terraform-from-zero/00-environment-setup/setup.sh
```
This will set environment variables and start LocalStack.

#### 3. Verify Setup
The setup script handles verification automatically.

## Troubleshooting

### Environment Variable Issues
- **"No valid credential sources found" in new terminals**: Run the setup script again or restart the terminal. The variables are set globally, but some shells may need reloading.
- **Credentials not persisting**: The setup script sets variables in `/etc/environment` for system-wide availability.

### LocalStack Issues
- **Connection refused**: Wait for LocalStack to fully start (check `docker logs localstack`)
- **Services not available**: LocalStack may take 30-60 seconds to initialize

### Common Commands
```bash
# Check container status
docker ps

# View LocalStack logs
docker logs localstack

# Stop LocalStack
docker stop localstack

# Rebuild dev container
# Command Palette: Dev Containers: Rebuild Container
```

## Next Steps
Once setup is complete, proceed to `01-keypair-with-terraform/` for your first Terraform lesson.