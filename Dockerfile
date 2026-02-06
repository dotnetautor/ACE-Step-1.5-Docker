FROM python:3.11-slim-bookworm

RUN apt-get update && apt-get install -y git build-essential ca-certificates
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir uv

WORKDIR /workspace/ace_music_platform

ARG UPSTREAM_REPOSITORY=https://github.com/ACE-Step/ACE-Step-1.5.git
RUN git clone ${UPSTREAM_REPOSITORY} source_tree

WORKDIR /workspace/ace_music_platform/source_tree
RUN uv sync

EXPOSE 7860

CMD ["uv", "run", "acestep", "--server-name", "0.0.0.0", "--language", "en", "--download-source", "auto", "--init_service", "true", "--config_path", "acestep-v15-turbo", "--lm_model_path", "acestep-5Hz-lm-1.7B"]
