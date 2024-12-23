from setuptools import setup, find_packages

setup(
    name="ilora-serve",
    version="0.1",
    packages=find_packages(),
    install_requires=[
        "setuptools_scm",
        "fastapi",
        "pytest",
        "httpx",  # TestClient에 필요
        "langchain",
        "langchain-openai",
        "langchain-community",
        "faiss-cpu",
        "boto3",
        "pymupdf",
        "vllm"
    ]
) 