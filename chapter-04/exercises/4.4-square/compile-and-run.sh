#!/bin/bash

as square.s -o square.o --32
as main.s -o main.o --32
ld -o main main.o square.o -m elf_i386

./main

echo $?

