---
id: a1d16jr15pjk85gsquucwou
title: Pytest
desc: ''
updated: 1760872026905
created: 1760871879990
---
## Commands
Execution
```bash
pytest
python -m pytest
```
Execute ordered tests
```bash
pytest --order-scope=class
```
Create coverage report
```bash
pytest --cov
```

## User input mocking
```python
from pytest import MonkeyPatch
Test_fun(monkeypatch : MonkeyPatch) :
    Inputs = ["", "", …]
    Monkeypatch.setattr("builtins.input", lambda _: inputs.pop(0))
```