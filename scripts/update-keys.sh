#!/bin/bash
# Update ~/.ssh/authorized_keys file using GitHub user's public keys

LOGIN=$USER
if [[ -n "${1}" ]]; then
    if [[ "${1}" == "-h" ]]; then
        echo "Update ~/.ssh/authorized_keys file using GitHub user's public keys"
        echo "Usage:"
        echo "  $0 -h"
        echo "  $0 [USER] (defaults to '$USER')"
        exit 0
    else
        LOGIN=$1
    fi
fi

while true; do

    read -r -p "Will update authorized_keys from $LOGIN's keys, proceed? [Y]es/[N]o " RESPONSE

    case $RESPONSE in
        [yY] )
            echo "Proceeding..."
            break
            ;;
        [nN] )
            echo "Exiting..."
            exit 0
            ;;
        * )
            echo "Invalid response"
            ;;
    esac

done

curl -# -L https://github.com/$LOGIN.keys -O ~/.ssh/authorized_keys
EXIT_CODE=$?

if (( EXIT_CODE == 0 )); then
    echo "Update finished"
    exit 0
else
    echo "Update failed, please check prior messages for more information"
    exit 2
fi
