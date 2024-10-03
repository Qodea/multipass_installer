#! /bin/bash

multipass stop docker
multipass set local.docker.cpus=4
multipass set local.docker.memory=8GiB
multipass start docker
