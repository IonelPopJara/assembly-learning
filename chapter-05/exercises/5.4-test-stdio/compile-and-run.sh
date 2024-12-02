#!/bin/bash

as stdio-test.s -o stdio-test.o --32
ld stdio-test.o -o stdio-test -m elf_i386
./stdio-test
