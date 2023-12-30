#!/bin/bash
#DEPRECATED , install whith docker!


PHP_TARGETS="php8-1" \
emerge -av      www-servers/nginx \
                dev-db/redis \
                dev-lang/php \
                dev-db/postgresql \
                dev-util/pkgconf \
                dev-php/pecl-redis \
                dev-php/pecl-redis \
                dev-php/pecl-imagick \
                app-misc/jq
VERSION=$(
curl -sL \
https://api.github.com/repos/nextcloud/server/tags?after=v25.0.0 |
jq -r ".[].name"| 
grep -v -e rc -e beta | 
head -1) && echo будет скачана $VERSION

wget https://download.nextcloud.com/server/releases/latest.zip \
-O /var/calculate/latest.zip
cd /var/calculate/
busybox unzip ./latest.zip
chown -R nginx: /var/calculate/nextcloud

cp ./nextcloud.conf /etc/nginx/sites-enabled/
openssl req -x509 -newkey rsa:4096 -sha256 -days 365 -nodes \
 -keyout /etc/nginx/ssl/privkey.pem \
 -out /etc/nginx/ssl/fullchain.pem \
 -subj "/CN=nextcloud.home.com"

nginx -t

emerge --config dev-db/postgresql
rc-update add postgresql-14
openrc
createuser -U postgres nextcloud --createdb
createdb -U postgres nextcloud -O nextcloud


declare -A ar

ar=(
"a              1"
"b              2"
)

arr=("${ar[@]}")

for i in ${!arr[*]}; do
        KEY=$(echo ${arr[$i]} | awk '{print $1}' )
        VALUE=$(echo ${arr[$i]} | awk '{print $2}' )
        
        sed -rie "s/^;$KEY/$KEY/; \
        s/($KEY\s+=)[^=]*$/\1 $VALUE/" test

done

rc-update add php-fpm
rc-update add nginx
rc-update add redis

openrc
