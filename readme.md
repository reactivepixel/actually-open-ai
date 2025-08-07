# Quick and Dirty Instructions

OpenAI's Openweighted model running on Ollama inside a container with another container running open-webui for a chat like ui feel.

## Getting Started

Prereqs:

- Using an nvidia GPU (optional - will fall back to CPU if not available)
- [Docker](https://www.docker.com/products/docker-desktop/)
- Make (usually pre-installed on Linux/Mac)

```bash
make start                                               # First run: sets up NVIDIA Docker + starts containers
                                                        # Subsequent runs: just starts containers
                                                        # Wait for the 13+ GB download to complete
```

Then go to [localhost:3000](http://localhost:3000)

## Available Commands

```bash
make help      # Show all available commands
make start     # Start containers (setup NVIDIA on first run)
make stop      # Stop containers
make status    # Show container status
make logs      # Show container logs
make purge     # Remove all project containers/images/volumes
make nuclear   # ⚠️  Remove ALL Docker resources (affects other projects)
```
