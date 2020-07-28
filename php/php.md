# get memory limit
`php -r "echo ini_get('memory_limit').PHP_EOL;"`
# set memory limit
`echo 'memory_limit = 1024M' >> /usr/local/etc/php/conf.d/docker-php-memlimit.ini;`