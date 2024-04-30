#!/bin/bash

# Get a list of directories
directorios=$(ls -d */)

# Check if the 'directorios' variable is not empty
if [ -n "$directorios" ]; then
    # Loop through each directory
    for directorio in $directorios; do
        echo "Eliminando directorio: ${directorio}"
        rm -r "${directorio}"
    done
else
    echo "No hay directorios para eliminar."
fi
