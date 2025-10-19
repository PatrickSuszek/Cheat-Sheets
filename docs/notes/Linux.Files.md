---
id: o8rs6j1vlnmnukguim1mefw
title: Files
desc: ''
updated: 1760872301790
created: 1760872200866
---
## Read Segment
Read first X lines of the file
```bash
head -n X <file> 
```

Read last X lines of the file
```bash
tail -n X <file> 
    last X lines of file
```

Read somewhere in the file
```bash
sed -n 'S,Ep' <file>
    -n disable normal print
    p enable print
    S start line number
    E end line number
```

Get the number of rows in the file
```bash
wc -l < <file>
```