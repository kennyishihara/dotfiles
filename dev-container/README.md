# Development Environment Container

Personalized development environment to use in remote servers like Runpod.ai.

# Build

```shell
docker build --platform=<remote platform architecture> -t <image name> . 

# Push to registry like dockerhub. Make sure you are signed in via cli first.
docker push <image name>
```

Then link your registry credential and repo to remote server.

# Using locally as portable dev environment

```shell
docker build --platform=<remote platform architecture> -t <image name> . 
docker run -di <image name>
# check for container id
docker ps
docker exec -it <container id> zsh
```
