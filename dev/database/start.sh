#!/usr/bin/env bash

set -e

if [ ! -d database ]; then
  mkdir database
  sudo chown -R 1000:1000 database
fi

if [ ! -d pgadmin4 ]; then
  mkdir pgadmin4
  sudo chown -R 5050:5050 pgadmin4
fi

docker compose up
