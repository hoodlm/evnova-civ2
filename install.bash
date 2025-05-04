#!/bin/bash

set -eu -o pipefail

CIV2_PATH="$HOME/.wine/drive_c/Program Files (x86)/MicroProse Software/Civilization II Multiplayer Gold Edition"

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

test -d "$CIV2_PATH" || fail "CIV2_PATH is not a valid directory: $CIV2_PATH"
test -d "$CIV2_PATH/SCENARIO" || fail "Could not find SCENARIO subdirectory at $CIV2_PATH"

OUTDIR="$CIV2_PATH/SCENARIO"
mkdir --parents --verbose "$OUTDIR"

7z x -o"$OUTDIR" "EVN.7z"

set -x
ls -l "$OUTDIR"
set +x

info "Successfully installed EVN at $OUTDIR"
