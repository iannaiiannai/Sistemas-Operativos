#!/bin/bash

source Funciones/FBDs.sh
    
    echo ""
    echo "----------------------------------------"
    echo "| Bienvenido al menú de bases de datos |"
    echo "----------------------------------------"

opcion=$((0))
while [ $opcion -ne 4 ]
do

    echo "      1. Crear una base de datos"
    echo "      2. Eliminar una base de datos"
    echo "      3  Ver una base de datos"
    echo "      4. Volver"
    read -p "Seleccione uno de los menus: " opcion
    echo ""

    case $opcion in
        1) 
        ;;
        2) 
        ;;
        3) 
        ;;
        4) exit
        ;;
        *) echo Seleccione una opción válida
        ;;
    esac
    
done
