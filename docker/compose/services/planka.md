# Planka
The [Planka](https://planka.app/) service provides a kanban board, that can be used to structure tasks in projects.

More information to the deployment with docker and other installation methods are listed in the [official documentation](https://docs.planka.cloud/docs/welcome/) for the installation documentation with an [offical example](https://plankanban.github.io/planka/#/boards/745664150193046535).

## Service Definition
```yaml
planka:
    image: ghcr.io/plankanban/planka:2.0.0-rc.4
    container_name: planka
    restart: unless-stopped
    depends_on:
      - postgres
    env_file:
      - .env
    environment:
      - DATABASE_URL=postgres://${POSTGRES_PLANKA_USER}:${POSTGRES_PLANKA_PW}@postgres:5432/${POSTGRES_PLANKA_DB}
      - BASE_URL=http://${MY_HOST}:${PLANKA_PORT}
      - SECRET_KEY=notsecretkey
      - SOCKET_ALLOWED_ORIGINS=http://${MY_HOST}:${PLANKA_PORT}
      - DEFAULT_ADMIN_EMAIL=${PLANKA_ADMIN_MAIL}
      - DEFAULT_ADMIN_PASSWORD=${PLANKA_ADMIN_PW}
      - DEFAULT_ADMIN_NAME=${PLANKA_ADMIN_NAME}
      - DEFAULT_ADMIN_USERNAME=${PLANKA_ADMIN_USER}
    volumes:
      - ./planka/favicons:/app/public/favicons
      - ./planka/user-avatars:/app/public/user-avatars
      - ./planka/background-images:/app/public/background-images
      - ./planka/attachments:/app/private/attachments
    ports:
      - '${PLANKA_PORT}:1337'
    networks:
      - my_network
```

The network attribute is needed, so that the Planka service can communicate with its database.

## Dependencies
This service depends on a database, which in this example is a [postgres](./postgres.md) database, that is part of the compose file.

## .env File
```ini
# service url definition
MY_HOST=hostname
PLANKA_PORT=port

# postgres config - see postgres service
POSTGRES_USER=postgres
POSTGRES_PW=password_1
POSTGRES_DB=postgres

# postgres planka user config - see postgres service
POSTGRES_PLANKA_USER=planka
POSTGRES_PLANKA_DB=planka
POSTGRES_PLANKA_PW=password_2

# Planka admin config
PLANKA_ADMIN_MAIL=user@service
PLANKA_ADMIN_PW=password_3
PLANKA_ADMIN_NAME="John Doe"
PLANKA_ADMIN_USER=John
```

| Variable | Usage |
| -- | -- |
| PLANKA_ADMIN_MAIL | Mail of the admin user |
| PLANKA_ADMIN_PW | Password of the admin user |
| PLANKA_ADMIN_NAME | Legal name of the admin |
| PLANKA_ADMIN_USER | Username of the admin |

## Volumes
**./planka**

This volume creates a directory at the same level as the compose file, that links to the data directories of the container.
The data directories hold all user generated data.

