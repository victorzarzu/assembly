%macro num_to_text 2

mov rcx, 1
mov rbx, 10

cmp dword [%1], 0
jl %%negative
mov byte [%2], '+'
jmp %%sign
%%negative:
mov byte [%2], '-'
mov eax, dword [%1]
mov rdx, -1
imul rdx
mov dword [%1], eax
%%sign:

%%iterate:
  mov eax, dword [%1]
  cqo
  idiv rbx
  add dl, '0'
  mov byte [%2 + rcx], dl
  mov dword [%1], eax
  inc rcx
  cmp dword [%1], 0
  jne %%iterate
  mov byte [%2 + rcx], 0

mov r8, rcx
mov rcx, 1

%%pushing:
  mov al, byte [%2 + rcx]
  push rax
  inc rcx
  cmp rcx, r8
  jne %%pushing
  mov rcx, 1

%%poping:
  pop rax
  mov byte [%2 + rcx], al
  inc rcx
  cmp rcx, r8
  jne %%poping
  mov rcx, 1

%endmacro

section .bss

string_num resb 8

section .data

SYS_exit equ 60
EXIT_SUCCESS equ 0

n dd -1525443

section .text
global _start
_start:

num_to_text n, string_num

last:
  mov rax, SYS_exit
  mov rdi, EXIT_SUCCESS
  syscall
