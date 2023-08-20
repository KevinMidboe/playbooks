# Maintenance
Upgrade:
cd /opt/immich
docker-compose pull && docker-compose up -d

# Install docker:
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done

sudo apt-get update
sudo apt-get install ca-certificates curl gnupg

sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Run docker as user:
Add current user to docker group to not require sudo

```bash
sudo groupadd docker
sudo usermod -aG docker $USER

newgrp docker
```

# Create user for NFS:
Add immich group with same gid on the nfs host to ensure correct file permissions

```bash
sudo groupadd immich -g 27000
```

# Add mainframe mounted Immich Library folder
export NFS_MOUNT="mainframe.schleppe:/mnt/mainframe/app/immich"
export MOUNT_POINT=/mnt/mainframe-immich
echo "$NFS_MOUNT $MOUNT_POINT nfs defaults 0 0" | sudo tee -a /etc/fstab
