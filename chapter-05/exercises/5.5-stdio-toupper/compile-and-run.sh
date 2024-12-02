#!/bin/bash

as stdio-toupper.s -o stdio-toupper.o --32
ld stdio-toupper.o -o stdio-toupper -m elf_i386
./stdio-toupper

