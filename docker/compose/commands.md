# Docker Compose Commands
All commands are either executable if the user is part of the docker group or using su rights.
Ever command listed here acts on every service in the compose file.

Starting all services in detached mode.
```bash
socker compose up -d
```

Stopping all services.
```bash
socker compose stop
```

Stopping and removing all services.
```bash
socker compose up -d
```