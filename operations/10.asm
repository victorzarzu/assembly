section .data

EXIT_SUCCESS equ 0
SYS_exit equ 0

n dq 1234
rev dq 0

section .text
global _start
_start:

revers:
  mov rax, qword [n]
  mov rbx, 10
  mov rdx, 0
  div rbx
  mov qword [n], rax
  mov rcx, rdx
  mov rax, qword [rev]
  mul rbx
  add rax, rcx 
  mov qword [rev], rax
  cmp qword [n], 0
  je ext
  jmp revers

ext:

last:
  mov rax, SYS_exit
  mov rdi, EXIT_SUCCESS
  syscall
