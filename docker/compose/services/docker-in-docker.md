# Docker-in-Docker (dind)
The dind service is used to run docker containers in docker containers.
This is useful for ci cd pipelines, since with this the user spawned action containers shouldn't be able to interact with the host system.

## Service Definition
```yaml
docker-in-docker:
    image: docker:dind
    container_name: dind
    command: ["dockerd", "-H", "tcp://0.0.0.0:2375", "--tls=false"]
    privileged: true
    restart: unless-stopped
    networks:
      - my_network
```

The network attribute is needed, so that the other services can communicate with this service to spawn new docker containers.

## Command
Default command to enable tcp communication.

This communication channel can be used by a ci cd runner to spawn docker containers.