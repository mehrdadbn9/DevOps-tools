#!/bin/bash

# Define the sa function
sa() {
    pre=:
    post=:
    printf "$pre%s$post\n" "$@"
}

# Assign the variable var
var=

# Check if an argument is provided
if [ -n "$1" ]; then
    # Evaluate the argument and pass it to sa
    sa "$1"
else
    echo "No argument provided"
fi

#./sa.sh "${var:3:2}"

