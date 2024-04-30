#!/bin/bash

directorios=$(ls -d */)

for directorio in $directorios do
    echo "Eliminando directorio: ${directorio}"
    rm -r "${directorio}"
done
