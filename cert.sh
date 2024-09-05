
docker-compose run --rm --entrypoint "\
certbot certonly \
-d api.greneta.shop \
-d blender.greneta.shop \
-d jenkins.greneta.shop \
--email sussa@gmail.com \
--manual --preferred-challenges dns \
--server https://acme-v02.api.letsencrypt.org/directory \
--force-renewal" certbot

docker-compose exec nginx_server nginx -s reload