# Base image minimal
FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential curl git wget tar zip bc && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /xcb

# Copy semua file repo
COPY . /xcb/

# Pastikan miner script executable
RUN chmod +x mine.updated.sh

# Default command
CMD ["./mine.updated.sh"]
