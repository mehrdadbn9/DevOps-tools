# Docker useful commands

common vulnerabilities and exposures (CVEs)
![alt text](images/image.png)
```bash
kubectl config get-contexts
kubectl expose pod nginx --type=NodePort --port=80
 kubectl config get-contexts
 kubectl port-forward nginx 8080 80
```
![alt text](images/docker-context.png)

## command in container
```bash
docker container run centos ping -c 5 127.0.0.1
```

## IDs of all containers
```bash
docker container rm --force $(docker container ls --all --quiet)
```
## How do we get the ID of a container?
```bash
export CONTAINER_ID=$(docker container ls -a | grep trivia | awk
'{print $1}')
```
##
```bash
docker container attach nginx
docker container run --name test -it \
--log-driver none \
busybox sh -c 'for N in 1 2 3; do echo "Hello $N"; done'
```
![alt text](images/docker-logging-drivers.png)
## logs config
```bash
cd /etc/docker/daemon.json

{

    "Log-driver": "json-log",
    "log-opts": {
        "max-size": "10m",
        "max-file": 3
    }
}

```
## linux commands (kill commands)
```bash
kill -0 is used for checking process existence and permission.
kill -1 --> sudo kill -SIGHUP $(pidof dockerd)
```
## stress test
```bash
sudo apt-get install stress
stress --cpu 4 --timeout 60s
sudo apt-get install memtester
sudo memtester 1024 1
```
##
```bash
Union filesystem (unionfs) forms the backbone of what is known as container images.
```
## Copy-on-write
![alt text](images/Copy-on-write.png)
```bash
Copy-on-write is a strategy for
sharing and copying files for maximum efficiency. If a layer uses a file or folder that is available in
one of the low-lying layers, then it just uses it. If, on the other hand, a layer wants to modify, say, a file
from a low-lying layer, then it first copies this file up to the target layer and then modifies it
```
## Graph drivers (overlay2)
```bash
Graph drivers are also called storage drivers and
are used when dealing with layered container images. A graph driver consolidates multiple image
layers into a root filesystem for the mount namespace of the container. 
```
## we have contacted the Google home page, and with the -I
parameter, we have told curl to only output the response headers
```bash
curl -I https://google.com
```
## what has changed in our container concerning the base image
```bash
docker container diff sample
```
## to persist our modifications
and create a new image from them
```bash
docker container commit sample my-alpine
docker image history my-alipine
```
##
```bash

```
##
```bash

```
##
```bash

```
##
```bash

```
##
```bash

```
##
```bash

```
##
```bash

```
##
```bash

```
##
```bash

```
##
```bash

```
##
```bash

```
##
```bash

```
##
```bash

```
##
```bash

```
##
```bash

```
##
```bash

```
##
```bash

```
##
```bash

```
##
```bash

```
##
```bash

```
##
```bash

```
##
```bash

```
##
```bash

```
##
```bash

```
##
```bash

```
##
```bash

```
##
```bash

```