section .data

NULL equ 0
progName db "/bin/sh", NULL

section .text
global _start
_start:

mov rax, 59
mov rdi, progName
syscall

last:
  mov rax, 60
  mov rdi, 0
  syscall
