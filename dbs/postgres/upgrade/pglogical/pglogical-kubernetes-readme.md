# PostgreSQL Logical Replication in Kubernetes

## Project Overview

This project demonstrates a robust implementation of PostgreSQL logical replication using pglogical within a Kubernetes environment. By leveraging Kind (Kubernetes in Docker), we showcase a scalable and reproducible method for setting up cross-version PostgreSQL replication.

### Key Features
- Automated PostgreSQL replication setup
- Cross-version replication (PostgreSQL 15 to 16)
- Kubernetes-native deployment
- Fully scriptable configuration
- Local development and testing environment

## Prerequisites

Before getting started, ensure you have the following tools installed:

- [kind](https://kind.sigs.k8s.io/) - Kubernetes cluster management
- [kubectl](https://kubernetes.io/docs/tasks/tools/) - Kubernetes command-line tool
- [Docker](https://docs.docker.com/get-docker/) - Container runtime

## Architecture

The project implements a simple yet powerful replication architecture:
- **Provider Database**: PostgreSQL 15 
- **Subscriber Database**: PostgreSQL 16
- Replication configured using pglogical extension
- Deployed in a local Kubernetes cluster

## Repository Structure

```
pglogical-k8s/
├── manifests/                  # Kubernetes resource definitions
│   ├── provider/               # Provider PostgreSQL configurations
│   ├── subscriber/             # Subscriber PostgreSQL configurations
│   └── kind-cluster.yaml       # Kind cluster configuration
├── scripts/                    # Automation and setup scripts
│   ├── setup-replication.sh    # pglogical replication configuration
│   └── test-replication.sh     # Replication testing script
└── README.md                   # Project documentation
```

## Deployment Steps

### 1. Create Kubernetes Cluster

```bash
kind create cluster --config manifests/kind-cluster.yaml
```

### 2. Deploy PostgreSQL Provider

```bash
kubectl apply -f manifests/provider/
```

### 3. Deploy PostgreSQL Subscriber

```bash
kubectl apply -f manifests/subscriber/
```

### 4. Configure Replication

```bash
chmod +x scripts/setup-replication.sh
./scripts/setup-replication.sh
```

### 5. Test Replication

```bash
chmod +x scripts/test-replication.sh
./scripts/test-replication.sh
```

## Verification

Verify your deployment by checking the status of pods and services:

```bash
kubectl get pods -o wide
kubectl get services
```

## Replication Configuration Details

The replication is configured with the following key parameters:
- WAL level set to `logical`
- Maximum replication slots: 10
- Maximum WAL senders: 10
- `pglogical` shared preload library

## License

[Specify your license here, e.g., MIT, Apache 2.0]

## Acknowledgments

- [kind](https://kind.sigs.k8s.io/) Kubernetes project
- PostgreSQL Community
- pglogical Extension Developers

---
