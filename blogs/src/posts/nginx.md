# build nginx from source

```
./configure --sbin-path=/usr/sbin/nginx --conf-path=/etc/nginx/nginx.conf --pid-path=/run/nginx.pid --with-http_ssl_module --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --with-threads --with-file-aio --with-http_v2_module --with-http_addition_module
```

# errors handling
FastCGI sent in stderr: "Primary script unknown" while reading response header from upstream...
 => nginx correct send file name to php but maybe php can not read it