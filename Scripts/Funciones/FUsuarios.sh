#!/bin/bash


source ./../variables.sh

#Verifica que las operaciones sean exitosas, los "$números" cumplen la función de un parámetro.
check(){
    if [ "$1" -eq 0 ]; then
            echo "$2"
    else
            echo "$3"
    fi
}

#Controla si el usuario está repetido o si el nombre no cumple con los requisitos mínimos.
repetido(){
    var=${#usuario}
    esta="$(mysql -u "$us" -p"$ps" -sse"SELECT EXISTS(SELECT 1 FROM mysql.user WHERE user = '$usuario')" 2>/dev/null)"
    while [ "$esta" -eq 1 ] || [ "$var" -lt 1 ]
    do
        check "$esta" "El nombre del usuario es demasiado corto." "Ese usuario ya existe."
        read -p "Escriba uno nuevo: " usuario
        echo ""
        var=${#usuario}
        esta="$(mysql -u "$us" -p"$ps" -sse"SELECT EXISTS(SELECT 1 FROM mysql.user WHERE user = '$usuario')" 2>/dev/null)"
    done

}

#Controla si el usuario existe o no.
existe(){
    var=${#usuario}
    esta="$(mysql -u "$us" -p"$ps" -sse"SELECT EXISTS(SELECT 1 FROM mysql.user WHERE user = '$usuario')" 2>/dev/null)"
    while [ "$esta" -eq 0 ] || [ "$var" -lt 1 ]
    do
        check "$esta" "Ese usuario no existe." "El nombre es demasiado corto,"
        read -p "Escriba uno nuevo: " usuario
        echo ""
        var=${#usuario}
        esta="$(mysql -u "$us" -p"$ps" -sse"SELECT EXISTS(SELECT 1 FROM mysql.user WHERE user = '$usuario')" 2>/dev/null)"
    done
}


#Crea un usuario.
crearU(){
    read -p "Ingrese nombre del usuario a crear: " usuario
    repetido

    read -s -p "Ingrese contraseña del usuario a crear: " contrasena
    echo ""
    cont=${#contrasena}
    while [ "$cont" -lt 4 ]
    do
        read -s -p "Ingrese una contraseña de, al menos, 4 caracteres: " contrasena
        echo ""
        cont=${#contrasena}
    done 

    mysql -u "$us" -p"$ps" -h "localhost" -P "3306" -D "mysql" -sse "CREATE USER '$usuario'@'localhost' IDENTIFIED BY '$contrasena';"  2>/dev/null
    check "$?" "Usuario '$usuario' creado con éxito." "No se pudo crear el usuario '$usuario'."
    echo ""
}

#Elimina un usuario.
eliminarU(){
    read -p "Ingrese nombre del usuario a eliminar: " usuario
    existe

    while true; do
        read -p "¿Realmente desea eliminar el usuario: '$usuario'? (s/n): " sn
        echo ""
        if [ "$sn" == "s" ]; then
             mysql -u "$us" -p"$ps" -h "localhost" -P "3306" -D "mysql" -sse "DROP USER '$usuario'@'localhost';" 2>/dev/null
             check "$?" "Usuario '$usuario' eliminado con éxito." "No se pudo eliminar al usuario '$usuario'."
             break
        elif [ "$sn" == "n" ]; then
            echo "Operación cancelada."
            echo ""
            break
        else
            echo "Elija una opción válida."
            echo ""
        fi
    done
}

#Otorga permisos a un usuario.
permisosU(){
    read -p "Ingrese el nombre del usuario al que desea dar permisos: " usuario
    existe

    while true; do
        echo "¿Qué permiso desea otorgar?: "
        echo "  1. Todos los permisos."
        echo "  2. Solo creación de tablas BDs."
        echo "  3. Solo eliminación de tablas o BDs."
        echo "  4. Solo eliminación de registros en tablas."
        echo "  5. Solo inserción de registros en tablas."
        echo "  6. Solo consultas de datos de tablas o BDs."
        echo "  7. Solo actualizar filas de tablas."
        echo "  8. Eliminación o asignación de privilegios."
        read -p "Elija uno: " op

        case $op in
            1) mysql -u "$us" -p"$ps" -h "localhost" -P "3306" -sse "GRANT ALL PRIVILEGES ON *.* TO '$usuario'@'localhost'; FLUSH PRIVILEGES;" 2>/dev/null
                check "$?" "Se otorgaron todos los permisos al usuario '$usuario'." "Algo falló y no se otorgaron los permisos."
                break
                ;;
            2) mysql -u "$us" -p"$ps" -h "localhost" -P "3306" -sse "GRANT CREATE ON *.* TO '$usuario'@'localhost'; FLUSH PRIVILEGES;" 2>/dev/null
                check "$?" "Se otorgó el permiso al usuario '$usuario'." "Algo falló y no se otorgó el permiso."
                break
                ;;
            3) mysql -u "$us" -p"$ps" -h "localhost" -P "3306" -sse "GRANT DROP ON *.* TO '$usuario'@'localhost'; FLUSH PRIVILEGES;" 2>/dev/null
                check "$?" "Se otorgó el permiso al usuario '$usuario'." "Algo falló y no se otorgó el permiso."
                break
                ;;
            4) mysql -u "$us" -p"$ps" -h "localhost" -P "3306" -sse "GRANT DELETE ON *.* TO '$usuario'@'localhost'; FLUSH PRIVILEGES;" 2>/dev/null
                check "$?" "Se otorgó el permiso al usuario '$usuario'." "Algo falló y no se otorgó el permiso."
                break
                ;;
            5) mysql -u "$us" -p"$ps" -h "localhost" -P "3306" -sse "GRANT INSERT ON *.* TO '$usuario'@'localhost'; FLUSH PRIVILEGES;" 2>/dev/null
                check "$?" "Se otorgó el permiso al usuario '$usuario'." "Algo falló y no se otorgó el permiso."
                break
                ;;
            6) mysql -u "$us" -p"$ps" -h "localhost" -P "3306" -sse "GRANT SELECT ON *.* TO '$usuario'@'localhost'; FLUSH PRIVILEGES;" 2>/dev/null
                check "$?" "Se otorgó el permiso al usuario '$usuario'." "Algo falló y no se otorgó el permiso."
                break
                ;;
            7) mysql -u "$us" -p"$ps" -h "localhost" -P "3306" -sse "GRANT UPDATE ON *.* TO '$usuario'@'localhost'; FLUSH PRIVILEGES;" 2>/dev/null
                check "$?" "Se otorgó el permiso al usuario '$usuario'." "Algo falló y no se otorgó el permiso."
                break
                ;;
            8) mysql -u "$us" -p"$ps" -h "localhost" -P "3306" -sse "GRANT GRANT OPTION ON *.* TO '$usuario'@'localhost'; FLUSH PRIVILEGES;" 2>/dev/null
                check "$?" "Se otorgó el permiso al usuario '$usuario'." "Algo falló y no se otorgó el permiso."
                break
                ;;
            *) echo "-- Seleccione una opcion válida --"
                ;;
            esac
        done
}

#Elimina/Revoca permisos a un usuario
elimPermisosU(){
    read -p "Ingrese el nombre del usuario al que desea eliminar permisos: " usuario
    existe

     while true; do
        echo "¿Qué permiso desea eliminar?: "
        echo "  1. Todos los permisos."
        echo "  2. Solo creación de tablas BDs."
        echo "  3. Solo eliminación de tablas o BDs."
        echo "  4. Solo eliminación de registros en tablas."
        echo "  5. Solo inserción de registros en tablas."
        echo "  6. Solo consultas de datos de tablas o BDs."
        echo "  7. Solo actualizar filas de tablas."
        echo "  8. Eliminación o asignación de privilegios."
        read -p "Elija uno: " op
        case $op in
            1) mysql -u "$us" -p"$ps" -h "localhost" -P "3306" -ss 2>/dev/null <<EOF
            REVOKE ALL PRIVILEGES ON *.* FROM '$usuario'@'localhost';
            FLUSH PRIVILEGES;
EOF
                check "$?" "Se eliminaron todos los permisos al usuario '$usuario'." "Algo falló y no se eliminaron los permisos."
                break
                ;;
            2) mysql -u "$us" -p"$ps" -h "localhost" -P "3306" -ss 2>/dev/null <<EOF
            REVOKE CREATE ON *.* FROM '$usuario'@'localhost';
            FLUSH PRIVILEGES;
EOF
                check "$?" "Se eliminó el permiso al usuario '$usuario'." "Algo falló y no se eliminó el permiso."
                break
                ;;
            3) mysql -u "$us" -p"$ps" -h "localhost" -P "3306" -ss 2>/dev/null <<EOF
            REVOKE DROP ON *.* FROM '$usuario'@'localhost';
            FLUSH PRIVILEGES;
EOF
                check "$?" "Se eliminó el permiso al usuario '$usuario'." "Algo falló y no se eliminó el permiso."
                break
                ;;
            4) mysql -u "$us" -p"$ps" -h "localhost" -P "3306" -ss 2>/dev/null <<EOF
            REVOKE DELETE ON *.* FROM '$usuario'@'localhost';
            FLUSH PRIVILEGES;
EOF
                check "$?" "Se eliminó el permiso al usuario '$usuario'." "Algo falló y no se eliminó el permiso."
                break
                ;;
            5) mysql -u "$us" -p"$ps" -h "localhost" -P "3306" -ss 2>/dev/null <<EOF
            REVOKE INSERT ON *.* FROM '$usuario'@'localhost';
            FLUSH PRIVILEGES;
EOF
                check "$?" "Se eliminó el permiso al usuario '$usuario'." "Algo falló y no se eliminó el permiso."
                break
                ;;
            6) mysql -u "$us" -p"$ps" -h "localhost" -P "3306" -ss 2>/dev/null <<EOF
            REVOKE SELECT ON *.* FROM '$usuario'@'localhost';
            FLUSH PRIVILEGES;
EOF
                check "$?" "Se eliminó el permiso al usuario '$usuario'." "Algo falló y no se eliminó el permiso."
                break
                ;;
            7) mysql -u "$us" -p"$ps" -h "localhost" -P "3306" -ss 2>/dev/null <<EOF
            REVOKE UPDATE ON *.* FROM '$usuario'@'localhost';
            FLUSH PRIVILEGES;
EOF
                check "$?" "Se eliminó el permiso al usuario '$usuario'." "Algo falló y no se eliminó el permiso."
                break
                ;;
            8) mysql -u "$us" -p"$ps" -h "localhost" -P "3306" -ss 2>/dev/null <<EOF
            REVOKE GRANT OPTION ON *.* FROM '$usuario'@'localhost';
            FLUSH PRIVILEGES;
EOF
                check "$?" "Se eliminó el permiso al usuario '$usuario'." "Algo falló y no se eliminó el permiso."
                echo ""
                break
                ;;
            *) echo "-- Seleccione una opcion válida --"
                ;;
            esac
        done
}

#Permite la modificación de usuarios
modU(){
    read -p "Ingrese nombre de usuario a modificar: " usuario
    existe
    Nusuario="$usuario"

    read -p "Ingrese nuevo nombre del usuario: " usuario
    repetido
    echo " "

    read -s -p "Ingrese la contraseña del usuario a modificar: " contrasena
    echo " "
    cont=${#contrasena}
    while [ "$cont" -lt 4 ]
    do
        read -s -p "Ingrese una contraseña de, al menos, 4 caracteres: " contrasena
        echo " "
        cont=${#contrasena}
    done
    mysql -u "$Nusuario" -p"$contrasena" -e "EXIT" 2>/dev/null
    if [ $? -eq 0 ]; then        
        read -s -p "Ingrese la nueva contraseña: " contrasena
        echo ""
        cont=${#contrasena}
        while [ "$cont" -lt 4 ]
    do
        read -s -p "Ingrese una contraseña de, al menos, 4 caracteres: " contrasena
        echo ""
        cont=${#contrasena}
    done
        mysql -u "$us" -p"$ps" -e "RENAME USER '$Nusuario'@'localhost' TO '$usuario'@'localhost'; FLUSH PRIVILEGES;" 2>/dev/null
        check "$?" "Se cambió el nombre de $Nusuario a $usuario." "No fue posible cambiar el nombre de '$Nusuario' a '$usuario'."
        echo " "
        mysql -u "$us" -p"$ps" -e "ALTER USER '$usuario'@'localhost' IDENTIFIED BY '$contrasena'; FLUSH PRIVILEGES;" 2>/dev/null

        check "$?" "La contraseña se cambió satisfactoriamente." "No fue posible cambiar la contraseña."

    else
        echo "Autenticación fallida, contrasena errónea, no se pueden cambiar los datos."
    fi
}
