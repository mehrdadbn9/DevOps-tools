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

# default and indent

    # ***default Function ****
    app.kubernetes.io/name: {{ default "MYRELEASE101" .Values.releaseName | lower }}
    # Controlling Leading and Trailing White spaces 
    leading-whitespace: "   {{- .Chart.Name }}    helm-dev"
    trailing-whitespace: "   {{ .Chart.Name -}}    helm-dev"
    leadtrail-whitespace: "   {{- .Chart.Name -}}    helm-dev"   
    # indent function
    indenttest: "  {{- .Chart.Name | indent 4 -}}  "  
    # nindent function
    nindenttest: "  {{- .Chart.Name | nindent 4 -}}  "        

# Helm Development - Flow Control If-Else

- [Additional Reference: Operators are functions](https://helm.sh/docs/chart_template_guide/functions_and_pipelines/#operators-are-functions)

### IF-ELSE Syntax
```t
{{ if PIPELINE }}
  # Do something
{{ else if OTHER PIPELINE }}
  # Do something else
{{ else }}
  # Default case
{{ end }}
```
## Step: Logic and Flow Control Function: and 
- [Logic and Flow Control Functions](https://helm.sh/docs/chart_template_guide/function_list/#logic-and-flow-control-functions)

## Step-04: Implement if-else for replicas
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ .Release.Name }}-{{ .Chart.Name }}
  labels:
    app: nginx
spec:
## **
{{- if eq .Values.myapp.env "prod" }}
  replicas: 4 
{{- else if eq .Values.myapp.env "qa" }}  
  replicas: 2
{{- else }}  
  replicas: 1
{{- end }}  
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: ghcr.io/stacksimplify/kubenginx:4.0.0
        ports:
        - containerPort: 80
```
# Helm Template (when env: dev or env: null using --set)
## TEST ELSE STATEMENT
helm template myapp1 . --set myapp.env=dev

# Helm Install Dry-run 
helm install myapp1 . --dry-run

# Helm Install
helm install myapp1 . --atomic

# Verify Pods
helm status myapp1 --show-resources

# Uninstall Release
helm uninstall myapp1

# Helm Development - Flow Control If-Else with OR Function

## Step: Logic and Flow Control Function: and 
- [Logic and Flow Control Functions](https://helm.sh/docs/chart_template_guide/function_list/#logic-and-flow-control-functions)
- **or:**  Returns the boolean OR of two or more arguments (the first non-empty argument, or the last argument).
```t
# and Syntax
or .Arg1 .Arg2

```
## Step: Implement if-else for replicas with OR 

spec:
{{- if or (eq .Values.myapp.env "prod") (eq .Values.myapp.env "uat") }}
  replicas: 6
{{- else if eq .Values.myapp.env "qa" }}  
  replicas: 2
{{- else }}  
  replicas: 1  
{{- end }}


# Helm Development - Flow Control If-Else

## Step: Introduction
-  We can use `if/else` for creating conditional blocks in Helm Templates
- **eq:** For templates, the operators (eq, ne, lt, gt, and, or and so on) are all implemented as functions. 
- In pipelines, operations can be grouped with parentheses ((, and )).
- [Additional Reference: Operators are functions](https://helm.sh/docs/chart_template_guide/functions_and_pipelines/#operators-are-functions)

spec:
{{- if not (eq .Values.myapp.env "prod") }}
  replicas: 1
{{- else }}  
  replicas: 6
{{- end }}

# Helm Development - Flow Control With 


## Step: Introduction
- `with` action controls variable scoping. 
- `with` action can allow you to set the current scope (.) to a particular object.
### with action Syntax
```t
{{ with PIPELINE }}
  # restricted scope
{{ end }}
```

## Step: Review values.yaml
```yaml
# For testing Flow Control: with 
podAnnotations: 
  appName: myapp1
  appType: webserver
  appTech: HTML
```

## Step: Add $ to Root Object
- To access Root Objects inside `with` action block we need to prepend that Root object with `$`
```t
# To Access Root Object
       appManagedBy: {{ $.Release.Service }}

 # Change to Chart Directory
cd helmbasics  

# Helm Template
helm template myapp101 .

# Helm Install with dry-run
helm install myapp101 . --dry-run  

# Observation:
1. It should work as expected
      annotations:
        appName: myapp1
        appTech: HTML
        appType: webserver
        appManagedBy: Helm  
```
## Step: Scope more detailed for "with" action block
- How to retrieve a single object from `.Values.myapps.data.config` ?
- What if there is only need for 1 or 2 values from `.Values.myapps.data.config` ?
- How to access each key value from `.Values.myapps.data.config` ?
```yaml
# values.yaml
# For testing Flow Control: with - Scope more detailed
myapps:
  data: 
    config: 
      appName: myapp1
      appType: webserver
      appTech: HTML
      appDb: mysql

# Current Scope: Retrieve single object using scope
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-{{ .Chart.Name }}
data: 
{{- with .Values.myapps.data.config }}
  application-name: {{ .appName }}
  application-type: {{ .appType }}
{{- end}} 

# Observation:
1. We should be able to get values for {{ .appName }} and {{ .appType }}
```

# Helm Development - Variables

## Step: Introduction
- How to use Variables ?

## Step: Variables in Helm Templates
```yaml
# Change-1: Add Variable at the top of deployment template
{{- $chartname := .Chart.Name -}}

# Change-2: Add appHelmChart annotation with variable in deployment.yaml
  template:
    metadata:
      {{- with .Values.podAnnotations }}
      annotations:
        {{- toYaml . | nindent 8 }}
        appManagedBy: {{ $.Release.Service }}
        appHelmChart: {{ $chartname }}        
      {{- end }}  

# Change to Chart Directory
cd helmbasics  

# Helm Template
helm template myapp101 .

# Helm Install with dry-run
helm install myapp101 . --dry-run  

# Observation:
We should see variable value substituted successfully

# Helm get manifest
helm get manifest myapp101
```
# Helm Development - Flow Control Range Action with List

## Step: Introduction
- Implement `Range` with `List of Values` from `values.yaml`
- Implement on how to call `Helm Variable` in Range loop
 
## Step2: Implement "Range Action" with "List of Values"
- **Source Location:** backupfiles/namespace.yaml
- **Destication Location:** helmbasics/templates/namespace.yaml
- **File Name:** namespace.yaml
```t
# values.yaml
# Flow Control: Range with List
namespaces:
  - name: myapp1
  - name: myapp2
  - name: myapp3

# Range with List
{{- range .Values.namespaces }}
apiVersion: v1
kind: Namespace
metadata:
  name: {{ .name }}
---  
{{- end }}
```
 >>>apiVersion: v1
kind: Namespace
metadata:  
  name: myapp1
---
apiVersion: v1
kind: Namespace
metadata:  
  name: myapp2
---
apiVersion: v1
kind: Namespace
metadata:  
  name: myapp3
---

## Step: Implement "Range Action" with "List of Values" with Variables
- **Source Location:** backupfiles/namespace-with-variable.yaml
- **Destication Location:** helmbasics/templates/namespace-with-variable.yaml
- **File Name:** namespace-with-variable.yaml
```t
# values.yaml
# Flow Control: Range with List and Helm Variables
environments:
  - name: dev
  - name: qa
  - name: uat  
  - name: prod    

# Range with List
{{- range $environment := .Values.environments }}
apiVersion: v1
kind: Namespace
metadata:
  name: {{ $environment.name }}
---  
{{- end }}           

## Step: Range with Key Value pairs or Map or Dictionary 
- **Source Location:** backupfiles/namespace.yaml
- **Destication Location:** helmbasics/templates/namespace.yaml
- **File Name:** namespace.yaml

```
# values.yaml
# Range with Dictionary
myapps:
  config1: 
    appName: myapp1
    appType: webserver
    appTech: HTML
    appDb: mysql
  config2: 
    appName: myapp2
    appType: webserver
    appTech: HTML
    appDb: mysql
  
# Range with Dictionary
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-{{ .Chart.Name }}-configmap1
data: 
{{- range $key, $value := .Values.myapps.config1 }}
{{- $key | nindent 2}}: {{ $value }}
{{- end}}  

# List k8s namespaces
kubectl get configmap
kubectl get configmap <NAME-OF-CONFIGMAP> -o yaml
kubectl get configmap myapp1-helmbasics-configmap2 -o yaml
```

# Helm Development - Named Templates

## Step: Introduction
- Create Named Template
- Call the named template using template action
- Pass Root Object dot (.) to template action provided if we are using Helm builtin objects in our named template
- For `template call` use `pipelines` and see if it works
- Replace `template call` with special purpose function `include` in combination with `pipelines` and test it


## Step-02: Create a Named Template
- **File Location:** deployment.yaml
- Define the below named template in `deployment.yaml`
```t
{{/* Common Labels */}}
{{- define "helmbasics.labels"}}
    app: nginx
{{- end }}
```

## Step: Call the named template using template action
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ .Release.Name }}-{{ .Chart.Name }}-deployment 
  labels:
  {{- template "helmbasics.labels" }}
```

## Step: Add one Builtin Object Chart.Name to labels
```t
{{/* Common Labels */}}
{{- define "helmbasics.labels"}}
    app: nginx
    chartname: {{ .Chart.Name }}
{{- end }}
```

## Step: Test the output with template action
```t
# Change to Chart Directory 
cd helmbasics

# Helm Template Command
helm template myap101 .

# Helm Install with dry-run command
helm install myapp101 . --dry-run
Observation:
1. Chart name filed should be empty
2. Chart Name was not in the scope for our defined template.
3. When a named template (created with define) is rendered, it will receive the scope passed in by the template call. 
4. * No scope was passed in, so within the template we cannot access anything in "."
5. * This is easy to fix. We simply pass a scope to the template
```

## Step: Pass scope to the template call
- Add dot "." (Root Object or period) at the end of template call to pass scope to template call
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ .Release.Name }}-{{ .Chart.Name }}-deployment # Action Element
  labels:
  {{- template "helmbasics.labels" . }}
```
## Step: Pipe an Upper function to template 
```t
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ .Release.Name }}-{{ .Chart.Name }}-deployment # Action Element
  labels:
  {{- template "helmbasics.labels" . | upper }}
```

## Step: Test the output when template action + pipe + upper function
```t
# Change to Chart Directory 
cd helmbasics

# Helm Template Command
helm template myap101 .

# Helm Install with dry-run command
helm install myapp101 . --dry-run
Observation:
1. Should fail with error. What is the reason for failure ?
2. Template is an action, and not a function, there is no way to pass the output of a template call to other functions; 
```
## Step: Replace Template action with Special Purpose include function
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ .Release.Name }}-{{ .Chart.Name }}-deployment # Action Element
  labels:
  {{- include "helmbasics.labels" . | upper }}
```
# Helm Printf Function

## Step: Introduction
- **[printf](https://helm.sh/docs/chart_template_guide/function_list/#printf):** Returns a string based on a formatting string and the arguments to pass to it in order.


## Step: Create a Named Template with printf function
```t
{{/* Kubernetes Resource Name: String Concat with Hyphen */}}
{{- define "helmbasics.resourceName" }}
{{- printf "%s-%s" .Release.Name .Chart.Name }}
{{- end }}
```

## Step: Call the named template in deployment.yaml
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "helmbasics.resourceName" . }}-deployment 
  labels:
```