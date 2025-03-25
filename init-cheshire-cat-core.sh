#!/bin/bash
set -e

#crea una variabile MY_PLUGIN con il contenuto la stringa "my_plugin"
MY_PLUGIN="my_plugin"
if [ -d "/${MY_PLUGIN}" ]; then
  echo "Copiando la directory ${MY_PLUGIN} in /app/cat/plugins..."
  cp -r /${MY_PLUGIN} /app/cat/plugins/
fi

cd /app
exec python -m cat.main