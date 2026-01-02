# The extensions.json File
This file is located in the .vscode/ folder and is used to recommend extensions to the user.
It can furetheremore be used to disable recommendations for specific extensions.

All recommendations were created on Garuda Linux.

## Json Example
```json
{
  "recommendations": [
    "publisher_1.extensionname_1",
    ...
    "publisher_n.extensionname_n"
  ],
  "unwantedRecommendations": [
    ...
  ]
}
```

## Export Help
```bash
codium --list-extensions --profile <name>
```
This command can be used to get the extensions of the selected profile.
