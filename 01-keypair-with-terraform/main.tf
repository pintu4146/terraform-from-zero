# Generate a private key
resource "tls_private_key" "devops_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create an AWS key pair
resource "aws_key_pair" "devops_key_pair" {
  key_name   = "devops-kp"
  public_key = tls_private_key.devops_key.public_key_openssh
}

# Save the private key to a file
resource "local_file" "private_key" {
  content  = tls_private_key.devops_key.private_key_pem
  filename = "${path.module}/devops-key.pem"
  file_permission = "0600"
}