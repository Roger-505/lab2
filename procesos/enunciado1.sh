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

# guardar parent process id en la variable PPID


# imprimir la siguiente informacion acerca del proceso:
# nombre, ID, parent process ID, usuario propietario, %CPU, %MEM, status, path
