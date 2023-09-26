## miscbox - configuration files


### `./etc/ssh/sshd_config.d/50-allow-remote_vars.conf`

Enables passing of `REMOTE_*` variables to an ssh host.

Copy the file to `/etc/ssh/sshd_config.d/50-allow-remote_vars.conf` and then run `sudo systemctl reload ssh`.


### `./bash_profile`

Adds support for [homebrew](https://brew.sh/) binaries and [oh-my-posh](https://ohmyposh.dev/) themes for remote Linux hosts.

Append following code to your `~/.profile` file:

```bash
export MISCBOX_PATH='<YOUR_MISCBOX_DIRECTORY>'

# include miscbox profile if it exists
if [ -f "$MISCBOX_PATH/configs/bash_profile" ]; then
    . "$MISCBOX_PATH/configs/bash_profile"
fi
```


### `./ssh_config`

SSH configuration file for the clients. Depending on the platform, this file should be copied to/linked to/included in:

#### Windows: `%userprofile%/.ssh/config`

#### Linux: `~/.ssh/config`

To copy: `cp ./ssh_config ~/.ssh/config`
To link: `ln -s ./ssh_config ~/.ssh/config`
To include: ``echo -e "\n# Add miscbox's ssh_config\nInclude $(pwd)/ssh_config" >> ~/.ssh/config``


### `theme.omp.json`

[oh-my-posh](https://ohmyposh.dev/) theme file.