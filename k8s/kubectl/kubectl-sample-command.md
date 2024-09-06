# Kubectl Sample Commands

 The Kubernetes command-line tool, kubectl, allows you to run commands against Kubernetes clusters. You can use kubectl to deploy applications, inspect and manage cluster resources, and view logs. For more information including a complete list of kubectl operations, see the kubectl reference documentation.

 #### [Overview of kubectl](https://kubernetes.io/docs/reference/kubectl/overview/)

The kubectl command line tool lets you control Kubernetes clusters. For configuration, kubectl looks for a file named config in the $HOME/.kube directory. You can specify other kubeconfig files by setting the KUBECONFIG environment variable or by setting the --kubeconfig flag.

This overview covers kubectl syntax, describes the command operations, and provides common examples. For details about each command, including all the supported flags and subcommands, see the kubectl reference documentation. For installation instructions see installing kubectl.

#### Syntax
Use the following syntax to run kubectl commands from your terminal window:
```
kubectl [command] [TYPE] [NAME] [flags]
```
#### kubectl config

```bash
kubectl config current-context
kubectl config view
kubectl config set-context dev --namespace=development \
  --cluster=lithe-cocoa-92103_kubernetes \
  --user=lithe-cocoa-92103_kubernetes
kubectl config use-context dev
kubectl config view --kubeconfig my-kube-config
kubectl config --kubeconfig=/root/my-kube-config use-context research
```
#### expose api on 8001 port
```bash
kubectl proxy
```
#### get all object

```bash
kubectl get all --all-namespaces
```
#### node commands

```bash
kubectl get node
kubectl edit node master
kubectl get nodes --show-labels
kubectl drain <node name>
kubectl uncordon <node name>
kubectl drain node01 --ignore-daemonsets
kubectl describe node master
kubectl cordon node03   # Mark node as unschedulable.

```

#### taints

```bash
kubectl taint nodes <node-name> key=value:taint-effect
kubectl taint nodes node1 app=blue:NoSchedule
```


#### logs

```bash
kubectl logs -f event-simulator-pod
kubectl logs -f <pod-name> <container-name>
kubectl logs -f even-simulator-pod event-simulator
```
#### pod

```bash
kubectl get pods -n kube-system
kubectl get pods -o wide
kubectl get pods -l app=snowflake -n=development
kubectl run nginx --image=nginx --namespace=<insert-namespace-name-here>
kubectl get pods --namespace=<insert-namespace-name-here>
kubectl get pods --selector env=dev
kubectl get all --selector env=prod,bu=finance,tier=frontend
kubectl logs my-custom-scheduler -n kube-system
```

#### service

```bash
kubectl get services
kubectl describe service
```
#### run pod without manifest

```bash
kubectl run httpd --image=httpd:alpine --port=80 --expose
kubectl run nginx-pod --image=nginx:alpine
kubectl run redis --image=redis:alpine -l tier=db
kubectl run custom-nginx --image=nginx --port=8080
kubectl run httpd --image=httpd:alpine --port=80 --expose
kubectl get pods --selector app=App1
```

#### expose

```bash
kubectl expose pod redis --port=6379 --name redis-service
```
#### secret

```bash
kubectl get secrets
kubectl describe secret
kubectl create secret generic db-secret --from-literal=DB_Host=sql01 --from-literal=DB_User=root --from-literal=DB_Password=password123
```

kubectl delete all --all -n <namespace>

kubectl explain svc --> from swagger explain it

kubectl explain svc.spec.externalIPs

Automatically create an associated service with --expose.
Test a run without actually running anything with --dry-run=client.
kubectl run myshell --image=busybox:1.36

--command -- sh -c "sleep 3600"

@deployment
Define the number of replicas using --replicas.
Provide the created manifest using --output yaml.

kubectl create deployment fancyapp --image nginx:1.25.2 -o yaml \
--dry-run=client

# wanna get manifest created from an image and get blueprint to start
kubectl create deployment fancyapp --image nginx:1.25.2 -o yaml \
--dry-run=client 

# update a deployment
kubectl set image deployment/myapp \
hello-app=gcr.io/google-samples/hello-app:2.0

kubectl rollout status deployment myapp

You can specify a
change cause for a revision by using a special annotation. The following is an example
of setting a change cause for the most recent revision:
kubectl annotate deployment/myapp \
kubernetes.io/change-cause="Added port definition."

Use kubectl patch to update a specific key—for example:
kubectl patch deployment myapp -p '{"spec": {"template":
{"spec": {"containers":
[{"name": "sise", "image": "gcr.io/google-samples/hello-app:2.0"}]}}}}'
