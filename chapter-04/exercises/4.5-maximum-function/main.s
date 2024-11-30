    # PURPOSE:  This program provides three data lists and returns
    #           the maximum value of the last list as the exit
    #           status code.

    .section .data
list1:  .long 3, 67, 34, 223, 45, 75, 54, 34, 44, 33, 22, 11, 66, 0
list2:  .long 2, 5, 32, 10, 64, 0
list3:  .long 121, 2, 3, 52, 100, 0

    .section .text
    .globl _start
_start:
    # Call maximum for the first list
    leal list1, %eax     # Get the address of the first element of list1
    pushl %eax          # Push the address of the first element to the stack
    call maximum
    addl $4, %esp       # Clean the stack

    # Call maximum for the second list
    leal list2, %eax
    pushl %eax
    call maximum
    addl $4, %esp       # Clean the stack

    # Call maximum for the third list
    leal list3, %eax
    pushl %eax
    call maximum
    addl $4, %esp       # Clean the stack

    # Finish the program's execution
    movl %eax, %ebx
    movl $1, %eax
    int $0x80

