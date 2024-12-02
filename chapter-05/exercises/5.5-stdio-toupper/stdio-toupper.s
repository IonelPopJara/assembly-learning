    # PURPOSE:      This program converts user input
    #               to an all uppercase letters.
    #

    .section .data

    ####### CONSTANTS #######
msg: .ascii "Please enter your input...\n"
    msg_len =.-msg

msg_ext: .ascii "Thank you for using this program...\n"
    msg_ext_len =.-msg_ext

    # system call numbers
    .equ SYS_WRITE, 4
    .equ SYS_READ, 3
    .equ SYS_CLOSE, 6
    .equ SYS_EXIT, 1

    # standard file descriptors
    .equ STDIN, 0
    .equ STDOUT, 1
    .equ STDERR, 2

    # system call interrupt
    .equ LINUX_SYSCALL, 0x80

    .equ END_OF_FILE, 0 #   This is the return value
    #                       of read which means we've
    #                       hit the end of the file


    .section .bss
    .equ BUFFER_SIZE, 128
    .lcomm BUFFER_DATA, BUFFER_SIZE

    .section .text

    .globl _start
_start:
    ### INITIALIZE PROGRAM ###
    # save the stack pointer
    movl %esp, %ebp

print_initial_message:
    movl $SYS_WRITE, %eax   # Initiate write operation
    movl $STDOUT, %ebx      # File descriptor for STDOUT
    movl $msg, %ecx         # Move the address of our buffer into %ecx
    movl $msg_len, %edx         # Move the address of the length of the buffer into %edx
    int $LINUX_SYSCALL      # System interrupt call

read_input:
    movl $SYS_READ, %eax    # Initiate read operation
    movl $STDIN, %ebx       # File descriptor for STDIN
    movl $BUFFER_DATA, %ecx # Buffer to store input
    movl $BUFFER_SIZE, %edx # Maximum number of bytes to read
    int $LINUX_SYSCALL

transform_message_toupper:
    pushl $BUFFER_DATA  # location of the buffer
    pushl %eax
    call convert_to_upper
    popl %eax
    addl $4, %esp

write_uppercase_message:
    movl $SYS_WRITE, %eax   # Initiate wwrite operation
    movl $STDOUT, %ebx      # File descriptor for STDOUT
    movl $BUFFER_DATA, %ecx # Buffer with the output
    movl $BUFFER_SIZE, %edx # Buffer size
    int $LINUX_SYSCALL

print_exit_message:
    movl $SYS_WRITE, %eax   # Initiate write operation
    movl $STDOUT, %ebx      # File descriptor for STDOUT
    movl $msg_ext, %ecx     # Move the address of our buffer into %ecx
    movl $msg_ext_len, %edx # Move the address of the length of the buffer into %edx
    int $LINUX_SYSCALL      # System interrupt call

exit:
    movl $SYS_EXIT, %eax    # Initiate system exit
    int $LINUX_SYSCALL      # System interrupt call

    # PURPOSE:  This function converts a input buffer
    #           into uppercase letters.
    #
    # INPUT:    The first parameter is the location
    #           of the block of memory to convert.
    #           The second parameter is the length of
    #           that buffer.
    #
    # OUTPUT:   This functions overwrites the current
    #           buffer with the upper-casified version.
    #
    # VARIABLES:
    #           %eax - beginning of the buffer
    #           %ebx - length of the buffer
    #           %edi - current buffer offset
    #           %cl - current byte being examined
    #                   (first part of %ecx)
    #

    ### CONSTANTS ###
    .equ LOWERCASE_A, 'a'
    .equ LOWERCASE_Z, 'z'
    .equ UPPER_CONVERSION, 'A' - 'a'

    ### STACK STUFF ###
    .equ ST_BUFFER_LEN, 8   # Length of the buffer
    .equ ST_BUFFER, 12      # Actual buffer
convert_to_upper:
    # FUNCTION PROLOGUE START
    pushl %ebp
    movl %esp, %ebp
    # FUNCTION PROLOGUE END

    # SET UP VARIABLES
    movl ST_BUFFER(%ebp), %eax
    movl ST_BUFFER_LEN(%ebp), %ebx
    movl $0, %edi

    # If a buffer with zero length was given, exit
    cmpl $0, %ebx
    je end_convert_loop

convert_loop:
    # Get the current byte
    movb (%eax, %edi, 1), %cl

    # go to the next byte unless it is between 'a' and 'z'
    cmpb $LOWERCASE_A, %cl
    jl next_byte
    cmpb $LOWERCASE_Z, %cl
    jg next_byte

    # Otherwise, convert the byte to uppercase
    addb $UPPER_CONVERSION, %cl
    # And store it back
    movb %cl, (%eax, %edi, 1)
next_byte:
    incl %edi       # next byte
    cmpl %edi, %ebx # continue unless we've reached the end
    jne convert_loop

end_convert_loop:
    # no return value, just leave
    movl %ebp, %esp
    popl %ebp
    ret

