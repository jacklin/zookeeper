#!/usr/bin/env bash
includeScriptDir() {
    if [[ -d "$1" ]]; then
        for FILE in "$1"/*.sh; do
            echo "-> Executing ${FILE}"
            # run custom scripts, only once
            . "$FILE"
        done
    fi
}
isNum() {
	if [[ -n "$(echo $1| sed -n "/^[0-9]\+$/p")" ]]; then 
	  echo 1  
	else 
	  echo 0
	fi
}