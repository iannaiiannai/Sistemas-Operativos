#!/bin/bash

source ../Funciones/FTablas.sh

opcion=$((0))
while [ $opcion -ne 7 ]
do
    echo ""
    echo "1. Crear una tabla"
    echo "2. Eliminar una tablas"
    echo "3. Eliminar una fila de una tabla"
    echo "4. Insertar una fila en una tabla"
    echo "5. Modificar una tabla"
    echo "6. Ver un listado de la tabla"
    echo "7. Salir"
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
        6) 
        ;;
        7) echo Saliendo...
        ;;
        *) echo Seleccione una opción válida
        ;;
    esac
    
done
