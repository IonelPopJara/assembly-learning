    # PURPOSE:      This program tests the use of
    #               STDIN and STDOUT.

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

print_exit_message:
    movl $SYS_WRITE, %eax   # Initiate write operation
    movl $STDOUT, %ebx      # File descriptor for STDOUT
    movl $msg_ext, %ecx     # Move the address of our buffer into %ecx
    movl $msg_ext_len, %edx # Move the address of the length of the buffer into %edx
    int $LINUX_SYSCALL      # System interrupt call

exit:
    movl $SYS_EXIT, %eax    # Initiate system exit
    int $LINUX_SYSCALL      # System interrupt call

