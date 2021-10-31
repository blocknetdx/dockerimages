#!/bin/sh
set -e

if [ $(echo "$1" | cut -c1) = "-" ]; then
  echo "$0: assuming arguments for pivxd"

  set -- pivxd "$@"
fi

if [ $(echo "$1" | cut -c1) = "-" ] || [ "$1" = "pivxd" ]; then
  mkdir -p "$PIVX_DATA"
  chmod 700 "$PIVX_DATA"
  chown -R pivx "$PIVX_DATA"

  echo "$0: setting data directory to $PIVX_DATA"

  set -- "$@" -datadir="$PIVX_DATA"
fi

if [ "$1" = "pivxd" ] || [ "$1" = "pivx-cli" ] || [ "$1" = "pivx-tx" ]; then
  echo
  exec su-exec pivx "$@"
fi

echo
exec "$@"
