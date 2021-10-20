section .bss

str_num1 resb 15
str_num2 resb 15
str_num3 resb 15

section .data

SYS_exit equ 60
EXIT_SUCCESS equ 0
len equ 15

num1 dd 14241
num2 dd -1532414
num3 dd 24321

section .text

global num_to_str
num_to_str

mov r10, 0
mov rcx, 10
cmp edi, 0
mov r11, 0
jl negative
mov r11, 1
negative:

iterate:
  mov byte [rsi + r10], ' '
  inc r10
  cmp r10, rdx
  jne iterate
  dec r10
  mov byte [rsi + r10], 0 
  dec r10

iterate_num:
  mov eax, edi
  cdq
  idiv ecx
  cmp r11, 1
  je positive_decimal
  not edx
  inc edx
  positive_decimal:
  add rdx, '0'
  mov byte [rsi + r10], dl
  dec r10
  mov edi, eax
  cmp edi, 0
  jne iterate_num

mov byte [rsi + r10], '+'
cmp r11, 1
je positive
mov byte [rsi + r10], '-'
positive:

ret

global _start
_start:

mov edi, dword [num1]
mov rsi, str_num1
mov edx, len 
call num_to_str

mov edi, dword [num2]
mov rsi, str_num2
mov edx, len 
call num_to_str

mov edi, dword [num3]
mov rsi, str_num3
mov edx, len 
call num_to_str

last:
  mov rax, SYS_exit
  mov rdi, EXIT_SUCCESS
  syscall
