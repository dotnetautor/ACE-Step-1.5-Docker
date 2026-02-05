# ACE-Step-1.5-Docker

Docker container for running ACE-Step 1.5 Gradio UI

## Quick Start

Pull and run the image:

```bash
docker pull ghcr.io/dotnetautor/ace-step-1.5-docker:latest
docker run -p 7860:7860 ghcr.io/dotnetautor/ace-step-1.5-docker:latest
```

Access the Gradio UI at http://localhost:7860

## Building from Source

```bash
docker build -t ace-step-1.5-docker .
docker run -p 7860:7860 ace-step-1.5-docker
```

## License

MIT License - see LICENSE file for details

## About

This Docker image packages the ACE-Step 1.5 music generation system with a Gradio web interface for easy deployment.

