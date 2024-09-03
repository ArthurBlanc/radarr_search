# Radarr Search Trigger

This project contains a Python script that triggers a search for missing movies on multiple Radarr instances. The script is scheduled to run every hour at 30 minutes past the hour using cron in a Docker container.

## Setup Instructions

### Prerequisites

- Docker
- Docker Compose (optional)

### Build the Docker Image

First, build the Docker image using the provided `Dockerfile`.

```bash
docker build -t your_image_name .
