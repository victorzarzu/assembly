section .data

EXIT_SUCCESS equ 0
SYS_exit equ 60

sum dq 0
n dq 15

section .text
global _start
_start:

mov rcx, qword [n]

for:
  mov rax, rcx
  mul rax
  add qword [sum], rax
  dec rcx
  cmp rcx, 0
  jne for 

last: 
  mov rax, SYS_exit
  mov rdi, EXIT_SUCCESS
  syscall
