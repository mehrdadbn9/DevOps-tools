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
RUN tar -xJC /usr/src/python --strip-components=1 -f python.tar.xz
```
##
```bash
RUN apt-get update \
&& apt-get install -y --no-install-recommends \
ca-certificates \
libexpat1 \
libffi6 \
libgdbm3 \
libreadline7 \
libsqlite3-0 \
libssl1.1 \
&& rm -rf /var/lib/apt/lists/*
```
## ADD
### ADD keyword also lets us copy and
unpack TAR files, as well as provide an URI as a source for the files and folders to copy

inside the
image will have a user ID (UID) and a group ID (GID) of 0.
```bash

ADD sample.tar /app/bin/
ADD http://example.com/sample.txt /data/
ADD --chown=11:22 ./data/web* /app/data/
```
## name space
![namespace](image.png)
```bash
sudo ls /proc/1/ns 
cgroup	mnt  pid	       time		  user
ipc	net  pid_for_children  time_for_children  uts(hostname and NIS domain name)

```
###  ENTRYPOINT is used to define the command of the expression
### CMD is used to define the parameters for the command

```bash
ENTRYPOINT [ "ping" ]
CMD [ "-c", "3", "8.8.8.8" ]

ENTRYPOINT ["npm"]
CMD ["start"]
```
## 8 namespaces
![namespace](image-1.png)
![API sys call](image-2.png)
![clone at docker run](image-3.png)
```bash

```
## Saving and loading images
```bash
docker image save -o ./backup/my-alpine.tar my-alpine
docker image load -i ./backup/my-alpine.tar
```
 Enterprise Service Bus (ESB)
## lsns
```bash
lsns
pstree
nspawn --->s part of the systemd system and service manager suite. It is used for managing lightweight containers on Linux systems
```
##
```bash
RUN mvn --clean install
```
##
```bash
ENV baz=123
EXPOSE 5000
EXPOSE 15672/tcp
ENTRYPOINT java -jar pet-shop.war
```
## return on investment (ROI) 
```bash
• More than a 50% saving in maintenance costs
• Up to a 90% reduction in the time between the deployments of new releases
```
## docker tag
```bash
docker image tag alpine:latest gnschenker/alpine:1.0
```
##
```bash
$ docker container run -it --privileged --pid=host \
debian nsenter -t 1 -m -u -n -i sh
nsenter -t 1 -m -u -n -i sh

```
## development.config
```bash
LOG_DIR=/var/log/my-log
MAX_LOG_FILES=5
MAX_LOG_SIZE=1G
```
##
```bash
docker container run --rm -it \
--env-file ./development.config \
alpine sh -c "export | grep LOG"
```
## Environment variables at build time
```bash
ARG BASE_IMAGE_VERSION=12.7-stretch
FROM node:${BASE_IMAGE_VERSION}
```
## Auto-restarting for Node.js
```bash
 npm install -g nodemon
```
## java

### To add auto-restart support to our Java Spring Boot application, we need to add the so-called dev tools:
### I. Locate the pom.xml file in your Java project and open it in the editor.
### II. Add the following snippet to the dependencies section of the file:

### When using Python, we can also use nodemon to have our application auto-restart when any
changes are made to the code. For example, assume that your command to start the Python
application is python main.py. In this case, you would just use nodemon like so:
```bash
$ nodemon --exec python3 main.py
```
## Auto-restarting for .NET
```bash
$ dotnet new webapi -o csharp-sample
$ dotnet watch run
Dockerfile-dev
![.net dockerfile-dev](image-4.png)
The dockerServerReadyAction property in the launch.json file of a .NET project
in VS Code is used to specify an action that should be taken when a Docker container is ready
to accept requests.
![log level](image-5.png)
```
## python
```bash
![python logger](image-6.png)

```
## jaeger tracing
```bash
1. generate log item (logger obj)
2. wrap each method to trace with what Jaeger calls a span
![span for .net](image-8.png)
![child span](image-9.png)
3. 

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