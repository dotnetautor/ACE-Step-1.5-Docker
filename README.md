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

## Quick Start

Pull and run the image:

```bash
docker pull ghcr.io/dotnetautor/ace-step-1.5-docker:latest
docker run -p 7860:7860 ghcr.io/dotnetautor/ace-step-1.5-docker:latest
```

Access the Gradio UI at http://localhost:7860

## Advanced Configuration

### Customizing Docker Run Command

The default docker run command uses the turbo configuration suitable for most users. However, you can customize it based on your GPU's VRAM to optimize performance or quality.

#### For Max Quality (≥16GB VRAM)

If you have a high-end GPU with 16GB or more VRAM, you can use the larger 4B language model for best quality:

```bash
docker run -p 7860:7860 ghcr.io/dotnetautor/ace-step-1.5-docker:latest \
  uv run acestep \
  --server-name 0.0.0.0 \
  --port 7860 \
  --language en \
  --download-source auto \
  --init_service true \
  --config_path acestep-v15-turbo \
  --lm_model_path acestep-5Hz-lm-4B
```

This configuration:
- Uses `acestep-5Hz-lm-4B` for best quality and audio understanding
- Pre-initializes models on startup with `--init_service true`
- Suitable for GPUs with ≥16GB VRAM

#### For Low VRAM (≤6GB)

If you have a GPU with 6GB or less VRAM, you can disable the language model to reduce memory usage:

```bash
docker run -p 7860:7860 ghcr.io/dotnetautor/ace-step-1.5-docker:latest \
  uv run acestep \
  --server-name 0.0.0.0 \
  --port 7860 \
  --language en \
  --download-source auto \
  --init_service true \
  --config_path acestep-v15-turbo \
  --init_llm false
```

This configuration:
- Disables the language model with `--init_llm false` (DiT-only mode)
- Faster generation and lower memory usage
- Suitable for GPUs with ≤6GB VRAM

For more configuration options and detailed documentation, see the [ACE-Step 1.5 README](https://github.com/ace-step/ACE-Step-1.5/blob/main/README.md).

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

