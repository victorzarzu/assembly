section .data

EXIT_SUCCESS equ 0
SYS_exit equ 60

b1 db 5 
b2 db 3 
br db 100 

w1 dw 0 

d1 dd 100
d2 dd 50
dr dd 26

dq1 dq 0xf000000000000000
dq2 dq 0xf000000000000000
dqr dq 0

section .text
global _start
_start:

;addition
mov al, byte [b1]
add al, byte [b2]
inc al
mov byte [b2], al
dec al
mov byte [br], al

;byte to word
cbw
mov word [w1], ax

;addition with carry
mov rax, qword [dq1]
mov rdx, qword [dq1 + 8]

add rax, qword [dq2]
adc rdx, qword [dq2 + 8]

mov qword [dqr], rax
mov qword [dqr + 8], rdx

;substraction
mov eax, dword[d1]
sub eax, dword [d2]
mov dword [dr], eax
dec dword [d1]

last:
  mov rax, SYS_exit
  mov rdi, EXIT_SUCCESS
  syscall
