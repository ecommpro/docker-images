#!/bin/sh

if [ -z "$VARNISH_CONFIG_FILE" ] || [ ! -f $VARNISH_CONFIG_FILE ]; then
  VARNISH_CONFIG_FILE=/etc/varnish/default.vcl
fi

if [ -z "$VARNISH_SECRET_FILE" ] || [ ! -f $VARNISH_SECRET_FILE ]; then
  VARNISH_SECRET_FILE=/etc/varnish/secret
fi

echo "Using config file: $VARNISH_CONFIG_FILE"

varnishd -a :${VARNISH_PORT:-6081} \
  -T :${VARNISH_ADMIN_PORT:-6082} \
  -f $VARNISH_CONFIG_FILE \
  -S $VARNISH_SECRET_FILE \
  -s malloc,512m \
  -p feature=+esi_ignore_other_elements \
  -p cli_buffer=32768 \
  -p vcc_allow_inline_c=on \
  -F

# varnishd -a :8080 -T :6082 -f $VARNISH_CONFIG_FILE -S '' -s malloc,512m -p feature=+esi_ignore_other_elements -p cli_buffer=32768 -p vcc_allow_inline_c=on -F