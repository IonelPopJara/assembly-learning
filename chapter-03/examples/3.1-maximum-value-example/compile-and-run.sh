#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <input_file>"
    exit 1
fi

input_file=$1

as "$input_file.s" -o "$input_file.o"
ld "$input_file.o" -o "$input_file"
./"$input_file"
echo $?
