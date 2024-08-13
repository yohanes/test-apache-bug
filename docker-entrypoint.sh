#!/bin/bash
set -e
echo "127.0.0.1 www.local" >> /etc/hosts

# Start PHP-FPM in the background
php-fpm8.2 &

# Start Apache in the foreground
exec apache2ctl -D FOREGROUND

