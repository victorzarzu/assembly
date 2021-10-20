section .data

SYS_exit equ 60
EXIT_SUCCESS equ 0

list1 dd -9, -15, 9, 0, 17, 38 
len1 dd 6

list2 dd 5, 2, 10, -12, -124, 14, 13, 0, -1, 6, 10
len2 dd 11

list3 dd 2, 6, 1, 10, -5, -13, 15, 34
len3 dd 8

section .text

global sort
sort:

push r12
mov r12, 0

iterate:
  mov r10d, dword [rdi + r12 * 4]
  mov r11, r12
  mov rcx, r12

  minimum:
    cmp r10d, dword [rdi + rcx * 4]
    jl non_minim
    mov r10d, dword [rdi + rcx * 4] 
    mov r11, rcx
    non_minim:
    inc rcx
    cmp ecx, esi
    jl minimum
  mov eax, dword [rdi + r12 * 4] 
  mov dword [rdi + r12 * 4], r10d
  mov dword [rdi + r11 * 4], eax
  inc r12
  cmp r12d, esi
  jl iterate

pop r12
ret

global _start
_start:

mov rdi, list1
mov esi, dword [len1]
call sort

mov rdi, list2
mov esi, dword [len2]
call sort

mov rdi, list3
mov esi, dword [len3]
call sort

last:
  mov rax, SYS_exit
  mov rdi, EXIT_SUCCESS
  syscall
