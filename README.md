# ACE-Step-1.5-Docker

Docker container for running ACE-Step 1.5 Gradio UI - A highly efficient open-source music foundation model that brings commercial-grade music generation to consumer hardware.

## About ACE-Step 1.5

ACE-Step v1.5 is a cutting-edge music foundation model that achieves commercial-grade quality while remaining extremely fast and accessible:

### 🚀 Key Features

- **Ultra-Fast Generation**: Under 2 seconds per full song on A100, under 10 seconds on RTX 3090
- **Commercial-Grade Quality**: Performance beyond most commercial music models (between Suno v4.5 and Suno v5)
- **Lightweight**: Runs locally with less than 4GB of VRAM
- **Flexible Duration**: Generate music from 10 seconds to 10 minutes (600s)
- **Multi-Language Support**: Lyrics support for 50+ languages
- **Rich Style Support**: 1000+ instruments and styles with fine-grained timbre description
- **Advanced Capabilities**: Cover generation, audio editing, track separation, vocal-to-BGM conversion, LoRA training, and more

### 🎵 What Makes It Special

At its core lies a novel hybrid architecture where the Language Model (LM) functions as an omni-capable planner that transforms simple user queries into comprehensive song blueprints. The model synthesizes metadata, lyrics, and captions via Chain-of-Thought to guide the Diffusion Transformer (DiT), achieving alignment through intrinsic reinforcement learning.

## Getting Started

This section provides step-by-step examples to help you get started with ACE-Step 1.5, whether you have GPU support or not.

### Prerequisites

- Docker installed on your system ([Get Docker](https://docs.docker.com/get-docker/))
- At least 4GB of available RAM
- For GPU support: NVIDIA GPU with CUDA support and [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html) installed

### Getting Started Without GPU (CPU Only)

If you don't have a GPU or want to run on CPU only, follow these steps:

#### Step 1: Pull the Docker Image

```bash
docker pull ghcr.io/dotnetautor/ace-step-1.5-docker:latest
```

#### Step 2: Run the Container

```bash
docker run -p 7860:7860 ghcr.io/dotnetautor/ace-step-1.5-docker:latest
```

**Note:** CPU-only mode will be slower than GPU-accelerated mode. Music generation may take several minutes per song.

#### Step 3: Access the Web Interface

Open your web browser and navigate to:
```
http://localhost:7860
```

You should see the Gradio web interface where you can start generating music!

### Getting Started With GPU Support

If you have an NVIDIA GPU, you can significantly accelerate music generation. The configuration depends on your GPU's VRAM capacity.

#### Step 1: Verify GPU Support

First, ensure your system has GPU support:

```bash
docker run --rm --gpus all nvidia/cuda:11.8.0-base-ubuntu22.04 nvidia-smi
```

If this command shows your GPU information, you're ready to proceed!

#### Step 2: Pull the Docker Image

```bash
docker pull ghcr.io/dotnetautor/ace-step-1.5-docker:latest
```

#### Step 3: Run with GPU Support

Choose the appropriate configuration based on your GPU's VRAM:

##### For GPUs with 6GB or Less VRAM (e.g., GTX 1060, RTX 2060)

Use DiT-only mode for lower memory usage:

```bash
docker run --gpus all -p 7860:7860 ghcr.io/dotnetautor/ace-step-1.5-docker:latest \
  uv run acestep \
  --server-name 0.0.0.0 \
  --port 7860 \
  --language en \
  --download-source auto \
  --init_service true \
  --config_path acestep-v15-turbo \
  --init_llm false
```

**Features:**
- Uses `--init_llm false` to disable the language model (DiT-only mode)
- Faster generation with lower memory footprint
- Typical generation time: ~10-20 seconds (times vary by song length and complexity)

##### For GPUs with 8-16GB VRAM (e.g., RTX 3070, RTX 4060 Ti)

Use the default turbo configuration with the compact language model:

```bash
docker run --gpus all -p 7860:7860 ghcr.io/dotnetautor/ace-step-1.5-docker:latest
```

**Features:**
- Uses the default 1.7B language model (`acestep-5Hz-lm-1.7B`)
- Balanced performance and quality
- Typical generation time: ~5-15 seconds (times vary by song length and complexity)

##### For GPUs with 16GB or More VRAM (e.g., RTX 3090, RTX 4090, A100)

Use the larger 4B language model for maximum quality:

```bash
docker run --gpus all -p 7860:7860 ghcr.io/dotnetautor/ace-step-1.5-docker:latest \
  uv run acestep \
  --server-name 0.0.0.0 \
  --port 7860 \
  --language en \
  --download-source auto \
  --init_service true \
  --config_path acestep-v15-turbo \
  --lm_model_path acestep-5Hz-lm-4B
```

**Features:**
- Uses the larger `acestep-5Hz-lm-4B` model for best quality
- Superior audio comprehension and music planning
- Typical generation time: <2 seconds on A100, ~5-10 seconds on RTX 3090/4090 (times vary by song length and complexity)

#### Step 4: Access the Web Interface

Open your web browser and navigate to:
```
http://localhost:7860
```

The interface will be the same as the CPU version, but music generation will be much faster!

### Quick Reference: GPU Configuration Comparison

| GPU VRAM | Configuration | Language Model | Typical Generation Speed* | Best For |
|----------|---------------|----------------|---------------------------|----------|
| ≤6GB | `--init_llm false` | Disabled (DiT-only) | ~10-20s | Low-end GPUs, minimal VRAM |
| 8-16GB | Default | 1.7B (compact) | ~5-15s | Most users, balanced performance |
| ≥16GB | `--lm_model_path acestep-5Hz-lm-4B` | 4B (large) | ~2-10s | High-end GPUs, maximum quality |

*Generation times are approximate and vary based on song length, complexity, and prompt requirements.

### Additional Configuration Options

For more advanced configuration options and detailed documentation, see the [ACE-Step 1.5 README](https://github.com/ace-step/ACE-Step-1.5/blob/main/README.md).

## Building from Source

```bash
docker build -t ace-step-1.5-docker .
docker run -p 7860:7860 ace-step-1.5-docker
```

## What's Included

This Docker image provides:

- ACE-Step 1.5 music generation system
- Gradio web interface for easy interaction
- All necessary dependencies pre-installed via uv package manager
- Ready-to-use environment with Python 3.11

## System Requirements

- Docker installed on your system
- At least 4GB of available RAM (more recommended for better performance)
- GPU support optional but recommended for faster generation

## License

MIT License - see LICENSE file for details

## Credits

This Docker image packages the [ACE-Step 1.5](https://github.com/ACE-Step/ACE-Step-1.5) music generation system created by ACE Studio and StepFun.

### Original Project

- **GitHub Repository**: [https://github.com/ACE-Step/ACE-Step-1.5](https://github.com/ACE-Step/ACE-Step-1.5)
- **Project Website**: [https://ace-step.github.io/ace-step-v1.5.github.io/](https://ace-step.github.io/ace-step-v1.5.github.io/)
- **Hugging Face**: [https://huggingface.co/ACE-Step/Ace-Step1.5](https://huggingface.co/ACE-Step/Ace-Step1.5)
- **ModelScope**: [https://modelscope.cn/models/ACE-Step/Ace-Step1.5](https://modelscope.cn/models/ACE-Step/Ace-Step1.5)
- **Demo Space**: [https://huggingface.co/spaces/ACE-Step/Ace-Step-v1.5](https://huggingface.co/spaces/ACE-Step/Ace-Step-v1.5)
- **Technical Report**: [https://arxiv.org/abs/2602.00744](https://arxiv.org/abs/2602.00744)
- **Discord Community**: [https://discord.gg/PeWDxrkdj7](https://discord.gg/PeWDxrkdj7)

### Citation

If you use ACE-Step 1.5 in your research or project, please cite:

```bibtex
@misc{gong2026acestep,
	title={ACE-Step 1.5: Pushing the Boundaries of Open-Source Music Generation},
	author={Junmin Gong, Yulin Song, Wenxiao Zhao, Sen Wang, Shengyuan Xu, Jing Guo}, 
	howpublished={\url{https://github.com/ace-step/ACE-Step-1.5}},
	year={2026},
	note={GitHub repository}
}
```

### Acknowledgements

ACE-Step 1.5 is co-led by ACE Studio and StepFun. This Docker containerization is an independent packaging effort to make the system more accessible for deployment.

