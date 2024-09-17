#! /bin/bash

multipass stop docker
multipass umount docker:"$HOME"
multipass mount --type native "$HOME/my_developer_dir" docker
# /my_developer_dir would contain all your devcontainer-supported repositories
multipass start docker
