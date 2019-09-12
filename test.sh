#! /bin/bash
function get_file(){
cd /usr/local/src/
wget  https://openresty.org/download/openresty-1.13.6.1.tar.gz
wget  http://labs.frickle.com/files/ngx_cache_purge-2.3.tar.gz
wget  https://github.com/yaoweibin/nginx_upstream_check_module/archive/v0.3.0.tar.gz
wget  https://raw.githubusercontent.com/pintsized/lua-resty-http/master/lib/resty/http_headers.lua
wget  https://raw.githubusercontent.com/pintsized/lua-resty-http/master/lib/resty/http.lua
wget  https://ftp.pcre.org/pub/pcre/pcre-8.42.tar.gz
wget  https://www.openssl.org/source/openssl-1.0.2h.tar.gz
wget  https://github.com/winterQia/openresty/blob/master/dynamic_eureka_balancer.lua
wget  https://github.com/winterQia/openresty/blob/master/nginx.conf
}
function tar_x_file(){
cd /usr/local/src/
tar zxf openresty-1.13.6.1.tar.gz
tar zxf ngx_cache_purge-2.3.tar.gz
tar zxf v0.3.0.tar.gz
tar zxf pcre-8.42.tar.gz
tar zxf openssl-1.0.2h.tar.gz
}
function bianyi(){
yum -y install readline-devel pcre-devel openssl-devel gcc-c++ gcc
cd /usr/local/src/
cp -ra ngx_cache_purge-2.3 openresty-1.13.6.1/bundle/
cp -ra nginx_upstream_check_module-0.3.0 openresty-1.13.6.1/bundle/
cd /usr/local/src/pcre-8.42 && ./configure &&  make && make install
cd /usr/local/src/openresty-1.13.6.1 
./configure --prefix=/opt/openresty --with-http_realip_module  --with-http_stub_status_module --with-http_ssl_module --with-pcre=/usr/local/src/pcre-8.42 --with-stream  --with-http_gzip_static_module --with-stream_ssl_module --with-openssl=/usr/local/src/openssl-1.0.2h --with-luajit --add-module=/usr/local/src/openresty-1.13.6.1/bundle/ngx_cache_purge-2.3/ --add-module=/usr/local/src/openresty-1.13.6.1/bundle/nginx_upstream_check_module-0.3.0/ 
make && make install
cp /usr/local/src/http.lua /opt/openresty/lualib/resty/
cp /usr/local/src/http_headers.lua /opt/openresty/lualib/resty/
cp /usr/local/src/dynamic_eureka_balancer.lua  /opt/openresty/lualib/resty/
chmod -R 777  /opt/openresty/lualib/
mv  /opt/openresty/nginx/conf/nginx.conf    /opt/openresty/nginx/conf/nginx.confBAK
cp /usr/local/src/nginx.conf  /opt/openresty/nginx/conf/
}
get_file
tar_x_file
bianyi
