#!/bin/bash
## Trim leading and trailing white-space from string
```bash
trim_string() {
    # Usage: trim_string "   example   string    "
    : "${1#"${1%%[![:space:]]*}"}"
    : "${_%"${_##*[![:space:]]}"}"
    printf '%s\n' "$_"
}
```

## Trim all white-space from string and truncate spaces