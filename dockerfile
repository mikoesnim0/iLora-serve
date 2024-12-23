# Python 3.12 베이스 이미지
FROM python:3.12-slim

# 작업 디렉토리 설정
WORKDIR /app

# 의존성 파일만 복사 (빌드 캐싱 최적화)
COPY requirements.txt .

# 의존성 설치
RUN pip install --no-cache-dir -r requirements.txt

# 소스 코드 복사
COPY my_project/ .

# 환경 파일 복사 (필요 시)
# COPY .env .

# 기본 커맨드를 bash로 설정 (유연하게 사용)
CMD ["bash"]
