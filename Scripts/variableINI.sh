#!/bin/bash


# Función para intentar la conexión a MySQL
check_mysql_connection() {
    mysql -u "$1" -p"$2" -h "$host" -P "$port" -e "SELECT 1;" >/dev/null 2>&1
}

# Variables de conexión
host="localhost"
port="3306"
db="base_de_datos"

# Bucle para solicitar credenciales hasta que la conexión sea exitosa
while true; do
    # Solicitar el nombre de usuario
    read -p "Ingrese el usuario de MySQL: " us

    # Solicitar la contraseña de manera oculta
    read -s -p "Ingrese la contraseña de MySQL: " ps
    echo

    # Intentar la conexión
    if check_mysql_connection "$us" "$ps"; then
        echo "Conexión exitosa a MySQL."
        break
    else
        echo "Credenciales incorrectas. Inténtelo de nuevo."
    fi
done

# Aquí puedes continuar con el resto del script usando las credenciales válidas.
