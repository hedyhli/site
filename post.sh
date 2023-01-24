#!/usr/bin/env bash

BLUE=$(tput setaf 12)
RED=$(tput setaf 9)
GREEN=$(tput setaf 10)
RESET=$(tput sgr0)

blue() {
    echo ${BLUE}"$@"${RESET}
}

yesno () {
    prompt="$1"
    if [[ "$2" == n ]]; then
        prompt="$prompt"' [y/N] '
    else
        if [[ "$2" == y ]]; then
            prompt="$prompt"' [Y/n] '
        else
            prompt="$prompt"' [y/n] '
        fi
    fi
    read -p "$prompt"

    REPLY=$(echo "$REPLY" | tr A-Z a-z)
    if [[ -z "$REPLY" ]]; then
        REPLY="$2" # default
    fi

    if [[ "$REPLY" =~ ^y$ ]]; then
        echo y; return 0
    else
        if [[ "$REPLY" =~ ^n$ ]]; then
            echo n; return 1
        fi
        echo ${RED}Invalid option!${RESET} > /dev/stderr
        yesno "$@"
    fi
}

read -p "$(blue filename:\ )" filename
filename=posts/$(date "+%Y-%m-%d")-"$filename".md
hugo new "$filename"

if ! yesno "$(blue 'draft?')" y; then
    sed -i 's/draft: true/draft: false/' "$filename"
fi

if yesno "$(blue edit?)" y; then
    "${EDITOR:-vim}" "$filename"
fi
