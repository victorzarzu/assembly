section .data

a dd 123
b dd 124
c dd 0

section .text
global _start
_start:

mov eax, dword [a]
add eax, dword [b]
mov dword [c], eax

last:
  mov rax, 0
  mov rdi, 0
  syscall
