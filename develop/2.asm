section .bss

strNum resb 11

section .data

NULL equ 0
SYS_exit equ 60
EXIT_SUCCESS equ 0

n dq -1546

section .text
global _start
_start:

mov rcx, 1
mov rbx, 10

cmp qword [n], 0
jge positive 
mov byte [strNum], '-'
mov r9, 1
jmp end_sign
positive:
mov byte [strNum], '+' 
end_sign:

pushing:
  mov rax, qword [n]
  cqo
  idiv rbx
  push rdx
  inc rcx
  mov qword [n], rax
  cmp qword [n], 0
  jne pushing

mov r8, 1 

poping:
  pop rax
  cmp r9, 0
  je normal
  not rax
  inc rax
  normal:
  add rax, '0'
  mov byte [strNum + r8], al
  inc r8
  cmp r8, rcx
  jne poping
  mov byte [strNum + r8], NULL

mov qword [n], rcx

last:
  mov rax, SYS_exit
  mov rdi, EXIT_SUCCESS
  syscall
