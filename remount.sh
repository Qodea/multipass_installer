#! /bin/bash

multipass stop docker
multipass umount docker:"$HOME"
multipass mount --type native "$HOME/Developer" docker
# /my_developer_dir would contain all your devcontainer-supported repositories
multipass start docker
