Creador de Instalador de Proyecto
Este script automatiza la configuración inicial de un proyecto desarrollado con PHP Laravel subido en repositorios de Github. Está diseñado para trabajar únicamente con Laravel y requiere la instalación previa de ciertas dependencias y configuraciones adicionales.
En caso de uso para repositorios privados se puede configurar un token de autorización personal que no será compartido ni saldrá fuera del equipo donde se ejecute el script.

Requisitos previos
Antes de ejecutar este script, asegúrate de contar con lo siguiente:

Git
Versión mínima de PHP: 7.4 o superior.
Extensiones PHP necesarias:
BCMath
Ctype
Fileinfo
JSON
Mbstring
OpenSSL
PDO
Tokenizer
XML
Composer: Debe estar instalado y disponible en el sistema.
7-Zip: Necesario para empaquetar archivos en caso de uso avanzado.
Funcionamiento del script
Este script permite:

Asignar configuraciones: Puedes definir el nombre del proyecto, tokens de autenticación, repositorios, IP y puertos necesarios para las APIs y el frontend.
Crear instaladores: Configura automáticamente la estructura del proyecto y genera un archivo Instalacion.bat que descarga los repositorios, instala dependencias y configura las APIs.
Eliminar instaladores: Limpia archivos generados previamente.
Leer el archivo README: Consulta las instrucciones directamente desde el script.
Configuración de las APIs
El archivo hosts.bat, generado por el instalador, se encargará de:

Ejecutar composer install: Esto instalará las dependencias necesarias para cada API configurada.
Configurar las APIs: Siempre que la base de datos esté configurada correctamente y accesible según los parámetros definidos en el script.
Iniciar los servidores: Configurará los servidores de Laravel en los puertos e IP definidos durante el proceso de instalación.
Nota importante
Antes de ejecutar el script, asegúrate de que la base de datos esté correctamente configurada y los accesos (usuario, contraseña, host) sean válidos.
La configuración de los puertos e IP debe coincidir con las especificaciones de tu entorno local o servidor.
Si encuentras problemas de ejecución, verifica los permisos de escritura y la compatibilidad de las extensiones requeridas.
Ejemplo de ejecución
Ejecuta el script principal (Creador de Instalador de Proyecto).
Define las configuraciones básicas (nombre del proyecto, repositorios, etc.).
Crea el instalador con la opción correspondiente.
Ejecuta el archivo hosts.bat para iniciar el entorno de desarrollo.
