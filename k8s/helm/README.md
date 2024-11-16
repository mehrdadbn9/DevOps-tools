## Step Configure kubeconfig for kubectl for Docker k8s Cluster

```t
# Verify if kubectl installed 
which kubectl

# Verify kubectl version
kubectl version --client --output=yaml

# List Config Contexts
kubectl config get-contexts

# Config Current Context
kubectl config current-context

# Config Use Context (Only if someother context is present in current-context output)
kubectl config use-context k8s-ctx

# List Kubernetes Nodes
kubectl get nodes
```

## Step Install
- We will use the following commands as part of this demo
- helm repo list
- helm repo add
- helm repo update
- helm search repo
- helm install
- helm list
- helm uninstall

# List Helm Repositories
helm repo list

# Add Helm Repository
helm repo add <DESIRED-NAME> <HELM-REPO-URL>
helm repo add mybitnami https://charts.bitnami.com/bitnami

# Search Helm Repository
helm search repo <KEY-WORD>
helm search repo nginx

# List Helm Releases (YAML Output)
helm list --output=yaml

# List Helm Releases (JSON Output)
helm list --output=json

## Step: Uninstall Helm Release - NO FLAGS
```t
# List Helm Releases
helm ls

# Uninstall Helm Release
helm uninstall <RELEASE-NAME>
helm uninstall mynginx 
```

# Helm Upgrade with set option

## Step: Do two more helm upgrades - For practice purpose
```t
# Helm Upgrade to 3.0.0
helm upgrade myapp1 repo/myapp1 --set "image.tag=3.0.0"

# Helm Upgrade to 4.0.0
helm upgrade myapp1 repo/myapp1 --set "image.tag=4.0.0"

## Step-08: Helm Status

- This command shows the status of a named release. 
```t
# Helm Status
helm status RELEASE_NAME
helm status myapp1

# Helm Status - Show Description (display the description message of the named release)
helm status myapp1 --show-desc    

# Helm Status - Show Resources (display the resources of the named release)
helm status myapp1  --show-resources   

# Helm Status - revision (display the status of the named release with revision)
helm status RELEASE_NAME --revision int
helm status myapp1 --revision 2
```

## Step: Helm Upgrade using Chart Version
```t
# Helm Upgrade using Chart Version
helm upgrade myapp101 stacksimplify/mychart2 --version "0.2.0"

# List Kubernetes Resources Deployed as part of this Helm Release
helm status myapp101 --show-resources

# List Release History
helm history myapp101
```

## Step: Helm Rollback
- Roll back a release to a previous revision or a specific revision
```t
# Rollback to previous version
helm rollback RELEASE-NAME 
helm rollback myapp101

# List Kubernetes Resources Deployed as part of this Helm Release
helm status myapp101 --show-resources

# List Release History
helm history myapp101
```

## Step: Helm Rollback to specific Revision
- Roll back a release to a previous revision or a specific revision
```t
# Rollback to previous version
helm rollback RELEASE-NAME REVISION
helm rollback myapp101 1

# List Kubernetes Resources Deployed as part of this Helm Release
helm status myapp101 --show-resources
AppVersion 1.0.0)

# List Release History
helm history myapp101
```
# Helm Uninstall Keep History 
# List Helm Releases
helm list
helm list --superseded
helm list --deployed

# List Release History
helm history myapp101

# Uninstall Helm Release with --keep-history Flag
helm uninstall <RELEASE-NAME> --keep-history
helm uninstall myapp101 --keep-history

# List Helm Releases which are uninstalled
helm list --uninstalled
Observation:
We should see uninstalled release

# helm status command
helm status myapp101
Observation:
1. works only when we use --keep-history flag
2. We can see all the details of release with "Status: Uninstalled"
```

## Step-03: Rollback Uninstalled Release
```t
# List Release History
helm history myapp101

# Rollback Helm Uninstalled Release
helm rollback <RELEASE> [REVISION] [flags]
helm rollback myapp101 3
Observation: It should rollback to specific revision number from revision history

# List Helm Releases
helm list
```

## Step-04: Uninstall Helm Release - NO FLAGS
```t
# List Helm Releases
helm list

# Uninstall Helm Release
helm uninstall <RELEASE-NAME>
helm uninstall myapp101

# List Helm Releases which are uninstalled
helm list --uninstalled
Observation:
We should not see uninstalled release, this command will completely remove the release and its all references

# helm status command
helm status myapp101
Observation:
As the release is permanently removed, we dont get an error "Error: release: not found"

# List Helm History
helm history myapp101
```

## Step-05: Rollback Uninstalled Release
```t
# Rollback Helm Uninstalled Release
helm rollback <RELEASE> [REVISION] [flags]
helm rollback myapp101 1 
Observation: 
Should throw error "Error: release: not found"
```

## Step-06: Best Practice for Helm Uninstall
- It is recommended to always use `--keep-history Flag` for following reasons
- Keeping Track of uninstalled releases
- Quick Rollback if that Release is required

# List Release History
helm history myapp101

# Uninstall Helm Release with --keep-history Flag
helm uninstall <RELEASE-NAME> --keep-history
helm uninstall myapp101 --keep-history

# List Helm Releases which are uninstalled
helm list --uninstalled
Observation:
We should see uninstalled release

# helm status command
helm status myapp101
Observation:
1. works only when we use --keep-history flag
2. We can see all the details of release with "Status: Uninstalled"
```

## Step-03: Rollback Uninstalled Release
```t
# List Release History
helm history myapp101

# Rollback Helm Uninstalled Release
helm rollback <RELEASE> [REVISION] [flags]
helm rollback myapp101 3
Observation: It should rollback to specific revision number from revision history

# List Helm Releases
helm list

# List Kubernetes Resources
kubectl get pods
kubectl get svc

# List Kubernetes Resources Deployed as part of this Helm Release
helm status myapp101 --show-resources

```

## Step-04: Uninstall Helm Release - NO FLAGS
```t
# List Helm Releases
helm list

# Uninstall Helm Release
helm uninstall <RELEASE-NAME>
helm uninstall myapp101

# List Helm Releases which are uninstalled
helm list --uninstalled
Observation:
We should not see uninstalled release, this command will completely remove the release and its all references

# helm status command
helm status myapp101
Observation:
As the release is permanently removed, we dont get an error "Error: release: not found"

# List Helm History
helm history myapp101
```

## Step-05: Rollback Uninstalled Release
```t
# Rollback Helm Uninstalled Release
helm rollback <RELEASE> [REVISION] [flags]
helm rollback myapp101 1 
Observation: 
Should throw error "Error: release: not found"
```

## Step-06: Best Practice for Helm Uninstall
- It is recommended to always use `--keep-history Flag` for following reasons
- Keeping Track of uninstalled releases
- Quick Rollback if that Release is required

# Helm Install with Generate Name Flag

## Step-01: Introduction
- `--generate-name` flag for `helm install` is very very important option
- This is one of the good to know option from `helm install` perspective
- When we are implementing DevOps Pipelines, if we want to generate the names of our releases without throwing duplicate release errors we can use this setting. 

## Step-02: Install helm with --generate-name flag
```t
# Install helm with --generate-name flag
helm install <repo_name_in_your_local_desktop/chart_name> --generate-name
helm install stacksimplify/mychart1 --generate-name

# List Helm Releases
helm list
helm list --output=yaml
Observation:
We can see the name as "name: mychart1-689683948" some auto-generated number

# Helm Status
helm status mychart1-689683948 
helm status mychart1-689683948 --show-resources

```
## Step-03: Uninstall Helm Release
```t
# Uninstall Helm Release
helm uninstall <RELEASE-NAME>
helm uninstall mychart1-1689683948
```

# List Kubernetes Resources Deployed as part of this Helm Release
helm status myapp101 --show-resources

# Helm Install Atomic Flag

## Step-04: Install Helm Chart - Release: qa101 with --atomic flag
- when `--atomic` flagis set, the installation process deletes the installation on failure. 
- The `--wait` flag will be set automatically if `--atomic` is used
- `--wait` will wait until all Pods, PVCs, Services, and minimum number of Pods of a Deployment, StatefulSet, or ReplicaSet are in a ready state before marking the release as successful. It will wait for as long as `--timeout`
- `--timeout`  time to wait for any individual Kubernetes operation (like Jobs for hooks) (default 5m0s)
```t
# Install Helm Chart 
helm install qa101 stacksimplify/mychart1 --atomic

# Helm with Kubernetes Namespaces

## Step-01: Introduction
- Any resource we manage using HELM are specific to Kubernetes Namespace
- By default, Kubernetes resources deployed to k8s cluster using default namespace, so we dont need to specify namespace name explicitly
- In the case if we want to deploy k8s resources to a namespace (other than default), then we need to specify that in `helm install` command with flag `--namespace` or `-n`
- In addition, we can also create a namespace during `helm install` using flags `--namespace`  `--create-namespace`

# Install Helm Release by creating Kubernetes Namespace
helm install dev101 stacksimplify/mychart2 --version "0.1.0" --namespace dev --create-namespace 

helm list --namespace dev

# Helm Override default values from values.yaml

### Step: Learn about --dry-run and --debug flags for helm install command
- Install Helm Chart by overriding NodePort 31231 with 31240

```
# Helm Install with --dry-run command
helm install myapp901 stacksimplify/mychart1 --set service.nodePort=31240 --dry-run 

# Helm Install with --dry-run and --debug command
helm install myapp901 stacksimplify/mychart1 --set service.nodePort=31240 --dry-run --debug

# helm upgrade with --dry-run and --debug commands
helm upgrade myapp901 stacksimplify/mychart1 -f myvalues.yaml --dry-run --debug
```

## Step: helm get all command
- **helm get all:** This command prints a human readable collection of information about the notes, hooks, supplied values, and generated manifest file of the given release.
- This is a good way to see what templates are installed on the kubernetes cluster server.
- **helm get notes and helm get hooks:** These two commmands we will explore when we are discussing about helm chart development. 
```t
# helm get all
helm get all RELEASE-NAME
helm get all myapp901
```

## Step-09: Values Hierarchy
1. Sub chart `values.yaml` can be overriden by parents chart `values.yaml`
2. Parent charts `values.yaml` can be overriden by user-supplied value file `(-f myvalues.yaml)`
3. User-supplied value file `(-f myvalues.yaml)` can be overriden by `--set` parameters

# Option-1: Give desired port other than 31231
helm install myapp902 stacksimplify/mychart1 --set service.nodePort=31232 

# Option-2: Pass null value to nodePort (service.nodePort=null)
helm install myapp902 stacksimplify/mychart1 --set service.nodePort=null --dry-run --debug
helm install myapp902 stacksimplify/mychart1 --set service.nodePort=null 

