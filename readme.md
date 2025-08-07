# Quick and Dirty Instructions

OpenAI's Openweighted model running on Ollama inside a container with another container running open-webui for a chat like ui feel.

## Getting Started

Install Docker if not yet installed.

```bash
docker-compose up                           # wait for the 50 or so Gigs to download. Once completed
<ctrl-c>
docker-compose down
docker-compose up -d
```

Then go to [localhost:3000](http://localhost:3000)
