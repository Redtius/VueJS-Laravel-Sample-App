#!/bin/bash

# ENVIRONMENT VARIABLES ----------------------------------
cp /server/.env.example /server/.env

# DATABASE CONFIGURATION ----------------------------------
sed -i "s/DB_HOST=127.0.0.1/DB_HOST=${DB_HOST}/" /server/.env
sed -i "s/DB_PORT=3306/DB_PORT=${DB_PORT}/" /server/.env
sed -i "s/DB_DATABASE=laravel/DB_DATABASE=${DB_DATABASE}/" /server/.env
sed -i "s/DB_USERNAME=root/DB_USERNAME=${DB_USERNAME}/" /server/.env
sed -i "s/DB_PASSWORD=/DB_PASSWORD=${DB_PASSWORD}/" /server/.env

# WAIT FOR POSTGRES READY -----------------------------------
echo 'Checking PostgreSQL...'
while ! pg_isready -h ${DB_HOST} -U ${DB_USERNAME}
do
    sleep 1
    echo 'Waiting for PostgreSQL...'
done
echo 'PostgreSQL ready!'

# MIGRATIONS -----------------------------------
echo 'Running Migrations...'
cd /server
php artisan cache:clear
php artisan key:generate
php artisan migrate
echo 'Migrations done!'

# APACHE -----------------------------------
exec apache2-foreground
