# Despliegue Stack LAMP

Este script de bash automatiza la instalación y configuración de un entorno LAMP (Linux, Apache, MySQL/MariaDB, PHP) en sistemas Debian/Ubuntu.

## Uso

Sigue estos pasos para ejecutar el script en tu sistema Debian/Ubuntu:

1. Clona el Repositorio:
```bash
git clone https://github.com/carlostcba/stacklamp.git
```

2. Navega al Directorio del Repositorio:
3. 
```bash
cd stacklamp
```
3. Haz el Script de Bash Ejecutable:

```bash
chmod +x script.sh
```

4. Ejecuta el Script:
```bash
./script.sh
```

# Despliegue Stack LAMP

Este script de bash automatiza la instalación y configuración de un entorno LAMP (Linux, Apache, MySQL/MariaDB, PHP) en sistemas Debian/Ubuntu.

## Uso

1. Asegúrate de ejecutar el script con permisos de administrador (`sudo`).
2. Ejecuta el script con el comando `bash script.sh`.
3. Selecciona las opciones según tus necesidades.

## Requisitos

- Este script está diseñado para ejecutarse en sistemas Debian/Ubuntu.
- Se debe tener conexión a internet para actualizar los repositorios y descargar los paquetes necesarios.

## Funcionalidades

- Actualización de repositorios.
- Instalación de Apache, MariaDB y PHP.
- Reinicio de servicios.
- Configuración de inicio automático de Apache.
- Verificación del estado de los servicios instalados.
- Consulta de la dirección IP del host y el status code de Apache2.

## Instrucciones de Ejecución

1. Descarga el archivo `lamp.sh`.
2. Otorga permisos de ejecución al script con el comando `chmod +x script.sh`.
3. Ejecuta el script con el comando `bash script.sh`.
4. Sigue las instrucciones que aparecen en pantalla para seleccionar las opciones deseadas.

## Notas

- Los registros de la ejecución se almacenan en el archivo `logs.txt`.
- Asegúrate de revisar los mensajes de confirmación y los estados de los servicios durante la ejecución del script.

---
