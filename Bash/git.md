# Open git remote in the browser
## Windows
```bash
alias git-open='explorer "$(git remote get-url origin | sed -E "s|git@([^:]+):|https://\1/|;s|\.git$||")"'
```
In wsl add .exe to the explorer call