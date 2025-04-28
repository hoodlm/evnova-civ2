#!/bin/bash

set -eu -o pipefail

fail() {
  msg=$1
  echo "error: $msg" > /dev/stderr
  exit 1
}

info() {
  msg=$1
  echo "info: $msg" > /dev/stderr
}

check_dependency() {
  dep=$1
  command -v "$dep" || fail "dependency $dep is not installed or not on PATH"
}

check_dependency "7z"

BASEDIR=$(dirname $0)
BUILDDIR="$BASEDIR/build"

mkdir --parents --verbose "$BUILDDIR"

FILES="
    CITY.TXT
    EVENTS.TXT
    NOVA.scn
    NOVA.txt
    RULES.TXT
    TERRAIN1.GIF
    TERRAIN2.GIF
    UNITS.GIF
    ICONS.GIF
"
for FILE in $FILES; do
  install --preserve-timestamps --target-directory="$BUILDDIR" --verbose "$FILE"
done

7z a "EVN.7z" "$BUILDDIR/*"
