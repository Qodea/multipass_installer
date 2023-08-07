# Multipass installer

This script will install Docker via Multipass from scratch on MacOS.

Visual Studio Code is not needed for the install, but needed to make use of it.

## Prerequisites

The script should need absolutely nothing to run from a fresh install. However
you will need git to download it in the first place, so open a terminal and
enter:

```sh
xcode-select --install
```

## Usage

```sh
./install.sh
```

Enter your password when prompted.

Now just clone a repository containing a devcontainer configuration and select
`Reopen in Container` to open it in the Docker VM.

## Troubleshooting

When initially running the installer script, make sure you cloned to somewhere
other than a protected MacOS directory (such as `Desktop`). The recommended
option is to create `$HOME/Developer` (which MacOS automatically assigns a nice
icon) and clone to there. Otherwise you may get mounting issues where Docker
complains that the current directory doesn't exist.

If the Docker VM ever gets into a state where it won't launch, then delete it
and launch it again. This means you'll need to re-add keys (and remove the old
ones from your keystore) and re-mount your home directory:

```sh
multipass delete docker
multipass purge
multipass launch docker
multipass stop docker
multipass mount --type native "$HOME" docker
multipass start docker
multipass <~/.ssh/id_ed25519.pub exec docker -- bash -c 'cat -- >> ~/.ssh/authorized_keys'
ssh-keygen -R docker.local
```

## TODO

-   Add a test suite.

## License

(C) CTS 2023

MIT License, see [LICENSE](LICENSE) for details.
