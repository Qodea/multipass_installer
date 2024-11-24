#! /bin/bash
set -euxo pipefail

if [ "$(uname)" != "Darwin" ]; then
  echo 'This script is for MacOS only!'
  echo "If you're on Linux you can install Docker CE directly."
  exit 1
fi

# Create directories.
mkdir -p "$HOME/.local/bin" "$HOME/.docker/cli-plugins" "$HOME/.ssh" "$HOME/Developer"

export PATH=$PATH:$HOME/.local/bin
# shellcheck disable=SC2016
echo 'export PATH=$PATH:$HOME/.local/bin' | tee -a "$HOME"/.zshrc "$HOME"/.bash_profile

# Install Multipass.
curl -o multipass.pkg -SL https://github.com/canonical/multipass/releases/download/v1.14.1/multipass-1.14.1+mac-Darwin.pkg
sudo installer -pkg multipass.pkg -target /
rm multipass.pkg

# Install the Docker CLI and helpers.
CPU=$(uname -m)
CPU_BUILDX=amd64
case $CPU in
arm64)
  CPU=aarch64
  CPU_BUILDX=arm64
  ;;
esac
curl -o docker.tgz -SL https://download.docker.com/mac/static/stable/"$CPU"/docker-24.0.5.tgz
tar xzvf docker.tgz
install docker/docker "$HOME/.local/bin/"
curl -o docker-buildx -SL https://github.com/docker/buildx/releases/download/v0.11.2/buildx-v0.11.2.darwin-"$CPU_BUILDX"
install docker-buildx "$HOME/.local/bin/"
(
  cd "$HOME/.docker/cli-plugins"
  ln -s "$HOME/.local/bin/docker-buildx" .
)
rm -rf docker.tgz docker/ docker-buildx

# Start the prepackaged Docker VM and set it as the default machine.
# multipass set local.driver=qemu
multipass launch docker
multipass stop docker
multipass mount --type native "$HOME/Developer" docker
multipass start docker
multipass set client.primary-name=docker

# Copy the local user's key to the VM (creating it first if it doesn't exist)
if [ ! -f "$HOME/.ssh/id_ed25519.pub" ]; then
  ssh-keygen -t ed25519 -C "$USER" -f id_ed25519 -N ""
  mv id_ed25519* "$HOME/.ssh/"
fi
multipass <"$HOME/.ssh/id_ed25519.pub" exec docker -- bash -c 'cat -- >> ~/.ssh/authorized_keys'

# Add SSH configuration for the local Docker VM.
cat <<EOF >>"$HOME/.ssh/config"
Host docker.local
  User ubuntu
  ProxyCommand bash -c "nc $(multipass ls --format csv | grep docker | cut -d ',' -f 3) %p"
EOF

# Add a Docker context pointing to the VM and select it.
docker context create ssh --docker "host=ssh://docker.local"
docker context use ssh
