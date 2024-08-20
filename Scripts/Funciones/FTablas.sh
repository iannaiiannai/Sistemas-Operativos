#!/bin/bash

source ./variables.sh

a="0"
declare -a datos
declare -a nombres
declare -a ingresado

datos[0]="VARCHAR(255)"
datos[1]="INT"
datos[2]="DATE"
datos[3]="TIMESTAMP"
datos[4]="FLOAT"

largo=""

tipoDatos(){
	while true; do
		echo ""
		echo "	0- VARCHAR."
		echo "	1- INT."
		echo "	2- DATE."
		echo "	3- TIMESTAMP."
		echo "	4- FLOAT."
		read -p "Seleccione un tipo de dato: " op
		echo ""
		case "$op" in
			0|1|2|3|4) ingresado[$a]=${datos[$op]}
			a=$((a + 1))
			break
			;;
			*) echo "Elija una opción que se encuentre dentro del rango."
			;;
		esac
	done
}


#Verifica que las operaciones sean exitosas, los "$números" cumplen la función de un parámetro
check(){
    if [ "$1" -eq 0 ]; then
        echo "$2"
	    nulo_o_no="0"
    else
        echo "$3"
	    nulo_o_no="1"
    fi
}


#Controla que el texto ingresado cumpla con un requisito mínimo de carácteres, en este caso no debe ser menor a 1.
length(){
	while true; do
	if [[ "$1" -lt 1 ]]; then
		read -p "Demasiado corto, ingrese un nombre más largo: " nombre
		largo=${#nombre}
	else
		break
	fi
done
}

#Controla que una base de datos realmente exista y la selecciona para su posterior uso.
BDexist(){
	mysql -u "$us" -p"$ps" -h "localhost" -sse"USE $nombre;" 2>/dev/null
	esta=$?
	while [ "$esta" -eq 1 ]
	do
		read -p "Seleccione una base de datos que exista: " nombre
		largo=${#nombre}
		length largo
		mysql -u "$us" -p"$ps" -h "localhost" -sse"USE $nombre;" 2>/dev/null
		esta=$?

	done
	check "$esta" "$1" "$2"
	db="$nombre"
}

TBexist(){
	nulo_o_no="0"
	esta=$(mysql -u "$us" -p"$ps" -h "localhost" -sse "SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = '$db' AND TABLE_NAME = '$nombre';" 2>/dev/null)
	check "$esta" "$1" "$2"
	tb="$nombre"
}

selTB(){
	selDB
	read -p "Ingrese nombre de la tabla: " nombre
	largo=${#nombre}
	length largo
	TBexist "Esa tabla no existe. "  "Tabla seleccionada. "
	tb=$nombre
}

selDB(){
	read -p "Elija la base de datos que usará: " nombre
	largo=${#nombre} 
	length largo
	BDexist "Base de datos seleccionada." "Esa base de datos no existe."
	bd=$nombre
	echo ""
}

crearTB(){
	selDB
	read -p "Escriba nombre de la tabla a crear: " nombre
	largo=${#nombre}
	length largo
	echo ""
	TBexist  "Correcto." "Esa tabla ya existe."
	if [[ "$esta" -eq 0 ]]; then
		while true; do
			echo ""
			read -p "¿Cuántos campos desea que tenga su tabla (el primer campo será PK)? (números del 1 al 5, 6 para cancelar): " campos
			case $campos in
				1) 
					read -p "Ingrese un nombre para el campo N°1: " nombres[0]
					nombre=${nombres[0]}
					largo=${#nombre}
					length largo
					nombres[0]="$nombre"
					tipoDatos
					mysql -u "$us" -p"$ps" -h "localhost" -D "$bd" -sse "CREATE TABLE $tb (${nombres[0]} ${ingresado[0]} PRIMARY KEY);"
					check "$?" "La tabla se creó exitosamente" "No se pudo crear la tabla"
					break
				;;
				2)
					for (( i = 0; i < 2; i++ )); do
						read -p "Ingrese un nombre para el campo N°$((i + 1)): " nombres[i]
						nombre=${nombres[i]}
						largo=${#nombre}
						length largo
						nombres[i]="$nombre"
						tipoDatos
					done
					echo ${ingresado[0]} ${ingresado[1]}
						mysql -u "$us" -p"$ps" -h "localhost" -D "$bd" -sse "
						CREATE TABLE $tb (
						${nombres[0]} ${ingresado[0]} PRIMARY KEY,
						${nombres[1]} ${ingresado[1]}
						);
						" 2>/dev/null
						check "$?" "La tabla se creó exitosamente" "No se pudo crear la tabla"
						break
				;;
				3)
					for (( i = 0; i < 3; i++ )); do
						read -p "Ingrese un nombre para el campo N°$((i + 1)): " nombres[i]
						nombre=${nombres[i]}
						largo=${#nombre}
						length largo
						nombres[i]="$nombre"
						tipoDatos
					done
					echo ${ingresado[0]} ${ingresado[1]}
						mysql -u "$us" -p"$ps" -h "localhost" -D "$bd" -sse "
						CREATE TABLE $tb (
						${nombres[0]} ${ingresado[0]} PRIMARY KEY,
						${nombres[1]} ${ingresado[1]},
						${nombres[2]} ${ingresado[2]}
						);
						" 2>/dev/null
						check "$?" "La tabla se creó exitosamente" "No se pudo crear la tabla"
						break
				;;
				4)
					for (( i = 0; i < 4; i++ )); do
						read -p "Ingrese un nombre para el campo N°$((i + 1)): " nombres[i]
						nombre=${nombres[i]}
						largo=${#nombre}
						length largo
						nombres[i]="$nombre"
						tipoDatos
					done
					echo ${ingresado[0]} ${ingresado[1]}
						mysql -u "$us" -p"$ps" -h "localhost" -D "$bd" -sse "
						CREATE TABLE $tb (
						${nombres[0]} ${ingresado[0]} PRIMARY KEY,
						${nombres[1]} ${ingresado[1]},
						${nombres[2]} ${ingresado[2]},
						${nombres[3]} ${ingresado[3]}
						);
						" 2>/dev/null
						check "$?" "La tabla se creó exitosamente" "No se pudo crear la tabla"
						break
				;;
				5)
					for (( i = 0; i < 5; i++ )); do
						read -p "Ingrese un nombre para el campo N°$((i + 1)): " nombres[i]
						nombre=${nombres[i]}
						largo=${#nombre}
						length largo
						nombres[i]="$nombre"
						tipoDatos
					done
					echo ${ingresado[0]} ${ingresado[1]}
						mysql -u "$us" -p"$ps" -h "localhost" -D "$bd" -sse "
						CREATE TABLE $tb (
						${nombres[0]} ${ingresado[0]} PRIMARY KEY,
						${nombres[1]} ${ingresado[1]},
						${nombres[2]} ${ingresado[2]},
						${nombres[3]} ${ingresado[3]},
						${nombres[4]} ${ingresado[4]}
						);
						" 2</deb/null
						check "$?" "La tabla se creó exitosamente" "No se pudo crear la tabla"
						break
				;;
				6) echo "Operación cancelada."
					exit
				;;
				*) echo "Elija una opción que se encuentre dentro del rango."
				;;
			esac
		done

	fi
}

eliminarTB(){
	selDB
	read -p "Escriba nombre de la tabla a borrar: " nombre
	largo=${#nombre}
	length largo
	echo ""
	TBexist  "Esa tabla no existe." "Correcto."
	
	if [[ "$esta" -eq 1 ]]; then
		while true; do
			echo ""
			read -p "¿Está seguro que desea borrar la tabla? (s/n): " sn
			case $sn in
				[sS])
					
						mysql -u "$us" -p"$ps" -h "localhost" -sse"DROP TABLE $db.$tb;" 2>/dev/null
						check "$?" "Tabla borrada satisfactoriamente." "Algo salió mal, no se pudo borrar la tabla."
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
		echo "Operación cancelada."
	fi
	
}

eliminarRegistro(){
	selTB
	mysql -u "$us" -p"$ps" -h "localhost" -D "$bd" -e "SELECT * FROM $bd.$tb;" >/dev/null 2<&1
	esta=$?
	check "$esta" " " "Error."
 	if [ "$nulo_o_no" == "0" ]; then
		echo ""
		echo "Se mostrará/n el/los campo/s primario/s de esa tabla: "
  		mysql -u "$us" -p"$ps" -h "localhost" -D "$bd" -e"SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = '$bd' AND TABLE_NAME = '$tb' AND COLUMN_KEY = 'PRI';" 2>/dev/null
		while true; do
			read -p "Ingrese nombre del campo: " campo
			mysql -u "$us" -p"$ps" -h "localhost" -D "$bd" -e"SELECT * FROM $tb WHERE $campo;" >/dev/null 2<&1
			esta=$?
			echo "$esta"
			if [[ "$esta" -eq 0 ]]; then
				while true; do
					read -p "Ingrese el valor del registro a borrar: " valor
					esta=$(mysql -u "$us" -p"$ps" -h "localhost" -D "$bd" -sse "SELECT * FROM $tb WHERE $campo = '$valor';" 2>/dev/null)
					if [[ "$esta" -eq 1 ]]; then
						mysql -u "$us" -p"$ps" -h "localhost" -D "$bd" -sse"DELETE FROM $bd.$tb WHERE $campo = '$valor';"
      						check "$?" "Registro borrado exitosamente." "No fue posible borrar el registro."
					else
						echo "No se pudo borrar el registro."
					fi
           				break
				done
			else
				echo "Ingrese un campo válido"
			fi
   			break
		done
	else
		echo "NO"
  	fi
}

insertarRegistro(){
	echo "Insertar registros"
}
modTB(){
	echo "Modificar tabla"
}
verTB(){
	echo "Ver tablas"
}

