#!/bin/bash

# Prepare the EBS device and use it as docker workspace
(file -s /dev/xvdk | grep -q ext4) || mkfs.ext4 /dev/xvdk
mkdir /var/lib/docker
mount /dev/xvdk /var/lib/docker
echo "/dev/xvdk /var/lib/docker  ext4 defaults  0 0" >> /etc/fstab

# Set the hostname to be the public IP address of the instance.
# If the call to myip fails, set a default hostname.
if ! curl --silent --fail http://myip.enix.org/REMOTE_ADDR >/etc/hostname; then
    echo dockerhost >/etc/hostname
fi
service hostname start

# Fancy prompt courtesy of @soulshake.
echo 'export PS1="\[\033[0;35m\]\u@\H \[\033[0;33m\]\w\[\033[0m\]: "' >> /etc/skel/.bashrc

# Create Docker user.
useradd -d /home/docker -m -s /bin/bash docker

echo docker:training | chpasswd

echo "docker ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/docker

sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
service ssh restart

apt-get -q update
apt-get -qy install git jq python-pip

# This will install the latest Docker.
curl https://get.docker.com/ | sh

# Allow connections through a local HTTP socket.
# This is to allow API experimentation with curl.
echo 'DOCKER_OPTS="-H unix:///var/run/docker.sock -H tcp://127.0.0.1:2375"' >> /etc/default/docker
service docker restart

pip install -U docker-compose

# Wait for docker to be up.
# If we don't do this, Docker will not be responsive during the next step.
while ! docker version
do
	sleep 1
done

# Pre-pull a bunch of images.
for I in \
	debian:latest ubuntu:latest fedora:latest centos:latest \
	redis swarm

do
	docker pull $I
done
²
