# One-liners

Collection of commands that I need from time to time and always spend hours crafting and/or looking for them.

Some of them may make no sense at all.

Sorted alphabetically.

## adb setup for tasker

``adb shell pm grant net.dinglisch.android.taskerm android.permission.WRITE_SECURE_SETTINGS && adb shell pm grant net.dinglisch.android.taskerm android.permission.DUMP``

## backup dir creation

``cd /srv && sudo mkdir restic && sudo chown restic:backup restic && sudo chmod 771 restic && sudo chmod g+s restic``

## bash check if command exists

``if ! command -v <the_command> &> /dev/null; then echo "<the_command> could not be found"; fi``

## docker copy files from current directory to a volume

``docker run --rm -v $PWD:/source -v <VOLUME>:/dest alpine cp -a /source -t /dest``

## OhMyPosh load theme under development

``eval "$(oh-my-posh init bash --config `pwd`/configs/.theme.omp.json)"``

## rclone put files from current directory recursively in OVH's S3 storage

``rclone sync --progress --progress-terminal-title --human-readable --contimeout 5m --ignore-existing --fast-list --size-only --s3-upload-concurrency 9 . ovh-s3:<STORAGE_NAME>/``

## rsync with ssh on custom port

``rsync -e 'ssh -p <PORT>' -ErUPth <REMOTE>:<REMOTE_DIR> <LOCAL_DIR>``

## rtl_sdr

### Quickstart

``rtl_sdr -f 868.625M -s 1600000 - 2>/dev/null | rtl_wmbus -s``
or
``rtl_sdr -f 868.95M -s 1600000 - 2>/dev/null | rtl_wmbus -p s -a``

## scrcpy connect remotely and not crash the connection

``scrcpy --max-size=1560 --max-fps=25 --no-audio --tcpip=<MOBILE_IP>:<ADB_PORT>``

## wmbusmeters

### Convert telegram to JSON message

``wmbusmeters --format=json <TELEGRAM> <NAME> <DRIVER> <METER_ID> <KEY_OR_NOKEY>``

### Listen to a meter

``wmbusmeters --verbose <SOURCE> <NAME> <DRIVER> <METER_ID> <KEY_OR_NOKEY>``

### More info in output

``wmbusmeters --logtelegrams --logtimestamps=always <SOURCE>``

### Quickstart

``wmbusmeters auto:t1,c1,s1``

## WSL attach USB device

``usbipd wsl list`` - to list available USB devices and their bus IDs
``usbipd wsl attach --busid <BUS_ID>`` - to attach

## ACL
``sudo setfacl -R -d -m u::rwX /etc/letsencrypt`` - default acl set
``sudo getfacl /etc/letsencrypt/`` - check above
``sudo tree -pugf /etc/letsencrypt/`` - verify dirtee

## yq
``yq -C filter file [file...]``
