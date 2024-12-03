#!/bin/bash

# Escape
esc=$(echo -en "\033")
# Colores
cc_red="${esc}[0;31m"
cc_green="${esc}[0;32m"
cc_yellow="${esc}[0;33m"
cc_blue="${esc}[0;34m"
cc_normal=$(echo -en "${esc}[m\017")

# Verificar privilegios
if [[ $UID != 0 ]]; then
    echo ""
    echo "${cc_yellow}Utilice el comando ${cc_red}SUDO${cc_yellow} para tener privilegios ${cc_red}ROOT${cc_yellow} para ejecutar el programa${cc_normal}"
    echo ""
    exit 1
fi

opc=0
until [ "$opc" -eq "0" ]; do
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
    echo " ${cc_blue}6)${cc_normal} Configuración automática de MariaDB"
    echo " ${cc_blue}7)${cc_normal} Verificar estado de servicios"
    echo " ${cc_blue}8)${cc_normal} Configurar Virtual Host para Apache"
    echo " ${cc_blue}0)${cc_red} Salir${cc_normal}"
    echo ""
    echo "${cc_green}######################################################################${cc_normal}"
    echo ""
    read -n 1 -p "${cc_yellow}Seleccione una opción: ${cc_normal}" opc
    echo ""

    case $opc in
    1)
        echo "${cc_blue}Actualizando repositorios...${cc_normal}"
        sudo apt-get update -y && sudo apt-get upgrade -y || {
            echo "${cc_red}Error al actualizar los repositorios.${cc_normal}"
            exit 1
        }
        echo "Repositorios actualizados." >>logs.txt
        read -n 1 -p "${cc_yellow}Presione una tecla para continuar...${cc_normal}"
        ;;
    2)
        if ! dpkg -l | grep -q apache2; then
            echo "${cc_blue}Instalando Apache...${cc_normal}"
            sudo apt-get install apache2 -y || {
                echo "${cc_red}Error al instalar Apache.${cc_normal}"
                exit 1
            }
            echo "Apache instalado correctamente." >>logs.txt
        else
            echo "${cc_yellow}Apache ya está instalado.${cc_normal}"
        fi
        read -n 1 -p "${cc_yellow}Presione una tecla para continuar...${cc_normal}"
        ;;
    3)
        if ! dpkg -l | grep -q mariadb-server; then
            echo "${cc_blue}Instalando MariaDB...${cc_normal}"
            sudo apt-get install mariadb-server -y || {
                echo "${cc_red}Error al instalar MariaDB.${cc_normal}"
                exit 1
            }
            echo "MariaDB instalado correctamente." >>logs.txt
        else
            echo "${cc_yellow}MariaDB ya está instalado.${cc_normal}"
        fi
        read -n 1 -p "${cc_yellow}Presione una tecla para continuar...${cc_normal}"
        ;;
    4)
        if ! dpkg -l | grep -q php; then
            echo "${cc_blue}Instalando PHP y extensiones...${cc_normal}"
            sudo apt-get install php libapache2-mod-php php-mysql php-cli php-xml php-curl php-intl php-zip php-mbstring -y || {
                echo "${cc_red}Error al instalar PHP.${cc_normal}"
                exit 1
            }
            echo "PHP instalado correctamente." >>logs.txt
        else
            echo "${cc_yellow}PHP ya está instalado.${cc_normal}"
        fi
        read -n 1 -p "${cc_yellow}Presione una tecla para continuar...${cc_normal}"
        ;;
    5)
        echo "${cc_blue}Reiniciando servicios...${cc_normal}"
        sudo systemctl restart apache2 mariadb || {
            echo "${cc_red}Error al reiniciar los servicios.${cc_normal}"
            exit 1
        }
        echo "Servicios reiniciados." >>logs.txt
        read -n 1 -p "${cc_yellow}Presione una tecla para continuar...${cc_normal}"
        ;;
    6)
        echo "${cc_blue}Configurando MariaDB automáticamente...${cc_normal}"
        sudo mysql_secure_installation || {
            echo "${cc_red}Error en la configuración de MariaDB.${cc_normal}"
            exit 1
        }
        echo "MariaDB configurado correctamente." >>logs.txt
        read -n 1 -p "${cc_yellow}Presione una tecla para continuar...${cc_normal}"
        ;;
    7)
        echo "${cc_blue}Verificando estado de servicios...${cc_normal}"
        systemctl status apache2 | grep "Active: active"
        systemctl status mariadb | grep "Active: active"
        php -v
        echo "Estado verificado correctamente." >>logs.txt
        read -n 1 -p "${cc_yellow}Presione una tecla para continuar...${cc_normal}"
        ;;
    8)
        echo "${cc_blue}Configurando Virtual Host para Apache...${cc_normal}"
        read -p "Ingrese el dominio (ejemplo: example.com): " domain
        sudo mkdir -p /var/www/$domain/html
        sudo chown -R $USER:$USER /var/www/$domain/html
        sudo chmod -R 755 /var/www/$domain
        echo "<html><head><title>Bienvenido a $domain</title></head><body><h1>Funciona!</h1></body></html>" >/var/www/$domain/html/index.html
        conf_file="/etc/apache2/sites-available/$domain.conf"
        sudo bash -c "cat > $conf_file <<EOF
<VirtualHost *:80>
    ServerAdmin webmaster@$domain
    ServerName $domain
    ServerAlias www.$domain
    DocumentRoot /var/www/$domain/html
    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF"
        sudo a2ensite $domain.conf
        sudo systemctl reload apache2
        echo "Virtual Host configurado correctamente." >>logs.txt
        read -n 1 -p "${cc_yellow}Presione una tecla para continuar...${cc_normal}"
        ;;
    0)
        echo "${cc_red}Saliendo del programa...${cc_normal}"
        sleep 1
        exit
        ;;
    *)
        echo "${cc_red}Opción no válida.${cc_normal}"
        read -n 1 -p "${cc_yellow}Presione una tecla para continuar...${cc_normal}"
        ;;
    esac
done
