# Istio in Action: $3$-Day Accelerated Learning Sprint

This repository contains a $3$-day accelerated learning roadmap based on the book **"Istio in Action" (2022)**. It focuses on the most critical, high-yield chapters (Traffic, Security, Observability, and Debugging) and includes setup instructions for local Kubernetes clusters using custom Docker registry mirrors.

## 🚀 Pre-flight Checklist (Environment Setup)

Before starting the sprint based on the book's exercises, ensure your local environment is ready:

- [ ] **Provision Kubernetes:** Spin up a local cluster (Minikube, Kind, or K3s).
- [ ] **Configure Registry Mirror:** Configure your container runtime (e.g., Docker `daemon.json`) to use the mirror:
```json
  {
"registry-mirrors": ["https://hub.hamdocker.ir"]
  }
  
