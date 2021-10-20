%macro set_invalid 3

mov r8, 0
%%iter:
  mov al, byte [%1 + r8]
  mov byte [%2 + r8], al
  inc r8
  cmp r8, 7
  jne %%iter
  mov byte [%2 + r8], 0
  mov dword [%3], 0
  jmp final

%endmacro

section .bss

number resd 1

section .data

NULL equ 0
SYS_exit equ 60
EXIT_SUCCESS equ 0

strNum db "+012345"
len db $ - strNum
verif db "valid.." 
inval db "invalid" 
pos db 1

section .text
global _start
_start:

cmp byte [strNum], '-'
jne positive
mov byte [pos], 0
jmp okay
positive:
cmp byte [strNum], '+'
je okay

set_invalid inval, verif, number

okay:

mov r8, 1
mov dword [number], 0
mov rbx, 10

transform:
  mov rax, 0
  mov eax, dword [number]
  mul rbx
  mov cl, byte [strNum + r8]

  cmp cl, '0'
  jae a_zero 
  set_invalid inval, verif, number
  a_zero:
  cmp cl, '9'
  jbe b_nine
  set_invalid inval, verif, number
  b_nine:

  cmp cl, '0'
  jne non_zero
  cmp r8, 1
  jne non_first
  set_invalid inval, verif, number
  non_zero:
  non_first:

  sub cl, '0'
  add rax, rcx
  mov dword [number], eax
  inc r8
  cmp r8b, byte [len]
  jne transform

cmp byte [pos], 1
je posit
not dword [number]
inc dword [number]

;mov rax, 0
;mov eax, dword [number]
;mov rbx, -1
;imul rbx
;mov dword [number], eax
posit:

final:

last:
  mov rax, SYS_exit
  mov rdi, EXIT_SUCCESS
  syscall
