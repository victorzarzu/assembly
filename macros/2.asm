%macro multby2 2

mov rcx, 0
mov ebx, 2

%%iterate:
  mov eax, dword [%1 + rcx * 4]
  imul ebx
  mov dword [%1 + rcx * 4], eax
  inc ecx
  cmp ecx, dword [%2] 
  jne %%iterate

%endmacro

section .data

SYS_exit equ 60
EXIT_SUCCESS equ 0

list1 dd 5, 10, 15, 20, 25
len1 dd ($ - list1) / 4

list2 dd 5, -6, -10, 25, 253, -12
len2 dd ($ - list2) / 4

list3 dd 52, 1, 0, -14, 100, 156, -13
len3 dd ($ - list3) / 4

section .text
global _start
_start:

multby2 list1, len1
multby2 list2, len2
multby2 list3, len3

last:
  mov rax, SYS_exit
  mov rdi, EXIT_SUCCESS
  syscall
