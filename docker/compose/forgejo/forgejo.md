# Forgejo
This folder holds a template to host code forge using Forgejo.
It can be used to host code, run Forgejo workflows and use mkdocs documentation.

## Setup
To setup the correct folder structure execute the supplied setup.sh script.
This script will do the following things:

- Create the runner data directory with correct rights, according to Forgejo
- Copy the runner config into the data folder, so it can be used by the container
- Setup the mkdocs sites folder

## Services
### Postgres
The database used by the Forgejo service.

Please see the postgres template at [../database/postgres](../database/postgres/postgres.md) for all information regarding the service configuration.

### Forgejo
The different Forgejo image versions can be found at [codeberg.org/forgejo](https://codeberg.org/forgejo/-/packages/container/forgejo/versions).

#### Enviorement File
This .env file is mostly the same es the .env file of the postgres template at [../database/postgres](../database/postgres/postgres.md).
The only difference is the naming of the database variables, since the naming schema from Forgejo is used, so that no translation or double definition is needed.

| Variable | Usage |
| -- | -- |
| FORGEJO__server__SSH_DOMAIN | Defines the server name for the ssh clone link. Useful if the host is also accessed via ssh. |

#### Enviorement Variables

| Variable | Usage |
| -- | -- |
| USER_UID | User Id to be used, defined by Forgejo |
| USER_GID | Group Id to be used, defined by Forgejo |
| FORGEJO__database__DB_TYPE | Type of the database to be used. |
| FORGEJO__database__HOST | Where to find the database to be used in the docker network. |

#### Volumes
##### ./forgejo
Persistant data storage for the Forgejo instance.

##### /etc/localtime
Default volume link of the Forgejo template.
Used for the server time.

### Docker in Docker
This service is used to execute the docker based workflows of the Forgejo Runner.

#### Command
Default command from the Forgejo Runner documentatio found at [forgejo.org](https://forgejo.org/docs/latest/admin/actions/runner-installation/#oci-image-installation)

#### Volumes
##### ./docs-sites
Directory to store build mkdocs sites, that will be hosted using the Caddy service.
The mkdocs sites will be build using a Forgejo workflow.

### Forgejo Runner
This service enables workflows in the Forgejo instance.
The different Forgejo Runner image versions can be found at [codeberg.org/forgejo](https://code.forgejo.org/forgejo/-/packages/container/runner/versions).


#### Command
This command is used to keep the service alive, till a runner is configured.

```bash
"/bin/sh -c 'while : ; do sleep 1 ; done ;'"
```

This command is used after a runner is configured.
It executes the runner with the suppied config file, if the setup script was used.
To switch to this command follow these steps:

1. Comment out the other command
2. Remove the # from the comment of this command
3. Take this container down
4. Bring up a new instace of this service

```bash
'/bin/sh -c "sleep 5; forgejo-runner --config /data/config.yml daemon"'
```

More information at: [forgejo.org](https://forgejo.org/docs/latest/admin/actions/runner-installation/#oci-image-installation).

#### Volumes
##### ./forgejo-runner
Persistant storage of the runner definition and provider of the user configuration file.

### Caddy
Caddy is a reverse proxy used by this setup to host created mkdocs project documentations.

#### Volumes
##### ./docs-sites
Directory to store build mkdocs sites.
The mkdocs sites will be build using a Forgejo workflow.

## Files
### setup.sh
Script to setup all directories that need manual setup instead of just a volume link.
It furetheremore copies all files needed by the services into their corresponding volume directory.

### runner-config.yml
Configuration file for the Forgejo Runner.
It is pretty much the default configuration for the runner and container section.
The only changes are the runner:SITES_DIR, container:valid_volumes and container:options sections.
Here the /sites directory of the docker in docker service container is allowed to be mounted by container:valid_volumes and is mounted by container:options.
By creating the runner:SITES_DIR enviorement variable the volume is usable by the workflow definition, without worrying about the real volume name changing.

### Caddyfile
Configuration file of the reverse proxy.
It defines a file server that is intended to serve the mkdocs project documentations.
The documentations can be found under:
```
hostname:3001/<Forgejo project path>
```

If the user JohnDoe creates a mkdocs documentation for his project foo the url would be:

```
hostname:3001/JohnDoe/foo
```

## Directories
### init-scripts/
Directory containing the init scripts for the postgres service.

Please see the postgres template at [../database/postgres](../database/postgres/postgres.md) for more information.

### workflows
This directory contains the workflow used to build and publish mkdocs project documentations.

## Notes
To make the usage of the mkdocs documentation easier, their site can be set as the webiste of teh project.