# Poweruser Tools

A set of scripts, notes, configurations, and other files I find the need to
share between multiple setups and machines.

## Overview of contents

### `configs`

Contains software configurations, themes, and similar, that do not contain any
secrets - at least not on purspose. All configurations here should not depend on
a platform.

### `linux`

Directory for all things related to (mostly headless) Linux usage.

#### `./profile.d`

Stuff to run on a profile startup, files here should be symlinked (`ln -s`) from
`/etc/profile.d`.

### `scripts`

Often run-once (or sporadically) scripts/commands. The platform they should be
run on can be guessed based on the extension.
