section .data 

a dq 192
b dq 162

section .text
global _start
_start:

euclid:
  mov rdx, 0
  mov rax, qword [a]
  mov rcx, qword [b]
  mov qword [a], rcx
  div rcx
  mov qword [b], rdx
  cmp qword [b], 0
  jne euclid

last:
  mov rax, 0
  mov rdi, 0
  syscall 
