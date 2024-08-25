#!/bin/bash

isvalidip() #@ USAGE: isvalidip DOTTED-QUAD
{
  case $1 in
    "" | *[!0-9.]* | *[!0-9]) return 1 ;; # Rejects invalid input patterns
  esac

  local IFS=.
  set -- $1
  [ $# -eq 4 ] && # Ensures four parameters
  [ ${1:-666} -le 255 ] && [ ${2:-666} -le 255 ] && # Validates each octet
  [ ${3:-666} -le 255 ] && [ ${4:-666} -le 255 ]
}

# Example usage:
if isvalidip "$1"; then
  echo "$1 is a valid IPv4 address."
else
  echo "$1 is NOT a valid IPv4 address."
fi


