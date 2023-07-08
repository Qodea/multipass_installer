#! /bin/bash
set -euxo pipefail

mkdir -p $HOME/.local/bin $HOME/.docker/cli-plugins

echo 'export PATH=$PATH:$HOME/.local/bin' >> $HOME/.profile
source $HOME/.profile

# Install Multipass.
curl -o multipass.pkg -SL https://github.com/canonical/multipass/releases/download/v1.12.1/multipass-1.12.1+mac-Darwin.pkg
sudo installer -pkg multipass.pkg -target /
rm multipass.pkg

# Install the Docker CLI and helpers.
CPU=$(uname -m)
case $CPU in
  arm64) CPU=aarch64 ;;
esac
curl -o docker.tgz -SL https://download.docker.com/mac/static/stable/$CPU/docker-20.10.10.tgz
tar xzvf docker.tgz
install docker/docker ~/.local/bin/
install docker/cli-plugins/docker-buildx ~/.local/bin/
install docker/cli-plugins/docker-app ~/.local/bin/
(
  cd ~/.docker/cli-plugins
  ln -s ~/.local/bin/docker-buildx
  ln -s ~/.local/bin/docker-app
)
rm -rf docker.tgz docker/

# Start the prepackaged Docker VM and set it as the default machine.
multipass set local.driver=qemu
multipass launch docker
multipass set client.primary-name=docker

# Copy the local user's SSH key to the VM.
ssh-keygen -t ed25519 -C $USER
cat ~/.ssh/id_ed25519.pub | multipass exec docker -- bash -c 'cat -- >> .ssh/authorized_keys'

# Add SSH configuration for the local Docker VM.
VM_IP=$(multipass ls --format csv | grep docker | cut -d ',' -f 3)
cat <<EOF >>~/.ssh/config
Host docker.local
  HostName $VM_IP
  User ubuntu
EOF

# Add a Docker context pointing to the VM and select it.
docker context create ssh --docker "host=ssh://docker.local"
docker context use ssh
