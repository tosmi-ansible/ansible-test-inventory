#!/bin/bash

[ -z "$STAGE_ENV" ] && exit 1

WAVE=${WAVE:-ALL}
WAVE1_HOSTS=3

inventory=$(cat inventory.txt)
# curl...

case "$WAVE" in
    ANSIBLETEST)
	inventory=$(echo "$inventory" | grep wally)
	echo $inventory
	;;
    WAVE1)
	inventory=$(echo "$inventory" | head -"$WAVE1_HOSTS")
	;;
esac

inventory=$(sed 's/^/"/g;s/$/"/g' <<< $inventory)
inventory=$(sed ':a;N;$!ba;s/\n/,/g' <<< $inventory)

cat << EOF
{
    "ANSIBLE_TEST": {
        "hosts": [$inventory],
        "vars": {
            "var1": true
        },
        "children": []
    }
}
EOF
