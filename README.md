## dockerfile-apache-php-mysql-mongo

Docker image with Apache, PHP7, Mysql and MongoDB

### How to use it
Use as image tag `pensiero/apache-php-mysql-mongo`.

### Where to mount volumes
While running, Apache is gonna look by default at the content of the folder `/var/www`.
Use that as mount point for your volumes.

### Available PHP versions
Check out all the available tags here on [Docker Hub](https://hub.docker.com/repository/docker/pensiero/apache-php-mysql-mongo/tags).

If you wanna use different php version, you can leverage the following images
- `PHP 7.1` --> `pensiero/apache-php-mysql-mongo:php7.1`
- `PHP 7.2` --> `pensiero/apache-php-mysql-mongo:php7.2`
- `PHP 7.4` --> `pensiero/apache-php-mysql-mongo:php7.4`
