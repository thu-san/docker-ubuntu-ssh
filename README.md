# docker-ubuntu-ssh

SSH server running in Ubuntu example

## Start container

From command line

```docker
docker run --name container_name -d -p 22:22 ubuntu-ssh
```

To use with docker-compose refer [docker-compose.yml](docker-compose.yml)

## Connect to container

To connect to container by ssh

```
ssh root@localhost
```
