FROM debian:bookworm

RUN apt-get update && apt-get install -y ca-certificates

RUN rm /etc/apt/sources.list.d/debian.sources

COPY sources.list /etc/apt/

# Update package lists and install desired packages
RUN apt-get update && apt-get install -y \
    apache2 php-fpm libcgi-pm-perl \
    && apt-get clean
RUN apt-get install -y libapache2-mod-php8.2

COPY 000-default.conf   /etc/apache2/sites-available/
COPY other-site.conf    /etc/apache2/sites-available/

COPY public-html /var/www/html
COPY cgi-bin /usr/lib/cgi-bin/
RUN mkdir /var/www/other-site/
COPY other-site /var/www/other-site

RUN a2ensite other-site

RUN a2enmod rewrite 
RUN a2enconf  php8.2-fpm
RUN a2enmod proxy proxy_fcgi
RUN a2enmod cgi
RUN a2enmod status
RUN a2enmod proxy_http
RUN a2enmod php8.2

COPY var /var/
COPY htpasswd /etc/apache2/.htpasswd

EXPOSE 80

# Create symbolic links to redirect logs to stdout and stderr
RUN ln -sf /dev/stdout /var/log/apache2/access.log \
    && ln -sf /dev/stderr /var/log/apache2/error.log

COPY docker-entrypoint.sh /usr/local/bin/

# Ensure the entrypoint script is executable
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Set the entrypoint to your custom script
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
