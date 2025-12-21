# Terraform – Creating an RSA Key Pair

## 🎯 Goal
Create an RSA key pair using Terraform and understand:
- Public vs private keys
- How Terraform manages dependencies
- What gets stored in terraform.tfstate

---

## 🧠 Mental Model

Terraform:
- Generates the private key
- Sends only the public key to AWS
- Stores state locally for tracking

---

## 📂 Files

- `main.tf` → resource definitions

---

## ⚠️ Common Mistakes

- Using hyphens instead of underscores in resource names
- Saving public key instead of private key in `.pem`
- Forgetting that Terraform loads all `.tf` files automatically

---

## ✅ Outcome

- AWS key pair created
- Private key stored securely
- State file updated correctly

---

## 🔑 Key Takeaway

> Terraform is declarative. You define the desired state — Terraform figures out the order.

