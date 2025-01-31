# Kubernetes Manifests for PostgreSQL Logical Replication

## Overview

This document provides a detailed breakdown of the Kubernetes manifests used in the pglogical replication setup. Each manifest is crucial in configuring the PostgreSQL provider and subscriber in a Kubernetes environment.

## 1. Kind Cluster Configuration

### `manifests/kind-cluster.yaml`

```yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
  extraPortMappings:
  - containerPort: 5432   # Provider port
    hostPort: 5432
  - containerPort: 5433   # Subscriber port
    hostPort: 5433
```

#### Configuration Explanation
- Creates a single-node Kubernetes cluster using Kind
- Configures port mappings for PostgreSQL provider and subscriber
- `containerPort: 5432`: Maps the provider's PostgreSQL port
- `containerPort: 5433`: Maps the subscriber's PostgreSQL port
- Enables local development and testing of replication

## 2. PostgreSQL Provider Manifests

### `manifests/provider/configmap.yaml`

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: postgres-provider-config
data:
  postgresql.conf: |
    wal_level = logical
    max_replication_slots = 10
    max_wal_senders = 10
    shared_preload_libraries = 'pglogical'
  init.sql: |
    CREATE EXTENSION pglogical;
    CREATE TABLE test (id SERIAL PRIMARY KEY, data TEXT);
```

#### Configuration Details
- Defines PostgreSQL configuration for the provider
- `wal_level = logical`: Enables logical replication
- `max_replication_slots = 10`: Maximum concurrent replication slots
- `max_wal_senders = 10`: Maximum WAL sender processes
- `shared_preload_libraries = 'pglogical'`: Preloads pglogical extension
- `init.sql`: Creates pglogical extension and a test table

### `manifests/provider/statefulset.yaml`

```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: postgres-provider
spec:
  serviceName: postgres-provider
  replicas: 1
  selector:
    matchLabels:
      app: postgres-provider
  template:
    metadata:
      labels:
        app: postgres-provider
    spec:
      containers:
      - name: postgres
        image: postgres:15
        env:
        - name: POSTGRES_PASSWORD
          value: "postgres"
        ports:
        - containerPort: 5432
        volumeMounts:
        - name: config
          mountPath: /etc/postgresql/
        - name: data
          mountPath: /var/lib/postgresql/data
      volumes:
      - name: config
        configMap:
          name: postgres-provider-config
          items:
          - key: postgresql.conf
            path: postgresql.conf
          - key: init.sql
            path: init.sql
```

#### StatefulSet Configuration
- Creates a single-replica PostgreSQL provider
- Uses PostgreSQL 15 image
- Sets default password for postgres user
- Mounts configuration and data volumes
- Attaches ConfigMap for PostgreSQL configuration

### `manifests/provider/service.yaml`

```yaml
apiVersion: v1
kind: Service
metadata:
  name: postgres-provider
spec:
  clusterIP: None
  selector:
    app: postgres-provider
  ports:
  - port: 5432
    targetPort: 5432
```

#### Service Configuration
- Headless service for PostgreSQL provider
- Enables internal DNS discovery
- Exposes PostgreSQL port 5432

## 3. PostgreSQL Subscriber Manifests

The subscriber manifests follow a similar structure to the provider, with key differences:
- Uses PostgreSQL 16 image
- Configuration name changed to `postgres-subscriber-config`
- StatefulSet and Service named accordingly

### Key Differences in Subscriber Configuration
- Image: `postgres:16`
- Metadata names updated
- Other configurations remain consistent with provider setup

## Deployment Considerations

### Security Notes
- **Warning**: The example uses a default password (`postgres`)
- For production: 
  - Use strong, unique passwords
  - Implement network policies
  - Configure TLS/encryption
  - Manage secrets securely

### Replication Setup Process
1. Deploy provider ConfigMap, StatefulSet, and Service
2. Deploy subscriber ConfigMap, StatefulSet, and Service
3. Configure pglogical replication using setup script
4. Test data synchronization


## References
- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [PostgreSQL Logical Replication](https://www.postgresql.org/docs/current/logical-replication.html)
- [pglogical Extension](https://www.2ndquadrant.com/en/resources/pglogical/)

---

