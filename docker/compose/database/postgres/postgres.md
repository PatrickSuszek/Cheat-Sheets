# Postgres Service
This is an example for a postgres database used in a docker compose application.

The image version is defined in the .env file.
Should no version be defined -18 is used.

## Enviorement File
### Postgres

| Variable | Usage |
| -- | -- |
| POSTGRES_USER | Name of the postgres admin user |
| POSTGRES_PASSWORD | Password of the postgres admin user |
| POSTGRES_DB | Name of the standard database |

### Other Service

| Variable | Usage |
| -- | -- |
| SERVICE_USER | Name of the postgres user used by the service |
| SERVICE_PW | Password of the services postgres users |
| SERVICE_DB | Name of the services database in postgres |


## Volumes
### ./postgres
This volume links to the folder of the compose file.
Thanks to this linking the data of the database isn't lost on compose down or stop.

### init-scripts
This volume holds the init script, which on the first creation of the service creates all users and databases of other services.

Each service needs to implement the four example rows.
The blocks of the services can't be seperated by an empty lane.
Alternatively the psql block can be copy pasted to differntiate between the different services.