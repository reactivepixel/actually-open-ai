FROM ollama/ollama:latest

# Install system dependencies for AI libraries
RUN apt-get update && apt-get install -y \
    build-essential \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy and set permissions for startup script
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Override the entrypoint and run the startup script
ENTRYPOINT ["/bin/sh", "/app/start.sh"]