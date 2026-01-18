# Planka
Planka is a kanban board application, that can be used to structure tasks in projects.
Please see [https://planka.app/](https://planka.app/) for more information to the project and [https://docs.planka.cloud/docs/welcome/](https://docs.planka.cloud/docs/welcome/) for the installation documentation.

An example planka board can be found at [https://plankanban.github.io/planka/#/boards/745664150193046535](https://plankanban.github.io/planka/#/boards/745664150193046535).


## Enviorement File
### Docker Compose

| Variable | Usage |
| -- | -- |
| MY_HOST | Name of the host |
| PLANKA_PORT | Port where the planka container should be exposed |

### Postgres
Please see the postgres template at [../database/postgres](../database/postgres/postgres.md).

### Postgres Planka
This section implements the other service section mentioned in the postgres template at [../database/postgres](../database/postgres/postgres.md).

### Planka Admin
These variables are used to set the variables used by planka to create the first admin of the application.

| Variable | Usage |
| -- | -- |
| PLANKA_ADMIN_MAIL | Mail of the admin user |
| PLANKA_ADMIN_PW | Password of the admin user |
| PLANKA_ADMIN_NAME | Legal name of the admin |
| PLANKA_ADMIN_USER | Username of the admin |

## Volumes
### ./planka/*
These volumes link the user data to make it persistent for compose downs or stops.

## init-scripts/
Holds the init scripts for the postgres service.
For more information see [../database/postgres](../database/postgres/postgres.md).