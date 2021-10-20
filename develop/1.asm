section .bss

strNum resb 10

section .data

SYS_exit equ 60
EXIT_SUCCESS equ 0
zero equ '0'
NULL equ 0

n dq 135790

section .text
global _start
_start:

mov r8, 0
mov rbx, 10

pushing:
  mov rdx, 0
  mov rax, qword [n] 
  div rbx
  push rdx
  inc r8
  mov qword [n], rax
  cmp rax, 0
  jne pushing
  mov rcx, 0

poping:
  pop rax
  add rax, zero
  mov byte [strNum + rcx], al
  inc rcx
  cmp rcx, r8
  jne poping
  mov byte [strNum + rcx], NULL

last:
  mov rax, SYS_exit
  mov rdi, EXIT_SUCCESS
  syscall
