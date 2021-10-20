section .data

EXIT_SUCCESS equ 0
SYS_exit equ 0

n dq 30
sum ddq 0

section .text
global _start
_start:

mov rcx, qword [n]

loops:
  add qword [sum], rcx
  dec rcx
  cmp rcx, 0
  jne loops

mov rax, qword [sum]
mul rax
mov qword [sum], rax
mov qword [sum + 8], rdx

last:
  mov rax, SYS_exit
  mov rdi, EXIT_SUCCESS
  syscall
