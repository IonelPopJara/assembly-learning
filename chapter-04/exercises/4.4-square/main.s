    # PURPOSE: Main program to test the square function
    .section .data
    # No data is needed
    .section .text

    .globl _start # Symbol to start the program
_start:
    pushl $6        # Add 4 as our parameter for the function
    call square
    addl $4, %esp
    movl %eax, %ebx
    movl $1, %eax
    int $0x80
