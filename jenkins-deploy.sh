#!/bin/bash

# 여기만 수정해서 사용하면됨
APP_CONTAINER_NAME=generator-web-server-app

# App 컨테이너, 이미지 이름
APP_OLD_IMAGES_NAME=docker-build_app
# MySQL 컨테이너, 이미지 이름
MYSQL_CONTAINER_NAME=mysql
MYSQL_OLD_IMAGES_NAME=mysql
# Redis 컨테이너, 이미지 이름
REDIS_CONTAINER_NAME=redis_server
NGINX_OLD_IMAGES_NAME=nginx
# Nginx 컨테이너, 이미지 이름
NGINX_CONTAINER_NAME=nginx_server
REDIS_OLD_IMAGES_NAME=redis
# Certbot 컨테이너, 이미지 이름
CERTBOT_CONTAINER_NAME=cerbot
CERTBOT_OLD_IMAGES_NAME=certbot/certbot



# 기존 컨테이너 종료 및 이미지 삭제 함수
cleanup_old_container_and_images() {
  local container_name=$1
  local image_reference=$2

  if [ "$(sudo docker ps -q -f name=$container_name)" ]; then
    echo "Stopping existing ${container_name} container..."
    sudo docker stop $container_name
    echo "Removing existing ${container_name} container..."
    sudo docker rm $container_name
  fi

  OLD_IMAGES=$(sudo docker images -aq --filter "reference=$image_reference")

  if [ ! -z "$OLD_IMAGES" ]; then
    echo "Removing old images for reference: ${image_reference}..."
    sudo docker rmi -f $OLD_IMAGES
  else
    echo "No images found for reference: ${image_reference}"
  fi
}

# 컨테이너 및 이미지 정리
cleanup_old_container_and_images "$APP_CONTAINER_NAME" "$APP_OLD_IMAGES_NAME"
cleanup_old_container_and_images "$MYSQL_CONTAINER_NAME" "$MYSQL_OLD_IMAGES_NAME"
cleanup_old_container_and_images "$REDIS_CONTAINER_NAME" "$REDIS_OLD_IMAGES_NAME"
cleanup_old_container_and_images "$NGINX_CONTAINER_NAME" "$NGINX_OLD_IMAGES_NAME"
cleanup_old_container_and_images "$CERTBOT_CONTAINER_NAME" "$CERTBOT_OLD_IMAGES_NAME"


# Docker Compose 빌드
sudo docker-compose build

# 나머지 컨테이너를 Docker Compose을 사용하여 실행
sudo docker-compose up -d