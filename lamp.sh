#!/bin/bash
# Escape
esc=`echo -en "\033"`
# Colores
cc_red="${esc}[0;31m"
cc_green="${esc}[0;32m"
cc_yellow="${esc}[0;33m"
cc_blue="${esc}[0;34m"
cc_normal=`echo -en "${esc}[m\017"`
#----------------------------------------------------------------------------------------
if [[ $UID != 0 ]]; then
echo ""
echo "${cc_yellow}Utilice el comando ${cc_red}SUDO${cc_yellow} para tener privilegios ${cc_red}ROOT${cc_yellow} para ejecutar el programa${cc_normal}"
echo ""
exit 1
fi
opc=0
until [ opc -eq "8" ]; do
clear
echo ""
echo "                      Despliegue Stack LAMP                      "
echo ""
echo "${cc_green}######################################################################${cc_normal}"
echo ""
echo " ${cc_blue}1)${cc_normal} Actualizar repositorios"
echo " ${cc_blue}2)${cc_normal} Instalar Apache"
echo " ${cc_blue}3)${cc_normal} Instalar MariaDB"
echo " ${cc_blue}4)${cc_normal} Instalar PHP"
echo " ${cc_blue}5)${cc_normal} Reiniciar servicios"
echo " ${cc_blue}6)${cc_normal} Configuracion de arranque"
echo " ${cc_blue}7)${cc_normal} Verificacion de servicios"
echo " ${cc_blue}8)${cc_normal} Consultar IP del host y status code Apache2"
echo "                                                                 "
echo " ${cc_blue}0)${cc_red} Salir${cc_normal}"
echo "                                                                 "
echo "    ${cc_yellow}---------------------------------------------------------"
echo "   | ${cc_normal}los registros de la ejecucion se almacenan en 'logs.txt'${cc_yellow}|"
echo "    ---------------------------------------------------------${cc_normal}"
echo "                                                                 "
echo "${cc_green}######################################################################${cc_normal}"
echo ""
read -n 1 -p ${cc_yellow}"Seleccione una opcion: "${cc_normal} opc
echo ""
case $opc in
#----------------------------------------------------------------------------------------
1) echo ""
   sleep 1s
   echo ""
   echo "${cc_blue}Actualizando los repositorios...${cc_normal}"
   echo ""
   sudo apt-get update -y  && sudo apt-get upgrade -y
   echo ""
   echo "Repositorios actualizados" >> logs.txt
   read -n 1 -p "${cc_yellow}presione una tecla para continuar...${cc_normal}"
   echo ""
   ;;
#----------------------------------------------------------------------------------------
2) echo""
   while true
   do
   read -p "Desea instalar Apache2? [${cc_blue}y${cc_normal}/${cc_blue}n${cc_normal}]: " RESP
   case $RESP in
	[yY]* ) echo ""
		echo "${cc_blue}Instalando Apache2...${cc_normal}"
                echo "" >> logs.txt
		sudo apt-get install apache2 -y >> logs.txt
                sleep 1s
                echo "Apache Instalado" >> logs.txt
                echo ""
		read -n 1 -p "${cc_yellow}presione una tecla para continuar...${cc_normal}"
                echo ""
                break ;;
	[nN]* ) break ;;
	* ) echo "Por favor, ingrese ${cc_red}Y${cc_normal} o ${cc_red}N${cc_normal}."
        echo ""
         ;;
   esac
   done
   ;;
#----------------------------------------------------------------------------------------
3) echo ""
   while true
   do
   read -p "Desea instalar MariaDB? [${cc_blue}y${cc_normal}/${cc_blue}n${cc_normal}]: " RESP
   case $RESP in
	[yY]* ) echo ""
		echo "${cc_blue}Instalando MariaDB...${cc_nomal}"
                echo ""
                echo "" >> logs.txt
                apt-get install mariadb-server -y >> logs.txt
                echo "------------------------" >> logs.txt
                echo "" >> logs.txt
                read -n 1 -p "${cc_yellow}presione una tecla para continuar...${cc_normal}"
                echo ""
                break ;;
	[nN]* ) break ;;
	* )	echo "Por favor, ingrese ${cc_red}Y${cc_normal} o ${cc_red}N${cc_normal}."
                echo ""
        ;;
   esac
   done
   ;;
#----------------------------------------------------------------------------------------
4) echo ""
   while true
   do
   read -p "Desea instalar PHP? [${cc_blue}y${cc_normal}/${cc_blue}n${cc_normal}]: " RESPUESTA
   case $RESPUESTA in
	[yY]* ) echo ""
		echo "${cc_blue}Instalando PHP...${cc_normal}"
		echo ""
                echo "" >> logs.txt
                echo "PHP Instalado" >> logs.txt
                echo "" >> logs.txt
		sudo apt-get install php libapache2-mod-php php-mysql -y >> logs.txt
                echo  "PHP instalado"
                sleep 1s
                read -n 1 -p "${cc_yellow}presione una tecla para continuar...${cc_normal}"
		break ;;
	[nN]* ) break ;;
	*)	echo "Por favor, ingrese ${cc_red}Y${cc_normal} o ${cc_red}N${cc_normal}."
                echo ""
    ;;
  esac
  done
   ;;
#----------------------------------------------------------------------------------------
5)
   echo ""
   while true
   do
   read -p "Desea reiniciar los servicios de Apache y MariaDB, seleccione [${cc_blue}y${cc_normal}/${cc_blue}n${cc_normal}]: " RESPUESTA
   case $RESPUESTA in
        [yY]* ) echo ""
                echo "${cc_blue}Reiniciando Servicios...${cc_normal}"
                echo ""
                sudo service apache2 reload
                systemctl daemon-reload
                sudo systemctl restart mariadb.service
                sleep 2s
                echo ""
                echo ""
                echo "Reiniciando..."
                echo ""
                read -n 1 -p "${cc_yellow}presione una tecla para continuar...${cc_normal}"
                echo ""
                break ;;
        [nN]* ) break ;;
        * ) echo "Por favor, ingrese ${cc_red}Y${cc_normal} o ${cc_red}N${cc_normal}."
     echo ""
    ;;
   esac
   done
    ;;
#----------------------------------------------------------------------------------------
6)echo ""
   while true
   do
   read -p "Desea que el servidor apache inicie con el sistema? [${cc_blue}y${cc_normal}/${cc_blue}n${cc_normal}]: " TA
   case $TA in
        [yY]* ) echo ""
                echo "Configurando..."
                echo ""
                sudo systemctl enable apache2
                sleep 2s && echo ""
                echo "Configurado"
                sleep 1s && echo ""
                read -n 1 -p "${cc_yellow}presione una tecla para continuar...${cc_normal}"
                echo ""
                break ;;
        [nN]* ) echo ""
		echo "Configurando..."
		echo ""
                sudo systemctl disable apache2
         	echo ""
                sleep 2s && echo "Configurado"
                sleep 1s && echo ""
                read -n 1 -p "${cc_yellow}presione una tecla para continuar...${cc_normal}"
                echo ""
	        break ;;
        * ) echo "Por favor, ingrese ${cc_red}Y${cc_normal} o ${cc_red}N${cc_normal}."
       read -n 1 -p "${cc_yellow}presione una tecla para continuar...${cc_normal}"
       echo ""
    ;;
	esac
       done
    ;;
#----------------------------------------------------------------------------------------
7)echo ""
  echo "Se otorgan permisos en el directorio default de html"
  chmod 755 /var/www/html
  echo ""
  echo "Configuracion terminada" && sleep 1s
  echo ""
  while true
  do
  read -p "Desea corroborar el estado de los servicios? [${cc_blue}y${cc_normal}/${cc_blue}n${cc_normal}]: " TA
   case $TA in
        [yY]* ) echo ""
                echo "Analizando..."
                echo "" && sleep 2s
                echo "El estado del servicio Apache2: "
                sudo service apache2 status | grep "active"
                echo "" && sleep 2s
                echo "El estado del servicio MariaDB: "
                service mariadb status | grep "active"
                echo "" && sleep 2s
                echo "El estado del servicio PHP: "
                php -v
                echo "" && sleep 2s
                echo " Funcionan correctamente los servicios"
                sleep 2s && echo ""
                read -n 1 -p "${cc_yellow}presione una tecla para continuar...${cc_normal}"
                echo ""
                break ;;
        [nN]* ) echo ""
                echo "No se verificara el estado de los servicios"
                echo ""
                sleep 1s && echo ""
                read -n 1 -p "${cc_yellow}presione una tecla para continuar...${cc_normal}"
                break ;;
        * ) echo "Por favor, ingrese ${cc_red}Y${cc_normal} o ${cc_red}N${cc_normal}."
    echo ""
    ;;
    esac
    done
    ;;
#----------------------------------------------------------------------------------------
8) var=$(hostname -I)
   echo ""
   echo ${cc_red}"Consultando direccion IP.."${cc_normal}
   sleep 1s
   echo "$var" > ip.txt
   echo ""
   while read line; do
        response=$(curl --write-out "%{http_code}\n" --silent --output /dev/null "http://$line")
   echo "El status code de ${cc_blue}http://$var${cc_normal}es ${cc_yellow}$response${cc_normal}"
   done < ip.txt
   echo ""
   read -n 1 -p "${cc_yellow}presione una tecla para continuar...${cc_normal}"
   echo ""
    ;;
#----------------------------------------------------------------------------------------
0) echo ""
   echo ${cc_red}"Saliendo del programa..."${cc_normal}
   echo ""
   sleep 1s
   exit
    ;;
 esac
 done
