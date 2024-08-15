#!/bin/bash

source Funciones/FUsuarios.sh

    echo ""
    echo "----------------------------------"
    echo "| Bienvenido al menú de usuarios |"
    echo "----------------------------------"

opcion=$((0))
while [ $opcion -ne 6 ]
do
    echo ""
    echo "      1. Crear un usuario"
    echo "      2. Eliminar un usuario"
    echo "      3. Añadir permisos a un usuario"
    echo "      4. Revocar permisos a un usuario"
    echo "      5. Modificar un usuario"
    echo "      6. Volver"
    read -p "Seleccione uno de los menus: " opcion
    echo ""

    case $opcion in
        1) crearU
        ;;
        2) eliminarU
        ;;
        3) permisosU
        ;;
        4) elimPermisosU 
        ;;
        5) modU
        ;;
        6) exit
        ;;
        *) echo Seleccione una opción válida
        ;;
    esac
    
done
