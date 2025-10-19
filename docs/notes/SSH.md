---
id: 8a9thixj4nr90t1wb385m67
title: SSH
desc: ''
updated: 1760873228131
created: 1760873032032
---
## 1 Key per Service
With a .ssh/config file different keys can be used for different services.
```bash
Host *
IdentitiesOnly yes

Host github.com
HostName github.com
User git
IdentityFile ~/.ssh/github
```
### Notes
- The referenced identity file is the private key
- If a host has multiple services add the "Port X" parameter, where X is the port of the service
  - 22 is the standard ssh port