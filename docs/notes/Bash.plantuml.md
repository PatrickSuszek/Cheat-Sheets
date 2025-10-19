---
id: q46ehjn9swzg7ssmwt7qmf7
title: plantuml
desc: ''
updated: 1760872818364
created: 1760872793604
---
## Short Application Call
```bash
export PLANTUML_JAR="<path to the jar>"
alias plantuml="java -Dfile.encoding=UTF-8 -jar $PLANTUML_JAR"
```

## Convert to svg
Exports all .puml files in the current directory as svg files to a sub folder called svg.
```bash
puml2svg() {
  if [ -z "$1" ]; then
    plantuml -tsvg *.puml -o svg/
  else
    plantuml -tsvg "$1" -o svg/
  fi
}
```

## Create empty Plantuml file with default design values
```bash
tpuml() {
    local prefix=""  # Default prefix is empty
    local filenames=()  # Array to hold actual filenames

    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -s|--s)
                if [[ -n "$2" && "$2" != -* ]]; then
                    prefix="$2"
                    shift 2  # Consume -s and its value
                else
                    echo "Error: -s requires a prefix argument"
                    return 1
                fi
                ;;
            -*)
                echo "Unknown option: $1"
                return 1
                ;;
            *)
                filenames+=("$1")  # Collect filenames
                shift
                ;;
        esac
    done

    # Check if we have filenames to process
    if [[ ${#filenames[@]} -eq 0 ]]; then
        echo "Missing filename - Usage: tpuml [-s prefix] <filename> [filename2 ...]"
        return 1
    fi

    # Loop through filenames and create .puml files
    for filename in "${filenames[@]}"; do
        full_filename="${prefix}${filename}.puml"

        # Create and write to the .puml file
        {
            echo "@startuml ${prefix}${filename}"
            echo "skinparam BackgroundColor lightgray"
            echo "@enduml"
        } > "$full_filename"
    done
}
```

### Options
- -s <string> : Prepends the given string to every filename of the files to be created