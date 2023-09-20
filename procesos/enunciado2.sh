#!/bin/bash 

# guardar nombre de un proceso en la variable NAME y el comando
# para ejecutarlo en la variable PCMD

NAME=$1
PCMD=$2

# obtencion de estado del proceso

check_status(){
	# obtener pid a partir del nombre del proceso
	
	PID=$(pgrep $NAME)

	# obtener status del proceso a partir de su PID
	PDATA=$(ps aux | awk '$2=='$PID' { print $0 }')
	

	EXCODE=$?
	PDATA=( $PDATA )
	STAT=${PDATA[7]}
	
	# verificar si el estado no es nulo
	if [ -z $STAT ]
	then
		STAT="0"
	fi

	echo "$STAT $EXCODE"
}

# revisar el proceso periodicamente

while true
do
	# llamar a la funcion check_status y guardar el estado
	# y codigo de salida del comando awk en las variables
	# STAT y EXCODE, respectivamente
	
	STATDATA=( $(check_status 2>/dev/null) )
	STAT=${STATDATA[0]}
	EXCODE=${STATDATA[1]}
	
	# imprimir estado actual del proceso, o volverlo a levantar
	# dependiendo de EXCODE
	if [ $EXCODE -ne 2 ] 
	then
		echo "Estado actual del proceso: $STAT"
		sleep 3
	else
		echo "El procesos ha sido terminado. Se volvera a levantar."
		sleep 3
		eval $PCMD &
	fi
done

exit 0
