%macro func 5

mov ecx, 0 
mov eax, dword [%1]
mov dword [%4], eax
mov dword [%5], eax
mov eax, 0

%%iterate:
  mov ebx, dword [%1 + ecx * 4]
  add eax, ebx
  inc ecx
  cmp ebx, dword [%4]
  jge %%non_minim
  mov dword [%4], ebx
  %%non_minim:
  cmp ebx, dword [%5]
  jle %%non_maxim
  mov dword [%5], ebx
  %%non_maxim:
  cmp ecx, dword [%2]
  jne %%iterate
  mov ecx, 0

cdq
idiv dword [%2]
mov dword [%3], eax

%endmacro

section .data

SYS_exit equ 60
EXIT_SUCCESS equ 0

list1 dd 14, 15, 16, 17, 18
len1 dd 5
avg1 dd 0
min1 dd 0
max1 dd 0

list2 dd 5, -1, -10, 1, 70, 15, -5
len2 dd 7
avg2 dd 0
min2 dd 0
max2 dd 0

section .text
global _start
_start:

func list1, len1, avg1, min1, max1
func list2, len2, avg2, min2, max2

last:
  mov rax, SYS_exit
  mov rdi, EXIT_SUCCESS
  syscall
