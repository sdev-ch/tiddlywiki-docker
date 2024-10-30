#!/bin/bash
# deploy.sh
# Script to automate the build and deployment of TiddlyWiki in Docker

set -e  # Exit on error

# Configuration (modify as needed)
IMAGE_NAME="sdevch/tiddlywiki:lastest"  # Default image from Docker Hub
CONTAINER_NAME="tiddlywiki_instance"
WIKI_NAME="${WIKI_NAME:-mywiki}"  # Default wiki name if not set
PORT="${PORT:-8080}"              # Default port if not set
NODE_MEM="${NODE_MEM:-256}"       # Memory limit for Node.js (in MB)

# Check for user input to choose the image
if [[ "$1" == "local" ]]; then
  IMAGE_NAME="tiddlywiki:latest"  # Use the local image if "local" is specified
  echo "Using local image: $IMAGE_NAME"
else
  echo "Using Docker Hub image: $IMAGE_NAME"
fi

# Step 1: Build the Docker image if using local
if [[ "$1" == "local" ]]; then
  echo "Building Docker image: $IMAGE_NAME..."
  docker build -t "$IMAGE_NAME" .
fi

# Step 2: Stop and remove existing container if it exists
if docker ps -a --format '{{.Names}}' | grep -Eq "^${CONTAINER_NAME}\$"; then
  echo "Stopping and removing existing container: $CONTAINER_NAME"
  docker stop "$CONTAINER_NAME" && docker rm "$CONTAINER_NAME"
fi

# Step 3: Run a new container
echo "Deploying TiddlyWiki container: $CONTAINER_NAME"
docker run -d --name "$CONTAINER_NAME" \
  -p "$PORT":8080 \
  -e WIKI_NAME="$WIKI_NAME" \
  -e PORT="$PORT" \
  -e NODE_MEM="$NODE_MEM" \
  -v tiddlywiki_data:/var/lib/tiddlywiki \
  "$IMAGE_NAME"

# Step 4: Display success message with access instructions
echo "TiddlyWiki deployed successfully!"
echo "Access it at: http://localhost:$PORT"

# Step 5: Follow logs (optional)
echo "Following logs. Press Ctrl+C to exit."
docker logs -f "$CONTAINER_NAME"
