#!/bin/sh
set -e

if [ $(echo "$1" | cut -c1) = "-" ]; then
  echo "$0: assuming arguments for syscoind"

  set -- syscoind "$@"
fi

if [ $(echo "$1" | cut -c1) = "-" ] || [ "$1" = "syscoind" ]; then
  mkdir -p "$SYSCOIN_DATA"
  chmod 700 "$SYSCOIN_DATA"
  chown -R syscoin "$SYSCOIN_DATA"

  echo "$0: setting data directory to $SYSCOIN_DATA"

  set -- "$@" -datadir="$SYSCOIN_DATA"
fi

if [ "$1" = "syscoind" ] || [ "$1" = "syscoin-cli" ] || [ "$1" = "syscoin-tx" ]; then
  echo
  exec su-exec syscoin "$@"
fi

echo
exec "$@"
