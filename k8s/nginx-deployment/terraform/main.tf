# Project Structure Analysis
========================

## Directory Structure
```
|--env
|--helm-values
|  |--dev.yaml
|  |--ingress-controller-values.yaml
|--main.tf
|--providers.tf
|--variables.tf
|--versions.tf
```

## Contents of directory: terraform/

### File: dev.yaml

```yaml
values = [
  file("${path.module}/env/${var.environment}.yaml")
]

# fullnameOverride: "nginx-helm"
# nameOverride: "nginx"
# service:
#   port: 80
#   type: ClusterIP

# replicaCount: 2```

### File: ingress-controller-values.yaml

```yaml
controller:
  service:
    type: LoadBalancer
  ingressClassResource:
    name: nginx
    default: true
```

### File: main.tf

```hcl
# Add Nginx Ingress Controller
resource "helm_release" "nginx_ingress_controller" {
  name       = "nginx-ingress"
  namespace  = var.namespace
  chart      = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  version    = "4.8.1"

  values = [
    file("${path.module}/helm-values/ingress-controller-values.yaml")
  ]

  depends_on = [
    kubernetes_namespace.nginx_namespace
  ]
}

# Existing Helm release for Nginx application
resource "helm_release" "nginx_helm" {
  name       = "nginx-helm"
  namespace  = var.namespace
  chart      = "${path.module}/../nginx-helm"
  version    = "0.1.0"

  values = [
    file("${path.module}/helm-values/dev.yaml")
  ]

  depends_on = [
    kubernetes_namespace.nginx_namespace
  ]
}

resource "kubernetes_namespace" "nginx_namespace" {
  metadata {
    name = var.namespace
  }
}
```

### File: providers.tf

```hcl
provider "kubernetes" {
  config_path    = var.kube_config
  config_context = var.kube_context
}

provider "helm" {
  kubernetes {
    config_path    = var.kube_config
    config_context = var.kube_context
  }
}

# Add kube_context variable
variable "kube_context" {
  type        = string
  default     = ""
  description = "Kubernetes context to use"
}
```

### File: variables.tf

```hcl
variable "kube_config" {
  type        = string
  default     = "~/.kube/config"
  description = "Path to the kubeconfig file"
}

variable "namespace" {
  type        = string
  default     = "default"
  description = "Kubernetes namespace for the deployment"
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "Environment name (dev/prod)"
  validation {
    condition     = contains(["dev", "prod"], var.environment)
    error_message = "Environment must be either 'dev' or 'prod'."
  }
}
```

### File: versions.tf

```hcl
terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.0.0"
    }
  }
  required_version = ">= 1.0.0"
}```

## Contents of directory: values/

### File: ingress-values.yaml

```yaml
controller:
  name: nginx-ingress
  hostPort:
    enabled: true
    ports:
      http: 80
      https: 443
  service:
    type: NodePort
  watchIngressWithoutClass: true
  nodeSelector:
    kubernetes.io/os: linux
  image:
    registry: registry.k8s.io
    image: ingress-nginx/controller
    tag: "v1.11.3"
    digest: null
  imagePullPolicy: IfNotPresent
  admissionWebhooks:
    enabled: false
  config:
    proxy-body-size: "0"
    use-forwarded-headers: "true"
    compute-full-forwarded-for: "true"
    use-proxy-protocol: "false"```

### File: values.yaml

```yaml
replicaCount: 1

image:
  repository: nginx
  tag: "1.24.0"

nameOverride: ""
fullnameOverride: "nginx-app"

service:
  type: ClusterIP
  port: 80

ingress:
  host: nginx.local
  className: nginx-ingress

configmap:
  enabled: true
  nginxConfig: |
    user  nginx;
    worker_processes  auto;

    error_log  /var/log/nginx/error.log notice;
    pid        /var/run/nginx.pid;

    events {
      worker_connections  1024;
    }

    http {
      include       /etc/nginx/mime.types;
      default_type  application/octet-stream;

      log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                       '$status $body_bytes_sent "$http_referer" '
                       '"$http_user_agent" "$http_x_forwarded_for"';

      access_log  /var/log/nginx/access.log  main;

      sendfile        on;
      keepalive_timeout  65;

      server {
        listen 80;
        server_name nginx.local;

        location = /salam {
          add_header Content-Type application/json;
          return 200 '{"message": "Salam!"}';
        }

        location = /khodafez {
          add_header Content-Type application/json;
          return 200 '{"message": "Khodafez!"}';
        }

        location / {
          add_header Content-Type application/json;
          return 404 '{"error": "Not Found"}';
        }
      }
    }
```

## Contents of directory: nginx-helm/

### File: Chart.lock

```
dependencies:
- name: ingress-nginx
  repository: https://kubernetes.github.io/ingress-nginx
  version: 4.7.1
digest: sha256:d0cc6cee555b64ed3e98a21205174228337dcc6bb8a181e669ea7a07179f0d85
generated: "2024-11-24T12:43:01.075779134+03:30"
```

### File: Chart.yaml

```yaml
apiVersion: v2
name: nginx-helm
description: A Helm chart for Nginx deployment
type: application
version: 0.1.0
appVersion: "1.24.0"```

### File: configmap.yaml

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "nginx.fullname" . }}-config
data:
  nginx.conf: |
    {{ .Values.configmap.nginxConfig | nindent 4 }}
```

### File: deployment.yaml

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "nginx.fullname" . }}
  labels:
    {{- include "nginx.labels" . | nindent 4 }}
spec:
  replicas: {{ .Values.replicaCount }}
  selector:
    matchLabels:
      {{- include "nginx.selectorLabels" . | nindent 6 }}
  template:
    metadata:
      labels:
        {{- include "nginx.selectorLabels" . | nindent 8 }}
      {{- if .Values.podAnnotations }}
      annotations:
        {{- toYaml .Values.podAnnotations | nindent 8 }}
      {{- end }}
    spec:
      containers:
        - name: {{ .Chart.Name }}
          image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
          ports:
            - containerPort: 80
          {{- if or (and .Values.salam (default false .Values.salam.enabled)) (and .Values.khodafez (default false .Values.khodafez.enabled)) }}
            env:
              {{- if and .Values.salam (default false .Values.salam.enabled) }}
              - name: SALAM_MESSAGES
                value: {{ .Values.salam.messages | toJson | quote }}
              {{- end }}
              {{- if and .Values.khodafez (default false .Values.khodafez.enabled) }}
              - name: KHODAFEZ_VARIANTS
                value: {{ .Values.khodafez.variants | toJson | quote }}
              {{- end }}
          {{- end }}
          volumeMounts:
          - name: nginx-config
            mountPath: /etc/nginx/nginx.conf
            subPath: nginx.conf
      volumes:
      - name: nginx-config
        configMap:
          name: {{ include "nginx.fullname" . }}-config
```

### File: _helpers.tpl

```gotpl
{/*
Expand the name of the chart.
*/}}
{{- define "nginx.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "nginx.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "nginx.labels" -}}
app: {{ include "nginx.name" . }}
helm.sh/chart: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "nginx.selectorLabels" -}}
app: {{ include "nginx.name" . }}
{{- end }}
```

### File: ingress.yaml

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: {{ include "nginx.fullname" . }}
  labels:
    {{- include "nginx.labels" . | nindent 4 }}
  annotations:
    nginx.ingress.kubernetes.io/ssl-redirect: "false"
    nginx.ingress.kubernetes.io/enable-cors: "true"
    nginx.ingress.kubernetes.io/cors-allow-origin: "*"
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  ingressClassName: nginx
  rules:
  - host: nginx.local
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: {{ include "nginx.fullname" . }}
            port:
              number: {{ .Values.service.port }}```

### File: NOTES.txt

```
```

### File: service.yaml

```yaml
apiVersion: v1
kind: Service
metadata:
  name: {{ include "nginx.fullname" . }}
  labels:
    {{- include "nginx.labels" . | nindent 4 }}
spec:
  type: {{ .Values.service.type }}
  ports:
    - port: {{ .Values.service.port }}
      targetPort: 80
      protocol: TCP
      name: http
  selector:
    {{- include "nginx.selectorLabels" . | nindent 4 }}
```

### File: test-connection.yaml

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: "{{ include "nginx.fullname" . }}-test-connection"
  labels:
    {{- include "nginx.labels" . | nindent 4 }}
  annotations:
    "helm.sh/hook": test
    "helm.sh/hook-delete-policy": hook-succeeded
spec:
  containers:
    - name: wget
      image: busybox
      command: ['wget']
      args:
        - '--spider'
        - '--timeout=10'
        - 'http://{{ include "nginx.fullname" . }}.{{ .Release.Namespace }}.svc:{{ .Values.service.port }}'
  restartPolicy: Never```

