[![Build Status](https://cloud.drone.io/api/badges/cisco-cx/docker-mibs/status.svg)](https://cloud.drone.io/cisco-cx/docker-mibs)

# docker-mibs
Dockerize mibs from https://github.com/cisco-kusanagi/mibs.snmplabs.com

MIBS are available at /mibs/json

## Docker image

```bash
docker pull docker.io/ciscocx/mibs:${DOCKER_TAG}
```

## Development Build

Build docker image from master branch of mibs repo
```shell
docker build -t docker.io/ciscocx/mibs:${DOCKER_TAG} .
```

Build docker image from specific <MIBS_TAG> of mibs repo
```shell
docker build docker.io/ciscocx/mibs:${DOCKER_TAG} --build-args BRANCH=tags/${MIBS_TAG} .
```

## Usage

### Copy mibs to a volume

```
docker run --rm -v 'mibs:/target' docker.io/ciscocx/mibs:${DOCKER_TAG} cp -a /mibs/json/. /target/
```


### Kubernetes init

```
apiVersion: v1
kind: Pod
metadata:
  name: myapp-pod
  labels:
    app: myapp
spec:
  containers:
  - name: myapp-container
    image: busybox:1.28
    command: ['sh', '-c', 'ls /mibs && sleep 3600']
    volumeMounts:
    - name: mibs
      mountPath: /mibs
  initContainers:
  - name: init-mibs
    image: docker.io/ciscocx/mibs:${DOCKER_TAG}
    command: ['cp', '-a', '/mibs/json/.', '/target/']
    volumeMounts:
    - name: mibs
      mountPath: /target
  volumes:
  - name: mibs
    emptyDir: {}
```
