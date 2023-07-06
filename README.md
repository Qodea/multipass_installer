# Multipass installer

This script will install Multipass from scratch on MacOS.

## Prerequisites

- An SSH key in ed25519 format, added to your keyring.
- `$HOME/.local/bin` should be in `$PATH` (note: ensure you use `$HOME` and not
  `~` as `which` and other tooling won't expand the tilde).
- Visual Studio Code (not needed for the install, but needed to make use of
  it).

## Usage

```sh
./install.sh
```

Enter your password when prompted.

Now just clone a repository locally containing a devcontainer configuration and
select `Clone in volume` (NOTE: NOT `Reopen in Container`) to open it in the
Docker VM.

## License

(C) CTS 2023

MIT License, see [LICENSE](LICENSE) for details.
