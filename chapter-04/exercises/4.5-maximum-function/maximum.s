    # PURPOSE:  This file contains a function that returns the
    #           maximum value of a set of data items.

    .section .text

    .globl maximum       # Symbol to call the function
maximum:
    # FUNCTION PROLOGUE START
    pushl %ebp          # Push the old base pointer
    movl %esp, %ebp     # Make the base pointer point to what the stack pointer points to
    # FUNCTION PROLOGUE END
    movl 8(%ebp), %eax  # Move the address of the array into %eax
    movl $0, %edi       # Move 0 into the index register
    movl (%eax, %edi, 4), %edx   # Assign the first item to %edx
    movl %edx, %ebx     # Assign current biggest to %ebx
start_loop:
    cmpl $0, %edx       # Check if we've hit the end
    je exit_loop
    incl %edi           # load next value
    movl (%eax, %edi, 4), %edx
    cmpl %ebx, %edx     # Compare values
    jle start_loop
    # If it is bigger
    movl %edx, %ebx     # Assign the current value as the largest
    jmp start_loop
exit_loop:
    movl %ebx, %eax
    # FUNCTION EPILOGUE START
    movl %ebp, %esp
    popl %ebp
    ret
    # FUNCTION EPILOGUE END

