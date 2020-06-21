# docker-ubuntu-ssh

SSH server running in Ubuntu example

## Start container

From command line

```docker
docker run --name container_name -d -p 22:22 thusan/ubuntu-ssh
```

To use with docker-compose refer [docker-compose.yml](docker-compose.yml)

## Connect to container

To connect to container by ssh

```sh
ssh root@localhost
```

## SSH Security

### SSH with password

Connect to docker

```
docker exec -it container_name bash
```

And change password

```
passwd root
```

### SSH with public key

Connect to docker

```docker
docker exec -it container_name bash
```

```sh
# Add new group and user (skip if you don't want to add new user and group)
groupadd sshgroup && useradd -ms /bin/bash -g sshgroup sshuser
mkdir /home/sshuser/.ssh
passwd -d sshuser
```

**And in you local machine!**, create public and private key and upload it as /home/`user`/.ssh/authorized_keys

```sh
ssh-keygen
```

And copy the `id_rsa.pub` via scp as `authorized_keys`

```sh
scp id_rsa.pub root@localhost:/home/sshuser/.ssh/authorized_keys
```

Connect to docker

```docker
docker exec -it container_name bash
```

Disable password login and root login for better security (you can skip this if you want to allow root login)

```sh
sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
sed -i 's/PermitEmptyPasswords yes/PermitEmptyPasswords no/' /etc/ssh/sshd_config
sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
```

And restart the container

```
docker restart container_name
```
