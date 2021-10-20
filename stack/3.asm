section .bss

reverse resb 32
normal resb 32
pal resb 1

section .data

SYS_exit equ 60
EXIT_SUCCESS equ 0
small_start equ 'a'
small_cap equ 'z'
big_start equ 'A'
big_cap equ 'Z'
diff equ 'a' - 'A'

text db "A man, a plan, a canal - Panama!"
len db $ - text

section .text
global _start
_start:

mov rcx, 0
mov r8, 0

modify:
  mov al, byte [text + rcx]

  cmp al, small_start
  jb not_small 
  cmp al, small_cap
  ja not_small
  jmp insert_normal 
  not_small:
  
  cmp al, big_start
  jb not_big
  cmp al, small_cap
  ja not_big
  jmp insert_normal
  not_big:

  jmp final_ops

  insert_normal:
    cmp al, big_cap
    ja small_letter
    add al, diff 
    small_letter:
    mov byte [normal + r8], al
    inc r8

  final_ops:
    inc rcx
    cmp cl, byte [len]
    jne modify
  mov rcx, 0

pushing:
  mov rax, 0
  mov al, byte [normal + rcx]
  push rax
  inc rcx
  cmp rcx, r8
  jne pushing
  mov rcx, 0

poping:
  pop rax
  mov [reverse + rcx], al
  inc rcx
  cmp rcx, r8
  jne poping
  mov rcx, 0

verify
  mov al, [normal + rcx]
  cmp al, [reverse + rcx]
  jne non_palindrome
  inc rcx
  cmp rcx, r8
  jne verify

mov byte [pal], 1
non_palindrome:

last:
  mov rax, SYS_exit
  mov rdi, EXIT_SUCCESS
  syscall
