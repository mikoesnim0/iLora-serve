B. OpenAI 호환 서버 실행
SageMaker Serverless Inference로 OpenAI API 호환 서버를 실행하려면 직접 커스텀 컨테이너를 생성하여 배포할 수 있습니다.

Dockerfile 생성 Hugging Face 모델을 OpenAI API 형식으로 변환하여 실행:

Dockerfile
코드 복사
FROM vllm/vllm-openai:latest

# Hugging Face 모델 추가
ENV HF_MODEL_ID=NousResearch/Meta-Llama-3-8B-Instruct
ENV HF_TASK=text-generation

CMD ["vllm", "serve", "$HF_MODEL_ID", "--dtype", "auto", "--api-key", "token-abc123"]
ECR에 컨테이너 업로드

bash
코드 복사
# Docker 빌드
docker build -t vllm-openai-hf .

# ECR 리포지토리 생성 및 이미지 푸시
aws ecr create-repository --repository-name vllm-openai-hf
docker tag vllm-openai-hf:latest <aws_account_id>.dkr.ecr.<region>.amazonaws.com/vllm-openai-hf
docker push <aws_account_id>.dkr.ecr.<region>.amazonaws.com/vllm-openai-hf
SageMaker에 배포 위에서 만든 ECR 이미지를 SageMaker에 배포:

python
코드 복사
from sagemaker.model import Model
from sagemaker.serverless import ServerlessInferenceConfig

model = Model(
    image_uri="<aws_account_id>.dkr.ecr.<region>.amazonaws.com/vllm-openai-hf",
    role='<your-sagemaker-role>'
)

model.deploy(
    serverless_inference_config=ServerlessInferenceConfig(memory_size_in_mb=4096, max_concurrency=5),
    endpoint_name="vllm-openai-serverless"
)