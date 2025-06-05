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

mkdir --parents --verbose "$BUILDDIR/EVN"

FILES="
    CITY.TXT
    EVENTS.TXT
    PEDIA.TXT
    NOVA.scn
    NOVA.txt
    RULES.TXT
    TERRAIN1.GIF
    TERRAIN2.GIF
    UNITS.GIF
    ICONS.GIF
    CITIES.GIF
    NOVA_SMALL.MP
    _README.TXT
    post-setup.template.sav
    pre-setup.template.sav
"
for FILE in $FILES; do
  install --preserve-timestamps --target-directory="$BUILDDIR/EVN" --verbose "$FILE"
done

pushd $BUILDDIR
7z a "EVN.7z" "EVN/*"
popd
