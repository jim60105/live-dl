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

# Install repo for CentOS/RHEL
function func_add_repo_rhel() {
  rpm --import http://li.nux.ro/download/nux/RPM-GPG-KEY-nux.ro
  rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm
}

# Check dependencies
if command -v ffmpeg >/dev/null 2>&1 ; then
  echo "Found: $(ffmpeg -version | head -n 1)"
else
  echo "FFmpeg not found, trying to install..."
  if [ "$OSTYPE" == "linux-gnu" ]; then
    if [ -f /etc/redhat-release ]; then
      yum install epel-release -y
      func_add_repo_rhel
      yum install ffmpeg -y
    fi
    if [ -f /etc/lsb-release ]; then
      apt-get install ffmpeg -y
    fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
    brew install ffmpeg
  else
    echo "No platform/architecture supported, please install it manually."
  fi
fi

if command -v youtube-dl >/dev/null 2>&1 ; then
  echo "Found: youtube-dl $(youtube-dl --version | head -n 1)"
else
  echo "youtube-dl not found, trying to install..."
  if [ "$OSTYPE" == "linux-gnu" ]; then
    curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
    chmod a+rx /usr/local/bin/youtube-dl
    elif [[ "$OSTYPE" == "darwin"* ]]; then
    brew install ffmpeg
  else
    echo "No platform/architecture supported, please install it manually."
  fi
fi

if command -v jq >/dev/null 2>&1 ; then
  echo "Found: $(jq --version | head -n 1)"
else
  echo "jq not found, trying to install..."
  if [ "$OSTYPE" == "linux-gnu" ]; then
    if [ -f /etc/redhat-release ]; then
      yum install epel-release -y
      yum install jq -y
    fi
    if [ -f /etc/lsb-release ]; then
      apt-get install jq -y
    fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
    brew install jq
  else
    echo "No platform/architecture supported, please install it manually."
  fi
fi

if command -v yq >/dev/null 2>&1 ; then
  echo "Found: $(yq --version | head -n 1)"
else
  echo "yq not found, trying to install..."
  if [ "$OSTYPE" == "linux-gnu" ]; then
    if [ -f /etc/redhat-release ]; then
      pip install yq
    fi
    if [ -f /etc/lsb-release ]; then
      apt install python-pip
      pip install yq
    fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
    brew install python-yq
  else
    echo "No platform/architecture supported, please install it manually."
  fi
fi

if command -v exiv2 >/dev/null 2>&1 ; then
  echo "Found: $(exiv2 --version | head -n 1)"
else
  echo "exiv2 not found, trying to install..."
  if [ "$OSTYPE" == "linux-gnu" ]; then
    if [ -f /etc/redhat-release ]; then
      yum install exiv2 -y
    fi
    if [ -f /etc/lsb-release ]; then
      apt-get install exiv2 -y
    fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
    brew install exiv2
  else
    echo "No platform/architecture supported, please install it manually."
  fi
fi

if command -v aria2c >/dev/null 2>&1 ; then
  echo "Found: $(aria2c -v | head -n 1)"
else
  echo "aria2 not found, trying to install..."
  if [ "$OSTYPE" == "linux-gnu" ]; then
    if [ -f /etc/redhat-release ]; then
      yum install epel-release -y
      yum install aria2 -y
    fi
    if [ -f /etc/lsb-release ]; then
      apt-get install aria2 -y
    fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
    brew install aria2
  else
    echo "No platform/architecture supported, please install it manually."
  fi
fi

# Create alias
echo "Creating alias..."
_profile="$(func_detect_profile)"
_cwd="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
_alias="alias live-dl='$_cwd/live-dl'"
grep -qxF "$_alias" "$_profile" || echo "$_alias" >> "$_profile"