# get memory limit
`php -r "echo ini_get('memory_limit').PHP_EOL;"`
# set memory limit
`echo 'memory_limit = 1024M' >> /usr/local/etc/php/conf.d/docker-php-memlimit.ini;`

# for docker run php memory error on composer
`php -d memory_limit=-1 /usr/bin/composer install`


# Common functions
## filter_var
Filters a variable with a specified filter
`filter_var ( mixed $variable [, int $filter = FILTER_DEFAULT [, mixed $options ]] ) : mixed`