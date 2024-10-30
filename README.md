# TiddlyWiki Docker Deployment

This documentation provides a guide for deploying TiddlyWiki using the Docker image `sdevch/tiddlywiki`. This image allows you to run TiddlyWiki, a non-linear personal web notebook, as a Docker container, simplifying the setup and ensuring consistent environments.

## Overview
- **TiddlyWiki**: A flexible tool for personal note-taking, task management, and documentation.
- **Docker**: A platform for developing, shipping, and running applications in containers.

## Features
- **Automated Deployment**: Quickly deploy TiddlyWiki with the official Docker image.
- **Persistent Storage**: TiddlyWiki data is stored using Docker volumes to ensure data persistence.
- **Customizable Configuration**: Modify environment variables for tailored TiddlyWiki settings.

## Prerequisites
Before deploying TiddlyWiki, ensure you have Docker installed on your machine. Follow the [official installation guide](https://docs.docker.com/get-docker/) to install Docker for your operating system.

## Quick Start with Docker

1. **Pull the Docker image**:
   Open a terminal and run the following command to pull the TiddlyWiki image:
   ```bash
   docker pull sdevch/tiddlywiki_last
   ```

2. **Run the TiddlyWiki container**:
   Execute the following command to start a new container with TiddlyWiki:
   ```bash
   docker run -d -p 8080:8080 -e USERNAME=your_username -e PASSWORD=your_password --name tiddlywiki_instance sdevch/tiddlywiki:latest
   ```
   Replace `your_username` and `your_password` with your desired credentials.

3. **Access TiddlyWiki**:
   Open a web browser and navigate to [http://localhost:8080](http://localhost:8080). You should see the TiddlyWiki interface.

## Environment Variables
You can customize the TiddlyWiki configuration by setting the following environment variables when running the Docker container:
- `USERNAME`: The username for accessing the wiki (default: `"anonymous"`).
- `PASSWORD`: The password for accessing the wiki (default: empty).
- `WIKI_NAME`: The name of your TiddlyWiki (default: `"mywiki"`).
- `PORT`: The port on which TiddlyWiki will run (default: `8080`).
- `HOST`: The host IP address (default: `"0.0.0.0"`).

## Data Storage
TiddlyWiki stores its data in a Docker volume named `tiddlywiki_data`. This volume is mounted at `/var/lib/tiddlywiki` inside the container. The use of Docker volumes ensures that:
- Your data persists across container restarts and updates.
- You can easily back up your TiddlyWiki data by exporting the Docker volume.

To back up your data, use the following command:
```bash
docker run --rm -v tiddlywiki_data:/data busybox tar czf /backup/tiddlywiki_backup.tar.gz -C /data .
```
Replace `/backup/tiddlywiki_backup.tar.gz` with your desired backup path.

## Stopping and Removing the Container
To stop or remove the TiddlyWiki container, use the following commands:
```bash
docker stop tiddlywiki_instance
docker rm tiddlywiki_instance
```

## Troubleshooting
- Ensure Docker is running and you have sufficient permissions to execute Docker commands.
- Check the logs of the running container if you encounter issues:
  ```bash
  docker logs tiddlywiki_instance
  ```

## License
This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments
Thanks to [TiddlyWiki](https://tiddlywiki.com) for this powerful personal wiki system and to the Docker community for their support and tools that facilitate deployment.
