# Postgres
The [Postgres](https://www.postgresql.org/) service is a database.

## Service Definition
```yaml
postgres:
    image: postgres:18
    container_name: postgres
    restart: unless-stopped
    env_file:
      - .env
    ports:
      - "5432:5432"
    volumes:
      - ./postgresql:/var/lib/postgresql
      - ./init-scripts:/docker-entrypoint-initdb.d:ro
    networks:
        - my_network
```

The network attribute is only needed, if other containers should use the docker network to communicate with the database.
This is the standard case in a docker compose.

## .env File
The following variables are used by the Postgres service to create the standard admin account and the default database.

```ini
POSTGRES_USER=postgres
POSTGRES_PASSWORD=password_1
POSTGRES_DB=postgres
```

## Volumes
**./postgresql:/var/lib/postgresql**

This volume creates a directory at the same level as the compose file, that links to the data directory of the container.
The data directory holds all data of the database, so if the services' container is removed and a new one started, it will contain all previous data.

**./init-scripts:/docker-entrypoint-initdb.d:ro**

This volume links the init-scripts directory into the services container.
All scripts contained in this directory will be executed on the creation of the service.

This only happens if the ./postgresql directory is empty / doesn't exist.

### init-scripts
#### Create Users and Databases
By adding this script to the ./init-scripts directory the database will create a user and a database for a service.
The used variables need to be defined in the .env file of the service.

```bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
	CREATE DATABASE ${SERVICE_DB};
	CREATE USER ${SERVICE_USER} WITH PASSWORD '${SERVICE_PW}';
	ALTER DATABASE ${SERVICE_DB} OWNER TO ${SERVICE_USER};
	GRANT ALL PRIVILEGES ON DATABASE ${SERVICE_DB} TO ${SERVICE_USER};
EOSQL
```

Every service should have its own user with a different password.
To create multiple users and databases with this script either extend the psql block for a adjusted copy of the example, without any empty line, or copy and adjust the whole psql block.

##### .env Extension
Exchange SERVICE_ for the name of the service.
Also note that some services have their own environment variables for these things.
These can either be filled in using the variables of the .env, or they can be directly defined in the .env.
```ini
SERVICE_USER=name
SERVICE_PW=password_X
SERVICE_DB=service_db
```
