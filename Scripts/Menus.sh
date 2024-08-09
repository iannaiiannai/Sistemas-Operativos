#!/bin/bash

opcion=$((0))
while [ $opcion -ne 4 ]
do
    echo ""
    echo "1. Usuarios"
    echo "2. Bases de datos"
    echo "3. Tablas"
    echo "4. Salir"
    read -p "Seleccione uno de los menus: " ${opcion?}
    echo ""

    case $opcion in
        1) ./Menus/Bases_de_datos.sh
        ;;
        2) ./Menus/Tablas.sh
        ;;
        3) ./Menus/Usuarios.sh
        ;;
        4) echo Saliendo...
        ;;
        *) echo Seleccione una opción válida
        ;;
    esac
    
done
