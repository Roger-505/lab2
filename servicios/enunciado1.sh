#!/bin/bash

# el directorio escogido cuyos cambios van a ser monitoreados 
# sera /home/rpiovet/Documents/UCR/ciclo6/ie0117/labos/lab2/servicios/test

# guardar directorio por monitorear en la variable MDIR
MDIR="/home/rpiovet/Documents/UCR/ciclo6/ie0117/labos/lab2/servicios/test"
MLOG="/home/rpiovet/Documents/UCR/ciclo6/ie0117/labos/lab2/servicios/log.txt"

check_dir_changes() {
  MCHANGE="$1"
  MFILE="$2"

  # imprimir aviso si se detectaron cambios en MDIR
  echo "Se ha detectado un evento de tipo '$MCHANGE' en el archivo '$MFILE'"
  
  # obtener fecha en la cual se identifico el cambio y guardar en log
  MDATE=$(date "+%Y-%m-%d %H:%M:%S")
  echo "[$MDATE] Evento '$MCHANGE' en el archivo '$MFILE'" >> "$MLOG"
}

# se monitorea el directorio por creacion, modificacion y eliminacion de archivos
while true
do
  # monitorear directorio por medio de inotifywait. -q indica al comando no imprimir
  # su salida estandar a la terminal y --event indica que solo se monitorean ciertas
  # acciones en el directorio. %e devuelve el tipo de accion y %f el archivo en donde esa
  # accion ocurrio.
  MCHANGE=$(inotifywait -q --event create,modify,delete --format "%e" "$MDIR")
  MFILE=$(inotifywait -q --event create,modify,delete --format "%f" "$MDIR")
  check_dir_changes "$MCHANGE" "$MFILE"
done

exit 0
