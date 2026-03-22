# syntax=docker/dockerfile:1

FROM rust:1-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    pkg-config \
    libssl-dev \
    # Deskbot build dependencies
    build-essential \
    libdbus-1-dev \
    libx11-dev \
    libasound2-dev \
    # Headless X11 and utilities
    xvfb \
    x11-utils \
    # Input simulation
    xdotool \
    xclip \
    # UI Automation and Accessibility
    at-spi2-core \
    libatk-adaptor \
    # Applications needed for E2E scenarios
    libreoffice \
    gedit \
    xterm \
    # Utilities for fetching chrome
    curl \
    ca-certificates \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

# Install Google Chrome (amd64) or Chromium (arm64)
ARG TARGETARCH
RUN if [ "$TARGETARCH" = "amd64" ] || [ -z "$TARGETARCH" ]; then \
        curl -fsSL https://dl.google.com/linux/linux_signing_key.pub \
          | gpg --dearmor -o /usr/share/keyrings/google-chrome.gpg \
        && echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] \
                 http://dl.google.com/linux/chrome/deb/ stable main" \
             > /etc/apt/sources.list.d/google-chrome.list \
        && apt-get update \
        && apt-get install -y --no-install-recommends google-chrome-stable \
        && rm -rf /var/lib/apt/lists/* ; \
    else \
        apt-get update \
        && apt-get install -y --no-install-recommends chromium \
        && rm -rf /var/lib/apt/lists/* ; \
    fi

WORKDIR /build
