section .data

STDOUT equ 1
SYS_write equ 1
SYS_exit equ 60
LF equ 10
NULL equ 0

newline db LF, NULL
msg1 db "Hello World", LF, NULL
len1 dq $ - msg1 - 1 
msg2 db "Hello Onesti", LF, NULL
len2 dq $ - msg2 - 1
msg3 db "I am in Greece", LF, NULL
len3 dq $ - msg3 - 1

section .text

global printString
printString:

mov rax, SYS_write
mov rdi, STDOUT
syscall

ret


global _start
_start:

mov rsi, msg1
mov rdx, qword [len1]
call printString

mov rsi, msg2
mov rdx, qword [len2]
call printString

mov rsi, msg3
mov rdx, qword [len3]
call printString



last:
  mov rax, SYS_exit
  mov rdi, 0 
  syscall

