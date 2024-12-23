#!/bin/bash

# 사용자 설정
DOCKERHUB_USERNAME="mikoesnim643" # Docker Hub 사용자 이름
IMAGE_NAME="my_project_image"               # 이미지 이름
WORKDIR=$(pwd)/my_project                   # 현재 작업 디렉토리 유지

echo "=== Starting Docker container ==="

# Step 1: Docker Hub에서 최신 이미지 가져오기
echo "Pulling the latest Docker image..."
docker pull $DOCKERHUB_USERNAME/$IMAGE_NAME:latest

# Step 2: Docker 이미지 빌드
# echo "Building the Docker image..."
# docker build -t $IMAGE_NAME .

# Step 3: 로컬 디렉토리 유지 및 Docker 컨테이너 실행
echo "Starting a new container from the latest image..."
docker run -it -v $WORKDIR:/app --name $CONTAINER_NAME $DOCKERHUB_USERNAME/$IMAGE_NAME:latest bash

echo "=== Docker container started successfully ==="