# Commands
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

# User input mocking
```python
from pytest import MonkeyPatch
Test_fun(monkeypatch : MonkeyPatch) :
    Inputs = ["", "", …]
    Monkeypatch.setattr("builtins.input", lambda _: inputs.pop(0))
```