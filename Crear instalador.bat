@echo off
title Creador de Instalador de Proyecto
setlocal enabledelayedexpansion

:menu
cls
echo ======================================
echo      Creador de Instalador de Proyecto
echo ======================================
echo 1. Asignar nombre del proyecto
echo 2. Asignar token de autenticacion
echo 3. Asignar repositorios
echo 4. Asignar IP
echo 5. Asignar puertos
echo 6. Crear instalador
echo 7. Eliminar instalador
echo 8. Leer README.txt
echo 9. Salir
echo ======================================
set /p opcion=Selecciona una opcion [1-9]: 

if "%opcion%"=="1" goto asignar_nombre
if "%opcion%"=="2" goto asignar_token
if "%opcion%"=="3" goto asignar_repositorios
if "%opcion%"=="4" goto asignar_ip
if "%opcion%"=="5" goto asignar_puertos
if "%opcion%"=="6" goto crear_instalador
if "%opcion%"=="7" goto eliminar_instalador
if "%opcion%"=="8" goto leer_readme
if "%opcion%"=="9" goto salir
goto menu

:asignar_nombre
cls
set /p project_name=Introduce el nombre del proyecto: 
goto menu

:asignar_token
cls
set /p token=Introduce el token de autenticacion (opcional): 
goto menu
:asignar_repositorios
cls
set /p frontend_repo=Repositorio de Frontend: 
set /p user_frontend=Nombre del creador del repositorio Frontend: 
set /p api_usuarios_repo=Repositorio de API_Usuarios: 
set /p user_api_usuarios=Nombre del creador del repositorio API_Usuarios (dejar vacío usará %user_frontend%): 
if "%user_api_usuarios%"=="" set user_api_usuarios=%user_frontend%
set /p api_posts_repo=Repositorio de API_Posts: 
set /p user_api_posts=Nombre del creador del repositorio API_Posts (dejar vacío usará %user_frontend%): 
if "%user_api_posts%"=="" set user_api_posts=%user_frontend%
set /p api_grupos_repo=Repositorio de API_Grupos: 
set /p user_api_grupos=Nombre del creador del repositorio API_Grupos (dejar vacío usará %user_frontend%): 
if "%user_api_grupos%"=="" set user_api_grupos=%user_frontend%
set /p backoffice_repo=Repositorio de Backoffice: 
set /p user_backoffice=Nombre del creador del repositorio Backoffice (dejar vacío usará %user_frontend%): 
if "%user_backoffice%"=="" set user_backoffice=%user_frontend%

goto menu


:asignar_ip
cls
set /p ip=Introduce la IP (default 127.0.0.1): 
if "%ip%"=="" set ip=127.0.0.1
goto menu

:asignar_puertos
cls
set /p port_frontend=Puerto para Frontend (default 8000): 
if "%port_frontend%"=="" set port_frontend=8000
set /p port_api_usuarios=Puerto para API_Usuarios (default 8001): 
if "%port_api_usuarios%"=="" set port_api_usuarios=8001
set /p port_api_posts=Puerto para API_Posts (default 8002): 
if "%port_api_posts%"=="" set port_api_posts=8002
set /p port_api_grupos=Puerto para API_Grupos (default 8003): 
if "%port_api_grupos%"=="" set port_api_grupos=8003
set /p port_backoffice=Puerto para Backoffice (default 8004): 
if "%port_backoffice%"=="" set port_backoffice=8004
goto menu

:crear_instalador
cls
echo Creando el instalador...
mkdir "%project_name%"
cd "%project_name%"
mkdir Frontend API_Usuarios API_Posts API_Grupos Backoffice

echo @echo off > Instalacion.bat
echo cd Frontend >> Instalacion.bat
echo git init . >> Instalacion.bat
if not "%frontend_repo%"=="" echo git pull https://%token%@github.com/%user_frontend%/%frontend_repo% >> Instalacion.bat
echo cd .. >> Instalacion.bat

echo cd Backoffice >> Instalacion.bat
echo git init . >> Instalacion.bat
if not "%backoffice_repo%"=="" echo git pull https://%token%@github.com/%user_backoffice%/%backoffice_repo% >> Instalacion.bat
echo start cmd /k "composer install" >> Instalacion.bat
copy .env.example .env >> Instalacion.bat
echo cd .. >> Instalacion.bat

echo cd API_Usuarios >> Instalacion.bat
echo git init . >> Instalacion.bat
if not "%api_usuarios_repo%"=="" echo git pull https://%token%@github.com/%user_api_usuarios%/%api_usuarios_repo% >> Instalacion.bat
echo start cmd /k "composer install" >> Instalacion.bat
copy .env.example .env >> Instalacion.bat
echo cd .. >> Instalacion.bat

echo cd API_Posts >> Instalacion.bat
echo git init . >> Instalacion.bat
if not "%api_posts_repo%"=="" echo git pull https://%token%@github.com/%user_frontend%/%api_posts_repo% >> Instalacion.bat
echo start cmd /k "composer install" >> Instalacion.bat
copy .env.example .env >> Instalacion.bat
echo cd .. >> Instalacion.bat

echo cd API_Grupos >> Instalacion.bat
echo git init . >> Instalacion.bat
if not "%api_grupos_repo%"=="" echo git pull https://%token%@github.com/%user_frontend%/%api_grupos_repo% >> Instalacion.bat
echo start cmd /k "composer install" >> Instalacion.bat
copy .env.example .env >> Instalacion.bat
echo cd .. >> Instalacion.bat

:: Crear el archivo 'hosts.bat'
echo @echo off > hosts.bat
echo start cmd /k "cd Frontend && php -S %ip%:%port_frontend%" >> hosts.bat

:: Verificar si existen carpetas 'vendor' y ejecutar servidor
echo if not exist API_Usuarios\vendor ( >> hosts.bat
echo     echo La carpeta 'vendor' no existe en API_Usuarios. Presiona cualquier tecla para continuar... >> hosts.bat
echo     pause >> hosts.bat
echo ) else ( >> hosts.bat
echo     start cmd /k "cd API_Usuarios && composer update && composer require laravel/passport && php artisan key:generate && php artisan migrate && php artisan passport:keys && php artisan passport:client --password && php artisan serve --host=%ip% --port=%port_api_usuarios%" >> hosts.bat
echo ) >> hosts.bat

echo if not exist API_Posts\vendor ( >> hosts.bat
echo     echo La carpeta 'vendor' no existe en API_Posts. Presiona cualquier tecla para continuar... >> hosts.bat
echo     pause >> hosts.bat
echo ) else ( >> hosts.bat
echo     start cmd /k "cd API_Posts && php artisan key:generate && php artisan serve --host=%ip% --port=%port_api_posts%" >> hosts.bat
echo ) >> hosts.bat

echo if not exist API_Grupos\vendor ( >> hosts.bat
echo     echo La carpeta 'vendor' no existe en API_Grupos. Presiona cualquier tecla para continuar... >> hosts.bat
echo     pause >> hosts.bat
echo ) else ( >> hosts.bat
echo     start cmd /k "cd API_Grupos && php artisan key:generate && php artisan serve --host=%ip%  --port=%port_api_grupos%" >> hosts.bat
echo ) >> hosts.bat

echo if not exist Backoffice\vendor ( >> hosts.bat
echo     echo La carpeta 'vendor' no existe en Backoffice. Presiona cualquier tecla para continuar... >> hosts.bat
echo     pause >> hosts.bat
echo ) else ( >> hosts.bat
echo     start cmd /k "cd Backoffice && php artisan key:generate && php artisan serve --host=%ip%  --port=%port_backoffice%" >> hosts.bat
echo ) >> hosts.bat


echo Instalador creado correctamente.
pause
goto menu

:eliminar_instalador
cls
set /p project_name=Introduce el nombre del proyecto: 
if exist %project_name%/Instalacion.bat del /f /q %project_name%/Instalacion.bat
pause
goto menu

:leer_readme
cls
type readme.txt
echo " "
pause
goto menu

pause
goto menu

:salir
cls
echo Presione cualquier tecla para continuar
pause
exit
