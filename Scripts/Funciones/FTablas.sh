#!/bin/bash

source ./../variables.sh

a="0"

#Se almacena el tipo de dato así como se utiliza para almacenar el nombre del campo/columna
declare -a datos

#Guardará el nombre de los campos cuando el array datos esté ocupado
declare -a nombres

#Guardará los tipos de dato ingresados para su posterior uso
declare -a ingresado

#Guardará los valores ingresados para poder insertar o buscar datos en las tablas
declare -a valores

#Específicamente diseñado para guardar los datos tipo DATE y poder controlar que se ingresen de forma correcta
declare -a fecha


datos[0]="VARCHAR(255)"
datos[1]="INT"
datos[2]="DATE"

largo=""

tipoDatos(){
	while true; do
		echo ""
		echo "	0- VARCHAR."
		echo "	1- INT."
		echo "	2- DATE."
		read -p "Seleccione un tipo de dato: " op
		echo ""
		case "$op" in
			0|1|2) ingresado[$a]=${datos[$op]}
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
					mysql -u "$us" -p"$ps" -h "localhost" -D "$bd" -sse "CREATE TABLE $tb (${nombres[0]} ${ingresado[0]} PRIMARY KEY);" 2</dev/null
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
		echo "Se mostrará el campo primario de esa tabla: "
  		mysql -u "$us" -p"$ps" -h "localhost" -D "$bd" -e"SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = '$bd' AND TABLE_NAME = '$tb' AND COLUMN_KEY = 'PRI';" -N 2>/dev/null
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
						mysql -u "$us" -p"$ps" -h "localhost" -D "$bd" -sse"DELETE FROM $bd.$tb WHERE $campo = '$valor';" 2</dev/null
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
		echo "No se pudo completar la acción."
  	fi
}

insertarRegistro(){
	selTB
	mysql -u "$us" -p"$ps" -h "localhost" -D "$bd" -e "SELECT * FROM $tb;" >/dev/null 2<&1
	esta=$?
	cantCols=$(mysql -u "$us" -p"$ps" -h "localhost" -D "$db" -sse "SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = '$tb';" 2</dev/null)
	nameCols=$(mysql -u "$us" -p"$ps" -D "$bd" -e "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = '$tb' AND TABLE_SCHEMA = '$db';" 2</dev/null -B -N | tr '\n' ' ' 2</dev/null)
	check "$esta" " " "Error."
	if [ "$nulo_o_no" == "0" ]; then
		a="0"
		unset datos
		for col in $nameCols; do
				datos[$a]="$col"
				a=$((a+1))
	    done
		for (( i = 0; i < $cantCols; i++ )); do
			tipo=$(mysql -u "$us" -p"$ps" -D "$bd" -e "SELECT COLUMN_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = '$tb' AND COLUMN_NAME = '${datos[$i]}';" 2</dev/null -B -N | tr -d '[:space:]')
			case $tipo in
				"int") 
						while true; do
							read -p "Ingrese un número: " valores[$i]
							if [[ "${valores[$i]}" =~ ^-?[0-9]+$ ]]; then
		           				echo "Correcto. "
		           				echo ""
		            			break
					        else
					            echo "Entrada no válida. Por favor, introduce solo números enteros."
					        fi
					    done
				;;
				"varchar(255)") 
						while true; do
							read -p "Ingrese un dato o conjunto de caracteres: " valores[$i]
							if [[ "${#valores[$i]}" != 0 ]]; then
		           				echo "Correcto. "
		           				echo ""
		            			break
					        else
					            echo "Entrada no válida. Por favor, ingrese aunque sea un caracter. "
					        fi
					    done
				;;
				"date") 
						while true; do
							read -p "Ingrese un año (a partir de 1000): " fecha[$1]
							if [[ "${fecha[$1]}" -gt 1000 && "${fecha[$1]}" =~ ^-?[0-9]+$ ]]; then
		           				while true; do
									read -p "Ingrese un mes: " fecha[$2]
									if [[ "${fecha[$1]}" -lt 12 && "${fecha[$1]}" -gt 0 && "${fecha[$2]}" =~ ^-?[0-9]+$ ]]; then
				           				echo "Correcto. "
				           				echo ""
		            				break
							        else
							            echo "Entrada no válida. Por favor, introduce un año mayor o igual a 1000."
							            break
							        fi
					 	   		done
					        else
					            echo "Entrada no válida. Por favor, introduce un año mayor o igual a 1000."
					        fi
					    done
				;;
			esac
		done
	fi
}
modTB(){
	echo "Modificar tabla"
}

verTB(){
	selTB
	mysql -u "$us" -p"$ps" -h "localhost" -D "$bd" -e "SELECT * FROM $tb;" >/dev/null 2<&1
	esta=$?
	check "$esta" " " "Error."
	if [[ "$nulo_o_no" == "0" ]]; then
		datos=$(mysql -u "$us" -p"$ps" -h "localhost" -D "$bd" -e "SELECT * FROM $tb" 2>/dev/null)
		if [[ -z "$datos" || "$datos" == *"Empty set"* ]]; then
			echo "Tabla vacía"
		else
			mysql -u "$us" -p"$ps" -h "localhost" -D "$bd" -e "SELECT * FROM $tb" 2>/dev/null
		fi
	else
		echo "Operación cancelada."
	fi
}

#Sirve para extraer el tipo de dato de cada campo/columna
#(mysql -u "$us" -p"$ps" -D "$bd" -e "SELECT COLUMN_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = '$tb' AND COLUMN_NAME = '$nameCols';" -B -N | tr -d '[:space:]')

#Extrae los nombres de cada campo/columna de una tabla
#mysql -u "$us" -p"$ps" -D "$bd" -e "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = '$tb' AND TABLE_SCHEMA = '$db';" -B -N | tr '\n' ' '

#Puedo extraer la cantidad de campos/columnas de una tabla
#cantCols=$(mysql -u "$us" -p"$ps" -h "localhost" -D "$db" -sse "SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = '$tb';" 2</dev/null)

#-B: Modo de salida en formato tabular.
#-N: Omite los encabezados de columna.
#tr '\n' ' ': "Corta los datos de salida" y cambia el salto de línea del formato tabla por un espacio

