    # PURPOSE:  This expands on the previous power example to add
    #           the capability of calculating the power of 0.
    #
    #           Anything to the power of 0 is 1.
    .section .data
    # No data since everything is in the main program
    .section .text

    .globl _start # Symbol to start the program
_start:
    pushl $0        # Push second argument (power)
    pushl $6        # Push first argument (base)

    call power      # Call the function

    movl %eax, %ebx # The return value of power is stored in
                    # %eax, therefore, we move that to %ebx
                    # so our program can return this data.

    movl $1, %eax   # exit (%ebx is returned)
    int $0x80

power:
    # FUNCTION PROLOGUE START
    pushl %ebp              # Save old base pointer
    movl %esp, %ebp         # Make stack pointer the base pointer
    # FUNCTION PROLOGUE END
    subl $4, %esp           # Make space for the local variable `res`

    movl 8(%ebp), %ebx      # Put the `base` in %eax
    movl 12(%ebp), %ecx     # Put the `power` in %eax

    movl $1, -4(%ebp)       # Initialize `res` as 1

power_loop_start:
    cmpl $0, %ecx           # If `power` is less or equal to zero
    jle end_power           # break the loop
    movl -4(%ebp), %eax     # Move result into %eax
    imull %ebx, %eax        # `res` = `res` * `base`
    movl %eax, -4(%ebp)     # store our result back in `res`
    decl %ecx               # `pow` = `pow` - 1
    jmp power_loop_start    # jump back to the start of the loop

end_power:
    movl -4(%ebp), %eax     # return value goes in %eax
    # FUNCTION EPILOGUE START
    movl %ebp, %esp         # restore the stack pointer to ebp
    popl %ebp               # restore the base pointer
    ret
    # FUNCTION EPILOGUE START

