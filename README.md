# Multipass installer

This script will install Multipass from scratch on MacOS.

Visual Studio Code is not needed for the install, but needed to make use of it.

## Usage

```sh
./install.sh
```

Enter your password when prompted.

Now just clone a repository containing a devcontainer configuration and select
`Clone in volume` (NOTE: NOT `Reopen in Container`) to open it in the Docker
VM. Note also that local changes won't be reflected outside of the VM, so you
can open repos directly in vscode instead of having to first clone locally, but
won't be able to access uncommited changes on your local disk.

## TODO

- Check for the existence of various things which it is assumed do not exist.
- Increase robustness of Multipass calls, which seem to occasionally fail.
- Make key generation non-interactive.
- Try to figure out a test suite.
- Assumes zsh.
- Make opening in a container work directly instead of having to use a volume.
  This will require figuring out how to mount things.

## License

(C) CTS 2023

MIT License, see [LICENSE](LICENSE) for details.
