#!/bin/bash

# 사용자 설정
IMAGE_NAME="my_project_image"
CONTAINER_NAME="my_project_container"
DOCKERHUB_USERNAME="mikoesnim643"

# 날짜 정보
DATE=$(date +'%Y-%m-%d')

# 1. 버전 입력
echo "What's the version?"
read VERSION

# 2. 커밋 메시지 입력
echo "What's the commit message for it?"
read COMMIT_MESSAGE

echo "=== Committing Docker container changes ==="

# 기본적으로 Docker 이미지를 커밋
if [[ -z "$VERSION" ]]; then
    # 버전이 없는 경우 기본 메시지로 커밋
    docker commit -m "$COMMIT_MESSAGE (No version, committed on $DATE)" $CONTAINER_NAME $IMAGE_NAME
else
    # 버전이 있는 경우 버전 태그를 포함하여 커밋
    docker commit -m "$COMMIT_MESSAGE (Version $VERSION on $DATE)" $CONTAINER_NAME $IMAGE_NAME:$VERSION
fi

# Docker Hub에 업로드
docker tag $IMAGE_NAME $DOCKERHUB_USERNAME/$IMAGE_NAME:latest
docker tag $IMAGE_NAME $DOCKERHUB_USERNAME/$IMAGE_NAME:$DATE-${VERSION:-no-version}
docker push $DOCKERHUB_USERNAME/$IMAGE_NAME:latest
docker push $DOCKERHUB_USERNAME/$IMAGE_NAME:$DATE-${VERSION:-no-version}

echo "=== Docker container changes pushed ==="

# (2) 컨테이너 중지
echo "=== Stopping the Docker container ==="
docker stop "$CONTAINER_NAME"


# Git 업데이트
git add .
git commit -m "$COMMIT_MESSAGE (Version $VERSION on $DATE)"

echo "=== Git repository updated ==="