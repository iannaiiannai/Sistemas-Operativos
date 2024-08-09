#!/bin/bash

source ../Funciones/FUsuarios.sh

opcion=$((0))
while [ $opcion -ne 6 ]
do
    echo ""
    echo "1. Crear un usuario"
    echo "2. Eliminar un usuario"
    echo "3. Añadir permisos a un usuario"
    echo "4. Revocar permisos a un usuario"
    echo "5. Modificar un usuario"
    echo "6. Salir"
    read -p "Seleccione uno de los menus: " ${opcion?}
    echo ""

    case $opcion in
        1) 
        ;;
        2) 
        ;;
        3) 
        ;;
        4) 
        ;;
        5) 
        ;;
        6) echo Saliendo...
        ;;
        *) echo Seleccione una opción válida
        ;;
    esac
    
done
