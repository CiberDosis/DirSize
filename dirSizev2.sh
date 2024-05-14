#!/bin/bash 
############################## Colores // CREADO POR CiberDosis
greenColour="\e[0;32m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
endColour="\033[0m\e[0m"
blueColour="\e[0;34m\033[1m"
redColour="\e[0;31m\033[1m"
yellowColour="\e[0;33m\033[1m"
grayColour="\e[0;37m\033[1m"
######################## Ctrl_c
ctrl_c() {
  echo -e "${redColour}\n\n[!] Saliendo...${endColour}\n"
  exit 1
}
trap ctrl_c INT
######################## helpPanel
helpPanel() {
 echo -e "\n\t${yellowColour}[++]${endColour} ${redColour}Para poder ejecutar esta herramienta atraves de los parametros la sintaxis tiene que ser si o si: -x (file) -sd/-sf/-n (directorio) o directamente sin parametros indico el direcotrio${endColour}\n"
 echo "Nota: solo se permiten dos parametros como maximo, ejemplo -x file.txt -sd /var/ "
 echo -e "\n\t${yellowColour}[++]${endColour} ${redColour}Este es el panel de ayuda para la herramienta DirSize.${endColour}\n"
 echo -e "\t${yellowColour}[-]${endColour} ${redColour}En esta herramienta tenemos estas opciones:${endColour}\n"
 echo -e "\t\t ${yellowColour}{+}${endColour} ${purpleColour}[ -x ]${endColour}${turquoiseColour} Guardar en un archivo.${endColour}\n"
 echo -e "\t\t ${yellowColour}{+}${endColour} ${purpleColour}[ -sd ]${endColour}${turquoiseColour} Con esto filtramos por el espacio del directorio a escanear${endColour}\n"
 echo -e "\t\t ${yellowColour}{+}${endColour} ${purpleColour}[ -sf ]${endColour}${turquoiseColour} Con esto filtramos por el numero de ficheros del directorio.${endColour}\n"
 echo -e "\t\t ${yellowColour}{+}${endColour} ${purpleColour}[ -n ]${endColour}${turquoiseColour} Con esto filtramos por el orden de nombre del directorio a escanear${endColour}\n"
 echo -e "\t\t ${yellowColour}{+}${endColour} ${purpleColour}[ - Estos argumentos tienen que ir ligados al -x si quieres guardar el archivo. ]${endColour}\n"
 echo -e "\t ${yellowColour}[++]${endColour} ${redColour}Si no proporcionas ninguna de estas opciones no funcionara la herramienta y te saltara este panel de  nuevo.${endColour}\n"
 echo -e "\n\t ${yellowColour}[++]${endColour} ${blueColour}Un placer informarte $USER ${greenColour}:)${endColour}\n"
}
DirSize() {
  echo -e "\n\t${yellowColour}[-]${endColour}${turquoiseColour} Dirsize${endColour}${redColour} v1${endColour}"
  echo -e "\n\n\t${yellowColour}[-]${endColour}${turquoiseColour} Creado por ${endColour}${redColour}Andrés Cámara${endColour}"
  echo -e "\n\n\t${yellowColour}[-]${endColour}${turquoiseColour} Scanning:${endColour}${redColour} $directorio\n${endColour}"
  echo -e "------------------------------------------------------------------------------------------------------------------------------------------------------------\n"""
  printf "%-30s %-30s %-30s ${redColour}%-30s${endColour} ${yellowColour}%-30s${endColour}\n" "Directory" "Files" "Size(Mb)" "Grafico" "Porcentaje"
  echo -e "\n------------------------------------------------------------------------------------------------------------------------------------------------------------\n"
  #Bucle que imprime toda la salida.
  for i in $(find "$directorio" -maxdepth 1 -mindepth 1 | sort -nr); do
    declare -i files=$(find "$i" -type f | wc -l | sort -nr) # archivos
    declare -i espacio=$(du -sm "$i" | cut -f1) # espacio
    declare -i tamano=$(echo "$espacio") # tamaño
    declare -i num_caracteres=$(du -sm $directorio | cut -f1)
    # Calcula el porcentaje en función del tamaño y el valor de $num_caracteres
    porcentaje=$(($tamano * 100 / $num_caracteres))
    # Asegúramos que el porcentaje esta en el rango de 0 a 100
    porcentaje="$(($porcentaje < 0 ? 0 : ($porcentaje > 100 ? 100 : $porcentaje)))"
    printf "%-30s %-30s %-30s ${redColour}%-30s${endColour} ${yellowColour}%3s%%${endColour}\n" "$i" "$files" "$espacio" "$(printf '#%.0s' $(seq 1 3 $porcentaje))" "$porcentaje"
  done | sort -k3,3nr
  echo -e "${yellowColour}\n------------------------------------------------------------------------------------------------------------------------------------------------------------\n${endColour}"
  echo -e "${yellowColour} [+]${endColour}${purpleColour} El total de directorios es: ${endColour}${redColour}$(find $directorio -maxdepth 1 -mindepth 1 | sort -nr | wc -l)${endColour}\n"
  echo -e "${yellowColour} [+]${endColour}${purpleColour} El total de archivos es: ${endColour}${redColour}$(find $directorio -type f | wc -l)${endColour}\n"
  echo -e "${yellowColour} [+]${endColour}${purpleColour} El espacio que ocupa el directorio es de: ${endColour}${redColour}$(du -sm $directorio | cut -f1)MB${endColour}\n"
  echo -e "${yellowColour} [+]${endColour}${grayColour} Los porcentajes son en base al peso del directorio total en este caso:${endColour}${redColour} $directorio${endColour}\n"
}
DirSizeName() {
  echo -e "\n\t${yellowColour}[-]${endColour}${turquoiseColour} Dirsize${endColour}${redColour} v1${endColour}"
  echo -e "\n\n\t${yellowColour}[-]${endColour}${turquoiseColour} Creado por ${endColour}${redColour}Andrés Cámara${endColour}"
  echo -e "\n\n\t${yellowColour}[-]${endColour}${turquoiseColour} Scanning:${endColour}${redColour} $directorio\n${endColour}"
  echo -e "------------------------------------------------------------------------------------------------------------------------------------------------------------\n"""
  printf "%-30s %-30s %-30s ${redColour}%-30s${endColour} ${yellowColour}%-30s${endColour}\n" "Directory" "Files" "Size(Mb)" "Grafico" "Porcentaje"
  echo -e "\n------------------------------------------------------------------------------------------------------------------------------------------------------------\n"
  #Bucle que imprime toda la salida.
  for i in $(find "$directorio" -maxdepth 1 -mindepth 1 | sort -nr); do
    declare -i files=$(find "$i" -type f | wc -l | sort -nr) # archivos
    declare -i espacio=$(du -sm "$i" | cut -f1) # espacio
    declare -i tamano=$(echo "$espacio") # tamaño
    declare -i num_caracteres=$(du -sm $directorio | cut -f1)
    # Calcula el porcentaje en función del tamaño y el valor de $num_caracteres
    porcentaje=$(($tamano * 100 / $num_caracteres))
    # Asegúramos que el porcentaje esta en el rango de 0 a 100
    porcentaje="$(($porcentaje < 0 ? 0 : ($porcentaje > 100 ? 100 : $porcentaje)))"
    printf "%-30s %-30s %-30s ${redColour}%-30s${endColour} ${yellowColour}%3s%%${endColour}\n" "$i" "$files" "$espacio" "$(printf '#%.0s' $(seq 1 3 $porcentaje))" "$porcentaje"
  done | sort -k1,1nr
  echo -e "${yellowColour}\n------------------------------------------------------------------------------------------------------------------------------------------------------------\n${endColour}"
  echo -e "${yellowColour} [+]${endColour}${purpleColour} El total de directorios es: ${endColour}${redColour}$(find $directorio -maxdepth 1 -mindepth 1 | sort -nr | wc -l)${endColour}\n"
  echo -e "${yellowColour} [+]${endColour}${purpleColour} El total de archivos es: ${endColour}${redColour}$(find $directorio -type f | wc -l)${endColour}\n"
  echo -e "${yellowColour} [+]${endColour}${purpleColour} El espacio que ocupa el directorio es de: ${endColour}${redColour}$(du -sm $directorio | cut -f1)MB${endColour}\n"
  echo -e "${yellowColour} [+]${endColour}${grayColour} Los porcentajes son en base al peso del directorio total en este caso:${endColour}${redColour} $directorio${endColour}\n"
}
DirSizeFILES() {
  echo -e "\n\t${yellowColour}[-]${endColour}${turquoiseColour} Dirsize${endColour}${redColour} v1${endColour}"
  echo -e "\n\n\t${yellowColour}[-]${endColour}${turquoiseColour} Creado por ${endColour}${redColour}Andrés Cámara${endColour}"
  echo -e "\n\n\t${yellowColour}[-]${endColour}${turquoiseColour} Scanning:${endColour}${redColour} $directorio\n${endColour}"
  echo -e "------------------------------------------------------------------------------------------------------------------------------------------------------------\n"""
  printf "%-30s %-30s %-30s ${redColour}%-30s${endColour} ${yellowColour}%-30s${endColour}\n" "Directory" "Files" "Size(Mb)" "Grafico" "Porcentaje"
  echo -e "\n------------------------------------------------------------------------------------------------------------------------------------------------------------\n"
  #Bucle que imprime toda la salida.
  for i in $(find "$directorio" -maxdepth 1 -mindepth 1 | sort -nr); do
    declare -i files=$(find "$i" -type f | wc -l) # archivos
    declare -i espacio=$(du -sm "$i" | cut -f1) # espacio
    declare -i tamano=$(echo "$espacio") # tamaño
    declare -i num_caracteres=$(du -sm $directorio | cut -f1)
    # Calcula el porcentaje en función del tamaño y el valor de $num_caracteres
    porcentaje=$(($tamano * 100 / $num_caracteres))
    # Asegúramos que el porcentaje esta en el rango de 0 a 100
    porcentaje="$(($porcentaje < 0 ? 0 : ($porcentaje > 100 ? 100 : $porcentaje)))"
    printf "%-30s %-30s %-30s ${redColour}%-30s${endColour} ${yellowColour}%3s%%${endColour}\n" "$i" "$files" "$espacio" "$(printf '#%.0s' $(seq 1 3 $porcentaje))" "$porcentaje"
  done | sort -k2,2nr
  echo -e "${yellowColour}\n------------------------------------------------------------------------------------------------------------------------------------------------------------\n${endColour}"
  echo -e "${yellowColour} [+]${endColour}${purpleColour} El total de directorios es: ${endColour}${redColour}$(find $directorio -maxdepth 1 -mindepth 1 | sort -nr | wc -l)${endColour}\n"
  echo -e "${yellowColour} [+]${endColour}${purpleColour} El total de archivos es: ${endColour}${redColour}$(find $directorio -type f | wc -l)${endColour}\n"
  echo -e "${yellowColour} [+]${endColour}${purpleColour} El espacio que ocupa el directorio es de: ${endColour}${redColour}$(du -sm $directorio | cut -f1)MB${endColour}\n"
  echo -e "${yellowColour} [+]${endColour}${grayColour} Los porcentajes son en base al peso del directorio total en este caso:${endColour}${redColour} $directorio${endColour}\n"
}
while getopts ":x:sd:f:n:h" arg; do
  case $arg in
    x)
      filesave=$OPTARG
      ;;
    s|d)
      directorio=$OPTARG
      ;;
    h)
      helpPanel
      exit 0
      ;;
    f)
      archivos=$OPTARG
     ;;
    n)
      nombre=$OPTARG
    ;;
    \?)
      echo "Opción no válida: -$OPTARG" >&2
      helpPanel
      exit 1
      ;;
  esac
done
if [ -n "$directorio" ] && [ -z "$filesave" ] && [ -z "$archivos" ] && [ -z "$nombre" ]; then
  DirSize
  exit 0
elif [ -n "$directorio" ] && [ -n "$filesave" ] && [ -z "$archivos" ] && [ -z "$nombre" ]; then
  DirSize > "$filesave"
  echo -e "\n\t ${yellowColour}[+]${endColour} ${grayColour}El archivo se ha creado en tu directorio actual con el nombre${endColour}${redColour} $filesave${endColour}\n"
  cat "$filesave"
  exit 0
elif [ -n "$filesave" ] && [ -n "$archivos" ] && [ -z "$directorio" ] && [ -z "$nombre" ]; then
  directorio=$4
  DirSizeFILES > "$filesave"
  echo -e "\n\t ${yellowColour}[+]${endColour} ${grayColour}El archivo se ha creado en tu directorio actual con el nombre${endColour}${redColour} $filesave${endColour}\n"
  cat "$filesave"
  exit 0
elif [ -n "$archivos" ] && [ -z "$filesave" ] && [ -z "$directorio" ] && [ -z "$nombre" ]; then
  directorio=$2
  DirSizeFILES
  exit 0
elif [ -n "$nombre" ] && [ -z "$filesave" ] && [ -z "$directorio" ] && [ -z "$archivos" ]; then
  directorio=$2
  DirSizeName
  exit 0
elif [ -n "$nombre" ] && [ -n "$filesave" ] && [ -z "$directorio" ] && [ -z "$archivos" ]; then
  directorio=$4
  DirSizeName > "$filesave"
  echo -e "\n\t ${yellowColour}[+]${endColour} ${grayColour}El archivo se ha creado en tu directorio actual con el nombre${endColour}${redColour} $filesave${endColour}\n"
  cat "$filesave"
  exit 0
elif [ ! -z $1 ]; then
  if [ ! -d $1 ]; then
    echo -e "\n${redColour}No es un directorio válido o argumento invalido. Intentalo de nuevo.${endColour}"
    sleep 2
    helpPanel
    exit 1
  else
    echo -e "\n ${greenColour}El directorio es Valido.${endColour}"
    sleep 1
  fi
  directorio=$1
  DirSize 
  exit 0
else
  echo -e "\n${redColour}No se proporcionó ninguna opción o combinación válida.${endColour}"
  helpPanel
  exit 1
fi
