section .data

EXIT_SUCCESS equ 0
SYS_exit equ 0

n dq 1
n1 dq 1
n2 dq 0

section .text
global _start
_start:

mov rcx, qword [n]

cmp rcx, 1
jg fibo
jmp nothing

fibo:
  mov rbx, qword [n1]
  mov rax, qword [n2]
  add rax, rbx
  mov qword [n1], rax
  mov qword [n2], rbx
  dec rcx
  cmp rcx, 0
  jne fibo

nothing:

last:
  mov rax, SYS_exit
  mov rdi, EXIT_SUCCESS
  syscall
