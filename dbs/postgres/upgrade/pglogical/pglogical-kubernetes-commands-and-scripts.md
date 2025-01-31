# PostgreSQL Logical Replication in Kubernetes: Commands and Scripts Guide

## Project Setup and Execution Workflow

### Prerequisite Checklist
Before beginning, ensure you have installed:
- Docker
- kind (Kubernetes in Docker)
- kubectl
- Basic understanding of Kubernetes and PostgreSQL concepts

## Command Execution Order

### 1. Create Kind Kubernetes Cluster

```bash
# Create Kubernetes cluster using custom configuration
kind create cluster --config manifests/kind-cluster.yaml
```

**What This Command Does:**
- Spins up a local Kubernetes cluster
- Uses the custom configuration in `kind-cluster.yaml`
- Sets up port mappings for PostgreSQL provider and subscriber
- Prepares the environment for database deployment

### 2. Deploy PostgreSQL Provider

```bash
# Apply provider-specific Kubernetes manifests
kubectl apply -f manifests/provider/
```

**Deployment Components:**
- ConfigMap: PostgreSQL configuration
- StatefulSet: PostgreSQL 15 database deployment
- Service: Network configuration for database access

### 3. Deploy PostgreSQL Subscriber

```bash
# Apply subscriber-specific Kubernetes manifests
kubectl apply -f manifests/subscriber/
```

**Deployment Components:**
- ConfigMap: PostgreSQL configuration
- StatefulSet: PostgreSQL 16 database deployment
- Service: Network configuration for subscriber database

### 4. Configure pglogical Replication

```bash
# Make setup script executable
chmod +x scripts/setup-replication.sh

# Execute replication configuration script
./scripts/setup-replication.sh
```

## Scripts Deep Dive

### `scripts/setup-replication.sh`

```bash
#!/bin/bash

# Provider Node Configuration
kubectl exec postgres-provider-0 -- psql -U postgres -c \
"SELECT pglogical.create_node(
  node_name := 'provider',
  dsn := 'host=postgres-provider port=5432 dbname=postgres user=postgres password=postgres'
);"

# Create Replication Set
kubectl exec postgres-provider-0 -- psql -U postgres -c \
"SELECT pglogical.create_replication_set('test_set');
 SELECT pglogical.replication_set_add_table('test_set', 'test');"

# Subscriber Node Configuration
kubectl exec postgres-subscriber-0 -- psql -U postgres -c \
"SELECT pglogical.create_node(
  node_name := 'subscriber',
  dsn := 'host=postgres-subscriber port=5432 dbname=postgres user=postgres password=postgres'
);"

# Create Subscription
kubectl exec postgres-subscriber-0 -- psql -U postgres -c \
"SELECT pglogical.create_subscription(
  subscription_name := 'test_sub',
  provider_dsn := 'host=postgres-provider port=5432 dbname=postgres user=postgres password=postgres',
  replication_sets := ARRAY['test_set'],
  synchronize_data := true
);"
```

**Script Breakdown:**
1. Creates a provider node in pglogical
2. Establishes a replication set
3. Adds a test table to the replication set
4. Creates a subscriber node
5. Sets up a subscription from provider to subscriber

### `scripts/test-replication.sh`

```bash
#!/bin/bash

# Insert Test Data into Provider
kubectl exec postgres-provider-0 -- psql -U postgres -c \
"INSERT INTO test (data) VALUES ('Hello Kubernetes!');"

# Verify Data Replication on Subscriber
kubectl exec postgres-subscriber-0 -- psql -U postgres -c \
"SELECT * FROM test;"
```

**Test Script Purpose:**
- Inserts a test record in the provider database
- Queries the subscriber to confirm data replication

### 5. Test Replication

```bash
# Make test script executable
chmod +x scripts/test-replication.sh

# Run replication test
./scripts/test-replication.sh
```

### 6. Verify Kubernetes Resources

```bash
# List all pods with detailed information
kubectl get pods -o wide

# List services
kubectl get svc
```

## Verification and Monitoring Commands

### Check Replication Status

```bash
# On Provider
kubectl exec postgres-provider-0 -- psql -U postgres -c \
"SELECT * FROM pglogical.show_subscription;"

# On Subscriber
kubectl exec postgres-subscriber-0 -- psql -U postgres -c \
"SELECT * FROM pglogical.show_subscription;"
```

## Common Troubleshooting Commands

```bash
# View pod logs
kubectl logs postgres-provider-0
kubectl logs postgres-subscriber-0

# Describe pods for detailed status
kubectl describe pod postgres-provider-0
kubectl describe pod postgres-subscriber-0
```