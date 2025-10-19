---
id: uv1e0h07265fefsrqr3vq88
title: git
desc: ''
updated: 1760872802289
created: 1760872788678
---
## Open git remote in the browser
### Windows
```bash
alias git-open='explorer "$(git remote get-url origin | sed -E "s|git@([^:]+):|https://\1/|;s|\.git$||")"'
```
In wsl add .exe to the explorer call