#! /bin/bash

multipass delete docker
multipass purge
multipass launch docker
multipass stop docker
multipass mount --type native "$HOME/Developer" docker
multipass start docker
multipass <~/.ssh/id_ed25519.pub exec docker -- bash -c 'cat -- >> ~/.ssh/authorized_keys'
ssh-keygen -R docker.local
