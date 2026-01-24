# Docker Commands

```bash
docker ps
```
Lists all active docker containers.
Can be extended with -a to also show stopped containers

```bash
docker logs <container>
```
Shows the log of the given container.
Can be extended with -f to keep the output up to date.

```bash
docker stop <container>
```
Stops the given container.

```bash
docker rm <container>
```
Removes the given container.

```bash
docker exec -it <container> /bin/sh
```
Mount the shell of the defined container in interactive mode.

```bash
docker network create <name>
```
Create a docker network with the given name.
Useful for external networks, that should bridge different compose files.