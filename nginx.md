# build nginx from source
./configure --prefix=/usr/sbin/nginx --sbin-path=/usr/sbin/nginx/nginx --conf-path=/etc/nginx/nginx.conf --pid-path=/run/nginx.pid --with-http_ssl_module --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log
