#!/bin/sh

set -e
config_file=/opt/s3s/config.txt

if [ -f $config_file ]; then
  printf "Configuration file %s has been mounted, it will be loaded\n" $config_file
else
  if [ -n "$S3S_CONFIG" ]; then
    printf "S3S_CONFIG environment variable has been specified, it will be written to %s\n" $config_file
    echo "$S3S_CONFIG" > $config_file
  else
    printf "[!] The s3s configuration is missing, so the program will interact you to take the credential.\n"
  fi
fi

printf "\n"

exec "$@"
