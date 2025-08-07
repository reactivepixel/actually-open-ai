FROM ollama/ollama:latest

# Install system dependencies for AI libraries
RUN apt-get update && apt-get install -y \
    build-essential \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy and set permissions for startup script
COPY container-start.sh /app/container-start.sh
RUN chmod +x /app/container-start.sh

# Override the entrypoint and run the startup script
ENTRYPOINT ["/bin/sh", "/app/container-start.sh"]