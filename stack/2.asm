section .data

EXIT_SUCCESS equ 0
SYS_exit equ 60
qword_pace equ 8

text db "abcdcba"
len dq 7 
reverse db "1234567" 
pal db 0

section .text
global _start
_start:

mov rcx, 0

pushing:
  mov rax, 0
  mov al, byte [text + rcx]
  push rax
  inc rcx
  cmp rcx, qword [len]
  jne pushing

mov rcx, 0

poping:
  pop rax
  mov byte [reverse + rcx], al 
  inc rcx
  cmp rcx, qword [len]
  jne poping

mov rcx, 0

comparing:
  mov al, byte [reverse + rcx]
  cmp al, byte [text + rcx]
  jne non_pal
  inc rcx
  cmp rcx, qword [len]
  jne comparing 

mov byte [pal], 1
non_pal:

dec rsp

last:
  mov rax, SYS_exit
  mov rdi, EXIT_SUCCESS
  syscall
