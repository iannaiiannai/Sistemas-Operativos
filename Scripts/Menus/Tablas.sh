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
    echo "      2. Eliminar una tabla."
    echo "      3. Eliminar una registro de una tabla."
    echo "      4. Insertar una registro en una tabla."
    echo "      5. Modificar un registro."
    echo "      6. Ver registros de una tabla."
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
        4) insertarRegistro
        ;;
        5) modTB
        ;;
        6) verTB
        ;;
        7) exit
        ;;
        *) echo "Seleccione una opción válida: "
        ;;
    esac
    
done
