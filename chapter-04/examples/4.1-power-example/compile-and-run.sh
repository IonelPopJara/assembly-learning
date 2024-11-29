#!/bin/bash

as power.s -o power.o --32
ld power.o -o power -m elf_i386
./power
echo $?
