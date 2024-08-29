#!/bin/bash

#Guarda los datos de inicio de sesión para saber cuando pedirlos y poder manejar los scripts.
source ./variables.sh

#Junto con el if y el archivo "variables.sh" verifica que la conexión a mysql sea exitosa.
conexionMYSQL() {
    mysql -u "$1" -p"$2" -h "localhost" -P "3306" -D "mysql" -e "SELECT 1;" >/dev/null 2>&1
}

if [ "$verificar" != "1" ]; then

    echo "------------------------------------------------------------"
    echo "| Debe ingresar sesión antes de ingresar al menú principal |"
    echo "------------------------------------------------------------"

    while true; do
        read -p "Ingrese el nombre de usuario mysql: " us

        read -s -p "Ingrese su contraseña: " ps
        echo

        if conexionMYSQL "$us" "$ps"; then
            echo
            echo "-- Conexión exitosa --"
            echo
            echo verificar="'1'" > variables.sh
            echo us="'$us'" >> variables.sh
            echo ps="'$ps'" >> variables.sh
            break
        else
            echo
            echo "-- Usuario no encontrado o error al ingresar la contraseña --"
            echo "-- Quizás el usuario no cuenta con permisos suficientes --"
            echo
            echo "-- Inténtelo nuevamente --"
            echo
        fi
    done
fi


opcion="0"
while [ "$opcion" != 5 ]
do
    echo ""
    echo "--------------------------------"
    echo "| Bienvenido al menú principal |"
    echo "--------------------------------"
    echo "      1. Usuarios."
    echo "      2. Bases de datos."
    echo "      3. Tablas."
    echo "      4. Verificar conexión a internet."
    echo "      5. Salir."
    read -p "Seleccione uno de los menús: " opcion
    echo ""
    case $opcion in
        1) ./Menus/Usuarios.sh
        ;;
        2) ./Menus/Bases_de_datos.sh
        ;;
        3) ./Menus/Tablas.sh
        ;;
        4) ping -c 5 google.com
            if ping -c 1 google.com >/dev/null 2>&1; then
                echo ""
                echo "-- Usted tiene conexión a internet --"
            else
                echo ""
                echo "-- Usted no tiene conexión a internet --"
            fi
        ;;
        5) echo "-- Hasta luego --"
           echo ""
           echo '#!/bin/bash' > variables.sh
           #Una vez cerrada finalizada la ejecución del script, borra la información de inicio de sesión.

        exit
        ;;
        *) echo "-- Seleccione una opcion válida --"
        ;;
    esac
    
done
