#!/bin/bash

# Prepare the EBS device and use it as docker workspace
(file -s /dev/xvdk | grep -q ext4) || (mkfs.ext4 /dev/xvdk | tee /var/log/cloud-init-mkfs.log)

if [[ ! -d "/var/lib/docker" ]] ; then
  mkdir /var/lib/docker
fi

if ! grep -q "/var/lib/docker" /etc/fstab ; then
  echo "/dev/xvdk /var/lib/docker  ext4 defaults  0 0" >> /etc/fstab
fi

# Mount all mountpoints
mount -a

# Set the hostname to be the public IP address of the instance.
# If the call to myip fails, set a default hostname.
if ! curl --silent --fail http://myip.enix.org/REMOTE_ADDR >/etc/hostname; then
    echo dockerhost >/etc/hostname
fi

hostname $(cat /etc/hostname)

# Fancy prompt courtesy of @soulshake.
echo 'export PS1="\[\033[0;35m\]\u@\H \[\033[0;33m\]\w\[\033[0m\]: "' >> /etc/skel/.bashrc

# Create Docker user.
useradd -d /home/docker -m -s /bin/bash docker

echo docker:training | chpasswd

echo "docker ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/docker

sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
service ssh restart

apt-get -q update
apt-get -qy install git jq

# This will install the latest Docker.
curl https://get.docker.com/ | sh

# Override the systemd unit for DAEMON_OPTS changes
cat > /etc/systemd/system/docker.service <<EOF
[Unit]
Description=Docker Application Container Engine
Documentation=https://docs.docker.com
After=network.target docker.socket
Requires=docker.socket

[Service]
Type=notify
EnvironmentFile=/etc/default/docker
ExecStart=/usr/bin/docker daemon -H fd:// \$DOCKER_OPTS
MountFlags=slave
LimitNOFILE=1048576
LimitNPROC=1048576
LimitCORE=infinity

[Install]
WantedBy=multi-user.target
EOF

# Allow connections through a local HTTP socket.
# This is to allow API experimentation with curl.
echo 'DOCKER_OPTS="-H unix:///var/run/docker.sock -H tcp://0.0.0.0:2375"' >> /etc/default/docker
systemctl stop docker && systemctl daemon-reload && sleep 5 && systemctl start docker

# Wait for docker to be up.
# If we don't do this, Docker will not be responsive during the next step.
while ! docker version
do
	sleep 1
done

# Pre-pull a bunch of images.
for I in \
	redis nginx swarm

do
	docker pull $I
done
