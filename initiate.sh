#!/bin/bash

# 사용자 설정
IMAGE_NAME="my_project_image"
CONTAINER_NAME="my_project_container"

echo "=== Starting Docker container ==="

# Docker 이미지 빌드
docker build -t $IMAGE_NAME .

# Docker 컨테이너 실행
docker run -it -v $(pwd)/my_project:/app --name $CONTAINER_NAME $IMAGE_NAME bash