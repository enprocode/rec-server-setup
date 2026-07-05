#!/bin/bash

# Function to handle script termination
function trap_exit() {
  echo "Stopping... $(jobs -p)"
  kill $(jobs -p) > /dev/null 2>&1 || echo "Already killed."
  if [ -e "/etc/init.d/pcscd" ]; then
    /etc/init.d/pcscd stop
  fi
  sleep 1
  echo "Exit."
}

# Trap setup for signals
trap "exit 0" 2 3 15
trap trap_exit 0

# Start and monitor pcscd service if it exists
if [ -e "/etc/init.d/pcscd" ]; then
  while true; do
    echo "Starting pcscd..."
    /etc/init.d/pcscd start
    sleep 1
    if timeout 2 pcsc_scan | grep -A 50 "Using reader plug'n play mechanism"; then
      echo "pcscd started successfully."
      break
    else
      echo "Failed to start pcscd, retrying..."
    fi
    sleep 5
  done
fi

# shellcheck disable=SC1035
if !(type "recpt1" > /dev/null 2>&1); then
  apt-get update
  apt-get install -y --no-install-recommends git autoconf automake

  cd /tmp
  git clone https://github.com/stz2012/recpt1.git
  cd recpt1/recpt1
  ./autogen.sh
  ./configure --prefix /opt
  make
  make install
fi

recpt1 -v

# mirack Start
echo "mirack Start!"
/usr/local/bin/mirakc --config /etc/mirakc/config.yml
