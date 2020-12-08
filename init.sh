#!/bin/bash

# Detect profile file if not specified as environment variable
function func_detect_profile() {
  if [ -n "$PROFILE" -a -f "$PROFILE" ]; then
    echo "$PROFILE"
    return
  fi

  # The image we used (python:alpine), the old code will actually fail.
  # So I directly do a hard code here.
  DETECTED_PROFILE="$HOME/.bashrc"
  touch "$DETECTED_PROFILE"

  echo "$DETECTED_PROFILE"
}

# Create alias
echo "Creating alias..."
_profile="$(func_detect_profile)"
_cwd="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
_alias="alias live-dl='$_cwd/live-dl'"
grep -qxF "$_alias" "$_profile" || echo "$_alias" >> "$_profile"