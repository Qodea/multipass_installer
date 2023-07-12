# Multipass installer

This script will install Multipass from scratch on MacOS.

Visual Studio Code is not needed for the install, but needed to make use of it.

## Usage

```sh
./install.sh
```

Enter your password when prompted.

Now just clone a repository containing a devcontainer configuration and select
`Reopen in Container` to open it in the Docker VM.

## TODO

-   Check for the existence of various things which it is assumed do not exist.
-   Increase robustness of Multipass calls, which seem to occasionally fail.
-   Make key generation non-interactive.
-   Try to figure out a test suite.
-   Assumes zsh.
-   Check if the avahi stuff from [this
    repo](https://github.com/magnetikonline/macos-multipass-docker) helps with
    hostname persistence.

## License

(C) CTS 2023

MIT License, see [LICENSE](LICENSE) for details.
