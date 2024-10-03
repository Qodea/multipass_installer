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

## FAQs

### _It's not working?_

When initially running the installer script, make sure you cloned to somewhere
other than a protected MacOS directory (such as `Desktop`). Otherwise you may
get mounting issues where Docker complains that the current directory doesn't
exist.

Likewise, if you're cloning to a protected directory (e.g. under `Documents`)
then you may find that your containers fail to mount the directory. Either move
your files to a non-protected path or enable full disk access for `multipassd`
in your MacOS System Settings under Privacy & Security -> Full Disk Access.

If you get errors about `docker-credential-osxkeychain` not existing, either
install the binary or remove the `credsStore` line from `~/.docker/config.json`
(which was probably put there by Rancher Desktop).

If the Docker VM ever gets into a state where it won't launch, then delete it
and launch it again. This means you'll need to re-add keys (and remove the old
ones from your keystore) and re-mount your home directory. A helper script is
supplied to do this for you:

```sh
./rebuild.sh
```

### _Can I customise the CPUs and memory allocated to the Virtual Machine?_

You can do this by setting the values in Multipass:

```sh
./resize.sh
```

### _Does the script need to mount my entire home directory?_

Previous versions of the installer mounted the whole of `$HOME` into the
container. This isn't strictly necessary, and you can get away with just
mounting the `Developer` directory (the recommended directory for keeping code
in MacOS - create it and it gets a nice icon and everything).

You can use the provider helper script to update your mounts like so:

```sh
./remount.sh
```

### _Can I forward X connections from Docker images to my desktop?_

You can. First install [XQuartz](https://www.xquartz.org/) and log out and in
again. Then open XQuartz (in `/Applications/Utilities`) and in Settings,
disable authentication and enable network connections. You can now use `xhost`
to allow connections to the XQuartz server from the Multipass VM and use `-e`
to set `DISPLAY` properly to connect back to the host. See the provided
`x11.sh` for an example.

## TODO

-   Update to the next official Multipass release after 1.14.0 once MacOS
    Sequoia support is fixed.
-   Add a test suite.
-   Test / ask for existing SSH keys.
-   Add parameters to helper scripts.
-   Test for the script being run from `~/Desktop`, `~/Documents` or
    `~/Downloads` and error out as these are protected.
-   Test for `docker-credential-osxkeychain` and fix.
-   Improve pre-commit config.

## License

(C) Qodea 2024

MIT License, see [LICENSE](LICENSE) for details.
