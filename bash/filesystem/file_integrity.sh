#!/bin/bash
file="/path/to/file"
checksum=$(md5sum "$file" | awk '{print $1}')
if [ "$checksum" == "expected_checksum" ]; then
    echo "File integrity verified"
else
    echo "File integrity compromised"
fi