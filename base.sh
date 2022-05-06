#!/usr/bin/false
# sourceme!

function search() {
    find . -type f -name tags.txt -exec grep -H "$@" {} \;
}

function hashfile() {
    printf %s-%s \
        "$(find "$1" -type f -exec bash -c 'sha256sum "$0" | head -c 64' {} \; | sha256sum | head -c 20)" \
        "$(date +%s)"
}

function add() {
    name=$(hashfile "$1")

    mkdir $name/

    newname="$name/$(basename "$1")"

    mv "$1" "$newname"
    ln -T -s "$(pwd)/$newname" "$1"

    "${EDITOR:-nano}" $name/tags.txt
}