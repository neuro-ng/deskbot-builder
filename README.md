# Deskbot Builder Image

[![Build and Publish Deskbot Builder Image](https://github.com/neuro-ng/deskbot-builder/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/neuro-ng/deskbot-builder/actions/workflows/docker-publish.yml)
[![Docker Image](https://ghcr-badge.egpl.dev/neuro-ng/deskbot-builder/latest_tag?trim=major&label=latest)](https://github.com/neuro-ng/deskbot-builder/pkgs/container/deskbot-builder)

A minimal Docker image for compiling and developing Deskbot with all essential system dependencies.

## 🐳 This Docker Image

This is a lightweight Docker image that provides the Rust toolchain and required system libraries to compile Deskbot. Perfect for:

* **Full development workflows** with all build tools pre-configured
* **CI/CD pipelines** requiring the Deskbot build environment
* **Quick compilation** without manual system library installation
* **Consistent build environments** across teams

### What's Included

- **Base**: `rust:1-slim` (Debian-based)
- **Toolchain**: Rust compiler (`rustc`) and package manager (`cargo`)
- **System Dependencies**:
  - `pkg-config` - For locating libraries during the build
  - `libssl-dev` - OpenSSL development headers required by network crates like `reqwest`

## 🚀 Quick Start

### Pull and Run
```bash
# Pull the latest image
docker pull ghcr.io/neuro-ng/deskbot-builder:latest

# Run interactively
docker run -it --rm ghcr.io/neuro-ng/deskbot-builder:latest

# Mount your deskbot-builder project directory
docker run -it --rm -v $(pwd):/workspace -w /workspace ghcr.io/neuro-ng/deskbot-builder:latest
```

### Basic Usage
```bash
# Rust and Cargo are already available
cargo -version

# Build the Deskbot project
cd deskbot
cargo build --release

# Run tests
cargo test
```

## 🔧 Use in GitHub Actions

You can use this image directly in your GitHub Actions workflows to compile Deskbot:

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    container:
      image: ghcr.io/neuro-ng/deskbot-builder:latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Build Deskbot
        run: |
          cd deskbot
          cargo build --release
```

## 🏗️ Building Locally

If you want to build this Docker image locally:

```bash
git clone https://github.com/neuro-ng/deskbot-builder.git
cd deskbot-builder

# Build the image
docker build -t local/deskbot-builder:latest .

# Run the local image
docker run -it --rm local/deskbot-builder:latest
```

## 📚 Resources

* See the deeper architectural details in [deskbot/README.md](deskbot/README.md)
* Learn about the multi-phase deployment in [deskbot/roadmap.md](deskbot/roadmap.md)

## 📄 License

Apache 2.0 — see [deskbot/LICENSE](deskbot/LICENSE) for details.
