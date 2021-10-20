section .data

EXIT_SUCCESS equ 0
SYS_exit equ 60
qword_pace equ 8

n0 dd 5
n1 dq 5
n2 dq 5
lst dq 12, 23, 34, 56, 67
len dq 5

section .text
global _start
_start:

mov rcx, 0

iterate:
  push qword [lst + rcx * qword_pace]
  inc rcx
  cmp rcx, qword [len]
  jne iterate


mov rcx, 0

iter:
  pop qword [lst + rcx * qword_pace]
  inc rcx 
  cmp rcx, qword [len] 
  jne iter

last:
  mov rax, SYS_exit
  mov rdi, EXIT_SUCCESS
  syscall
