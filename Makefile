.PHONY: help start stop purge setup-nvidia status

# Default target
help:
	@echo "Available commands:"
	@echo "  make start     - Setup NVIDIA Docker (first run) and start containers"
	@echo "  make stop      - Stop all containers"
	@echo "  make purge     - Stop and remove all containers, images, volumes, networks"
	@echo "  make status    - Show container status"
	@echo "  make logs      - Show container logs"

# Start containers (runs NVIDIA setup on first run)
start:
	@if [ ! -f .nvidia-setup-done ]; then \
		echo "🔧 First run detected - setting up NVIDIA Docker support..."; \
		./run-first.sh && touch .nvidia-setup-done; \
	fi
	@echo "🚀 Starting containers..."
	docker-compose up -d
	@echo "✅ Containers started! Visit http://localhost:3000"

# Stop containers
stop:
	@echo "🛑 Stopping containers..."
	docker-compose down
	@echo "✅ Containers stopped"

# Purge everything related to this project
purge:
	@echo "🧹 Stopping and removing containers..."
	docker-compose down --volumes --remove-orphans || true
	@echo "🗑️  Removing project images..."
	-docker rmi $$(docker images -q --filter reference="gpt-*") 2>/dev/null || true
	-docker rmi ollama/ollama:latest 2>/dev/null || true
	-docker rmi ghcr.io/open-webui/open-webui:main 2>/dev/null || true
	@echo "🗑️  Removing build cache..."
	-docker builder prune -f 2>/dev/null || true
	@echo "🧹 Removing setup marker..."
	-rm -f .nvidia-setup-done 2>/dev/null || true
	@echo "✅ Purge complete!"

# Show container status
status:
	@echo "📊 Container Status:"
	@docker-compose ps 2>/dev/null || echo "No containers running"

# Show container logs
logs:
	@echo "📜 Container Logs:"
	docker-compose logs --tail=50

# Nuclear option - remove ALL Docker resources (use with caution)
nuclear:
	@echo "☢️  WARNING: This will remove ALL Docker containers, images, networks, and volumes!"
	@echo "This affects ALL projects, not just this one."
	@read -p "Are you sure? (type 'yes' to continue): " confirm && [ "$$confirm" = "yes" ]
	docker system prune -a --volumes -f
	@echo "☢️  Nuclear cleanup complete!"
