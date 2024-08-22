#!/bin/bash

source ./variables.sh
largo=""

#Verifica que las operaciones sean exitosas, los "$números" cumplen la función de un parámetro
check(){
    if [ "$1" -eq 0 ]; then
            echo "$2"
    else
            echo "$3"
    fi
}

#Controla que el texto ingresado cumpla con un requisito mínimo de carácteres, en este caso no debe ser menor a 1.
length(){
	while true; do
	if [[ "$1" -lt 1 ]]; then
		read -p "Demasiado corto, ingrese un nombre más largo: " bd
		largo=${#bd}
	else
		break
	fi
done
}


#Controla que una base de datos realmente exista o no
existe(){
	mysql -u "$us" -p"$ps" -h "localhost" -sse"USE $bd;" 2>/dev/null
	esta=$?
	check "$esta" "$1" "$2"
}

#Crea las bases de datos pasando por un control adecuado.
crearBD(){
	read -p "Ingrese nombre de la bd: " bd
	largo=${#bd}
	length largo
	echo ""
	existe "Esa base de datos ya existe." "Correcto."
	if [[ $? -eq 0 ]]; then
		mysql -u "$us" -p"$ps" -h "localhost" -sse"CREATE DATABASE $bd;" 2>/dev/null
		check "$?" "Base de datos creada satisfactoriamente." "No se pudo crear la base de datos."
		echo ""
	else
		echo "Hubo un problema y no se pudo crear la base de datos."
		echo ""
	fi
}

#Eliminar las bases de datos pasando por un control adecuado.
borrarBD(){
	read -p "Ingrese nombre de la bd a borrar: " bd
	largo=${#bd}
	length largo
	echo ""
	existe "" "Esa base de datos no existe."

	if [[ "$bd" == "mysql" ]] || [[ "$bd" == "information_schema" ]] || [[ "$bd" == "performance_schema" ]] || [[ "$bd" == "sys" ]] ; then
		echo "No es posible borrar $bd ¡¡Es vital para el sistema!!"
		exit 
	fi

	if [[ "$esta" -eq 0 ]]; then
		while true; do
			echo ""
			read -p "¿Está seguro que desea borrar la base de datos? (s/n): " sn
			case $sn in
				[sS])
					
						mysql -u "$us" -p"$ps" -h "localhost" -sse"DROP DATABASE $bd;" 2>/dev/null
						check "$?" "Base de datos borrada satisfactoriamente." "Algo salió mal, no se pudo borrar la base de datos."
						echo ""
						break
				;;
				[nN])
					echo "Operación cancelada."
					break
				;;
				*) echo "Elija S para Sí o N para NO."
				;;
			esac
		done
	else
		echo "No se pudo borrar la base de datos."
		echo ""
	fi

}

#Muestra un simple listado con las BDs del sistema.
mostrarBD(){
	echo "Bases de datos de este equipo: "
	mysql -u "$us" -p"$ps" -h "localhost" -e"SHOW DATABASES;" 2>/dev/null
	check "$?" "" "Algo salió mal..."
}
