#!/bin/bash

directorios=$(ls -d */)

if directorio == true; do
    for directorio in $directorios; do
        echo "Eliminando directorio: ${directorio}"
        rm -r "${directorio}"
    done
else
    break
