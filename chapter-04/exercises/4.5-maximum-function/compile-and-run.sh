#!/bin/bash

as maximum.s -o maximum.o --32
as main.s -o main.o --32
ld -o main main.o maximum.o -m elf_i386

./main

echo $?

