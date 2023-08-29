# One-liners

Collection of commands that I need from time to time and always spend hours crafting and/or looking for them.

Some of them may make no sense at all.

Sorted alphabetically.

## docker copy files from current directory to a volume

``docker run --rm -v $PWD:/source -v <VOLUME>:/dest -w /source alpine cp -r * /dest``

## OhMyPosh load theme under development

``eval "$(oh-my-posh init bash --config `pwd`/configs/.theme.omp.json)"``

## rclone put files from current directory recursively in OVH's S3 storage

``rclone sync --progress --progress-terminal-title --human-readable --contimeout 5m --ignore-existing --fast-list --size-only --s3-upload-concurrency 9 . ovh-s3:<STORAGE_NAME>/``

## rsync with ssh on custom port

``rsync -e 'ssh -p <PORT>' -ErUPth <REMOTE>:<REMOTE_DIR> <LOCAL_DIR>``