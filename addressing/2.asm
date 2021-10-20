section .data

EXIT_SUCCESS equ 0
SYS_exit equ 60
dword_pace equ 4

lst dd 1002, 1004, 1006, 1005, 1030, 1100, 1001, 56, 2000
len dd 9
max dd 0
min dd 0
sum dd 0
avg dd 0

section .text
global _start
_start:

mov rcx, 1
mov rsi, lst
mov eax, dword [rsi]
mov dword [max], eax 
mov dword [min], eax 
mov dword [sum], eax

iterate:
  mov eax, dword [rsi + rcx * dword_pace]
  add dword [sum], eax

  cmp eax, dword [max]
  jbe unswitch_max
  mov dword [max], eax
  unswitch_max:

  cmp eax, dword [min]
  jae unswitch_min
  mov dword [min], eax
  unswitch_min:

  inc rcx
  cmp ecx, dword [len]
  jne iterate

mov edx, 0
mov eax, dword [sum]
div dword [len]
mov dword [avg], eax

last:
  mov rax, SYS_exit
  mov rdi, EXIT_SUCCESS
  syscall
