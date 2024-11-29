    # PURPOSE: This file has a function to calculate the square of a number.
    #
    #           The square of a number `x` is defined as `x` * `x`.
    .section .data
    # No additional data is needed
    .section .text

    .globl _start       # Symbol to start the program
_start:
    pushl $4            # Push `x` - the number we want to square
    call square         # Call the square function
    movl %eax, %ebx     # Move %eax - the return value of the function -
                        # into %ebx - the return value of the program -.
    movl $1, %eax       # Syscall for exit (%ebx is returned)
    int $0x80
square:
    # FUNCTION PROLOGUE START
    pushl %ebp          # Push the base pointer (old ebp)
    movl %esp, %ebp     # Make the base pointer point to the stack pointer
    # FUNCTION PROLOGUE END

    movl 8(%ebp), %eax  # Move our argument into %eax
    imul %eax, %eax     # Multiply %eax * %eax

    # FUNCTION EPILOGUE START
    movl %ebp, %esp
    popl %ebp
    ret
    # FUNCTION EPILOGUE END

