# Forgejo
## Forgejo Code Forge
This service runs a [Forgejo](https://forgejo.org/) code forge.
A better known code forge is GitHub.

### Service Definition
```yaml
forgejo:
    image: codeberg.org/forgejo/forgejo:13
    container_name: forgejo
    restart: unless-stopped
    depends_on:
      - postgres
    env_file: ".env"
    environment:
      - USER_UID=1000
      - USER_GID=1000
      - FORGEJO__database__DB_TYPE=postgres
      - FORGEJO__database__HOST=postgres:5432
    volumes:
      - ./forgejo:/data
      - /etc/localtime:/etc/localtime:ro
    ports:
      - '3000:3000'
      - '222:22'
    networks:
      - forgejo
```

The different Forgejo image versions can be found at [codeberg.org/forgejo](https://codeberg.org/forgejo/-/packages/container/forgejo/versions).

The network attribute is needed, so that the Forgejo service can communicate with its database.

### Dependencies
This service depends on a database, which in this example is a [postgres](./postgres.md) database, that is part of the compose file.

### .env File
The .env file contains all variables needed by the [postgres service](./postgres.md).
Forgejo has its own variable names for the definition of the database access.

In addition to the database access variables, a variable to define the ssh domain is included.
This is useful if the host is also accessed via ssh, so that an ssh config can distinguish between the host and this service.

```ini
FORGEJO__database__NAME=forgejo
FORGEJO__database__USER=forgejo
FORGEJO__database__PASSWD=password
FORGEJO__server__SSH_DOMAIN=forgejo
```

### Environment
| Variable | Usage |
| -- | -- |
| USER_UID | User Id to be used, defined by Forgejo |
| USER_GID | Group Id to be used, defined by Forgejo |
| FORGEJO__database__DB_TYPE | Type of the database to be used. |
| FORGEJO__database__HOST | Where to find the database to be used in the docker network. |

### Volumes
**./forgejo**

This volume creates a directory at the same level as the compose file, that links to the data directory of the container.
The data directory holds all data of the code forge, so if the services' container is removed and a new one started, it will contain all previous data.

**/etc/localtime**

This volume is one of the default volumes the Forgejo template.

## Forgejo CI CD Runner
This service runs the ci cd pipelines on Forgejos own runner.

### Service Definition
```yaml
forgejo-runner:
    image: data.forgejo.org/forgejo/runner:12
    container_name: forgejo-runner
    user: 1001:1001
    depends_on:
      - forgejo
      - docker-in-docker
    restart: unless-stopped

    # Use a dummy command to keep container alive for first-time registration
    command: "/bin/sh -c 'while : ; do sleep 1 ; done ;'"

    # Real command after the runner is registrated
#    command: '/bin/sh -c "sleep 5; forgejo-runner daemon"'

    environment:
      DOCKER_HOST: tcp://docker-in-docker:2375
    volumes:
      - ./forgejo-runner:/data
    networks:
      - forgejo
    links:
      - docker-in-docker
```

The different Forgejo Runner image versions can be found at [codeberg.org/forgejo](https://code.forgejo.org/forgejo/-/packages/container/runner/versions).

The network attribute is needed, so that the runner can communicate with the docker-in-docker and Forgejo services.

More information at: [forgejo.org](https://forgejo.org/docs/latest/admin/actions/runner-installation/#oci-image-installation).

### Dependencies
**forgejo**

The code forge should be started before the runner is started.

**[docker-in-docker](docker-in-docker.md)**

This service manages the docker containers used to execute the ci cd workflows.

### Command
The first command is used to keep the service alive, till a runner is configured.
```bash
"/bin/sh -c 'while : ; do sleep 1 ; done ;'"
```

The runner can be configured by following these steps.
```bash
Open the containers shell:
docker exec -it forgejo-runner /bin/sh

Run the registration command:
forgejo-runner register

Enter the Forgejo instances url:
http://hostname:3000

Enter the runner token found under
    Site administration -> Actions -> Runners -> Create new runner

Enter the runner name or press enter

Enter lables or press enter

Check output for success
```

Afterwards the service needs to be taken down, the command needs to be switched to the  second one and the service can be restarted with compose up.

```bash
'/bin/sh -c "sleep 5; forgejo-runner --config /data/config.yml daemon"'
```

### Environment
**DOCKER_HOST**

Default setting to communicate with the [docker-in-docker service](docker-in-docker.md).
If a runner config file is used, this variable can be deleted.

### Volumes
**./forgejo-runner**

This volume creates a directory at the same level as the compose file, that links to the data directory of the container.
The data directory holds all data of the ci cd runner.
If a none default configuration should be used, it needs to be added to this directory.

The directory to be linked against needs to be created using these steps.
```bash
set -e

mkdir -p forgejo-runner/.cache

sudo chown -R 1001:1001 forgejo-runner
sudo chmod 775 forgejo-runner/.cache
sudo chmod g+s forgejo-runner/.cache
```

More information at [forgejo.org](https://forgejo.org/docs/latest/admin/actions/runner-installation/#standard-registration)

### Configuration file
To use the configuration file, the second command should be changed to the following.

```bash
/bin/sh -c "sleep 5; forgejo-runner --config /data/config.yml daemon"'
```

For all configuration options see [https://forgejo.org](https://forgejo.org/docs/latest/admin/actions/runner-installation/#configuration).

## Adding mkdocs Documentation Pages
While Forgejo doesn't have a pages feature like GitHub or GitLab it supports setting a website for a project.
This feature can be used to link the build and hosted html page of the mkdocs documentation.

To achieve this a [Caddy service](caddy.md) or another file server service is needed.

### Caddy Configuration
To enable the file server with [Caddy](caddy.md) the Caddyfile should contain the following configuration.

```
:3001 {
    root * /srv/sites
    file_server
}
```

The docker compose service needs to contain the following volume.
This volume is used to persistantly hold the build mkdocs sites.

```yaml
- ./docs-sites:/srv/sites
```

By using this Caddy configuration and configuring the docker-in-docker service and runner the mkdocs sites will be hosted under:

```
hostname:3001/<Forgejo project path>
```

### Service Changes
To be able to add the build mkdocs sites to the persistant storage directory, the ci cd action containers need to know of this directory.
This is achieved by firstly adding a volume mounting this directory to the [docker-in-docker service](docker-in-docker.md).

```yaml
volumes:
    - ./docs-sites:/sites
```

### Runner configuration
Lastly the ci cd action containers need to be allowed to interact with the site volume of the docker-in-docker service.
For this the following configuration file needs to be added to the forgejo-runner directory as config.yml.

```yml
runner:
  # used by workflow for easier directory definition
  envs:
    SITES_DIR: /sites

container:
  options: "--volume /sites:/sites"
  valid_volumes:
    - /sites
  # default setting for communicating with the docker-in-docker service
  docker_host: "tcp://docker-in-docker:2375"
```

### mkdocs Building
Please see the [mkdocs workflow](../../../forgejo/workflows/mkdocs.md).


## Enabling Local Reverse Proxy / SSL
To enable the Forgejo runner to be able to work with a self-signed ca-certificate it needs to be added to the [docker-in-docker](docker-in-docker.md) and runner services.

To add it to the runner the following Dockerfile needs to be used.
```yaml
FROM data.forgejo.org/forgejo/runner:12

USER root

# Install CA tooling
RUN apk update && \
    apk add --no-cache ca-certificates

# Add your Caddy / lab root CA
COPY lab_root.crt /usr/local/share/ca-certificates/lab_root.crt

# Register it system-wide
RUN update-ca-certificates

USER 1001
```

Exchange the image attribute from the docker compose service definition for these lines.
```yaml
build:
  context: .
  dockerfile: Dockerfile.runner
```
Here the Dockerfile is in the same directory as the compose file and is named Dockerfile.runner.

For the docker in docker service, the following volumes need to be added.
```yaml
- ./lab_root.crt:/usr/local/share/ca-certificates/lab_root.crt:ro
- ./lab_root.crt:/etc/ssl/certs/lab_root.crt
```

Furthermore, the certificate needs to be added to the spawned action containers.
This can be achieved by setting the following settings to the config file of the runner.
```yaml
container:
    options: "--volume /usr/local/share/ca-certificates/caddy-root.crt:/usr/local/share/ca-certifica>
        --volume /etc/ssl/certs/caddy-root.crt:/etc/ssl/certs/caddy-root.crt:ro"

    valid_volumes:
        - /sites
        - /usr/local/share/ca-certificates/caddy-root.crt
        - /etc/ssl/certs/caddy-root.crt
```

### No DNS
If no local dns can be used, then the hostname needs to be resolved using docker.

The [docker-in-docker](docker-in-docker.md) and runner servies need to be extended for the following attribute definition.
```yaml
extra_hosts:
    - "<forgejo instance hostname>:<hosts ip adress>"

# Example
extra_hosts:
    - "forgejo.pi:192.168.1.1"
```

The same needs to be done in the runner configuration.
```yaml
container:
    options: "--add-host forgejo.pidragon:192.168.2.10"
```

### Local DNS
If a local dns service is in use it can be, that docker won't find the apk servers to get the certificate tools.
To tell docker which dns to use create the following file.
```bash
sudo nano /etc/docker/daemon.json
```

And add this configuration for the google and cloudeflare dns servers.
```json
{
  "dns": ["8.8.8.8", "1.1.1.1"]
}
```