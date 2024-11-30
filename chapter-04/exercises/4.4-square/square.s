    # PURPOSE: This file has a function to calculate the square of a number.
    #
    #           The square of a number `x` is defined as `x` * `x`.
    .section .text

    .globl square       # Symbol to start the program
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

