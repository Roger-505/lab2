#!/bin/bash

# el primer parametro pasado al script sera el PID de un proceso
# guardar PID en la variable PID

PID=$1

# guardar informacion de user, %CPU, %MEM, stat separado por espacios en
# la variable PDATA como un array

PDATA=$(ps aux | awk '$2=='$PID' { print $0 }')
PDATA=( $PDATA )

# guardar  user, %CPU, %MEM, stat en las variables USER, CPU, MEM, STAT
# respectivamente

USER=${PDATA[0]}
CPU=${PDATA[2]}
MEM=${PDATA[3]}
STAT=${PDATA[7]}

# guardar path del proceso en la variable PPATH

PPATH=$(readlink /proc/$PID/exe)

# guardar parent process id en la variable PPIDD

PPDATA=$(ps -efj | awk '$2=='$PID' { print $0 }')

PPDATA=( $PPDATA )
PPIDD=${PPDATA[2]}

# guardar nombre del proceso en la variable PNAME

PNAME=$(cat /proc/$PID/comm)

# imprimir en la terminal la siguiente informacion acerca del proceso:
# nombre, ID, parent process ID, usuario propietario, %CPU, %MEM, status, path

echo "---- Informacion relevante del proceso ----"
echo "Nombre: $PNAME"
echo "ID: $PID"
echo "Parent process ID: $PPIDD"
echo "Usuario propietario: $USER"
echo "Porcentaje de uso de CPU al momento de correr el script: $CPU"
echo "Consumo de memoria: $MEM"
echo "Estado (status): $STAT"
echo "Path del ejecutable: $PPATH"
