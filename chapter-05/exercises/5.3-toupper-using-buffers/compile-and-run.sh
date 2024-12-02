#!/bin/bash

as toupper.s -o toupper.o --32
ld toupper.o -o toupper -m elf_i386
./toupper toupper.s toupper.uppercase
