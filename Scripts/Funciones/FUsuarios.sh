#!/bin/bash

usuario=""
contrasena=""

crearU(){
    read -p "Ingrese nombre del usuario a crear: " usuario
    read -ps "Ingrese contraseña del usuario a crear: " contrasena
    mysql -u "" -p"$ps" -h "localhost
    " -P "3306" "mysql" -A -ss 2>/dev/null<< EOF
    CREATE USER '$usuario'@'localhost' IDENTIFIED BY '$contrasena'
    EOF
}
