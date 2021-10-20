section .data

EXIT_SUCCESS equ 0
SYS_exit equ 60

lst dd 1002, 1004, 1006, 1008, 1010
len dd 5
sum dd 0

section .text
global _start
_start:

mov ecx, 0

sumloop:
  mov eax, dword [lst + ecx * 4]
  add dword [sum], eax
  inc ecx
  cmp ecx, dword [len]
  jne sumloop


last:
  mov rax, SYS_exit
  mov rdi, EXIT_SUCCESS
  syscall
