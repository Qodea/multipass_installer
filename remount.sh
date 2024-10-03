#! /bin/bash

multipass stop docker
multipass umount docker:"$HOME"
multipass mount --type native "$HOME/Developer" docker
multipass start docker
