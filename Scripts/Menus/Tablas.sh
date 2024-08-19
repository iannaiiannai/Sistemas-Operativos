#!/bin/bash

#Importa el archivo "Funciones/FTablas.sh"
source Funciones/FTablas.sh

    echo ""
    echo "--------------------------------"
    echo "| Bienvenido al menú de tablas |"
    echo "--------------------------------"

opcion="0"
while [ "$opcion" != 7 ]
do
    echo ""
    echo "      1. Crear una tabla."
    echo "      2. Eliminar una tablas."
    echo "      3. Eliminar una fila de una tabla."
    echo "      4. Insertar una fila en una tabla."
    echo "      5. Modificar una tabla."
    echo "      6. Ver un listado de la tabla."
    echo "      7. Volver."
    read -p "Seleccione uno de los menus: " opcion
    echo ""

    case $opcion in
        1) crearTB
        ;;
        2) eliminarTB
        ;;
        3) eliminarRegistro
        ;;
        4) 
        ;;
        5) 
        ;;
        6) 
        ;;
        7) exit
        ;;
        *) echo "Seleccione una opción válida: "
        ;;
    esac
    
done
