#!/bin/bash

cd "$(dirname "$0")"

mkcert mparasku.42.fr

mv mparasku.42.fr-key.pem mparasku.42.fr.key

mv mparasku.42.fr.pem mparasku.42.fr.crt