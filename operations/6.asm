section .data

EXIT_SUCCESS equ 0
SYS_exit equ 0

dNum1 dd 123
dNum2 dd -150
dNum3 dd 56
dNum4 dd -13
dAns1 dd 0
dAns2 dd 0
dAns3 dd 0
dAns6 dd 0
dAns7 dd 0
dAns8 dd 0
qAns11 dq 0
qAns12 dq 0
qAns13 dq 0
dAns16 dd 0
dAns17 dd 0
dAns18 dd 0
dRem18 dd 0
qNum1 dq 213

section .text
global _start
_start:

mov eax, dword [dNum1]
add eax, dword [dNum2]
mov dword [dAns1], eax

mov eax, dword [dNum1]
add eax, dword [dNum3]
mov dword [dAns2], eax

mov eax, dword [dNum3]
add eax, dword [dNum4]
mov dword [dAns3], eax

mov eax, dword [dNum1]
sub eax, dword [dNum2]
mov dword [dAns6], eax

mov eax, dword [dNum1]
sub eax, dword [dNum3]
mov dword [dAns7], eax

mov eax, dword [dNum2]
sub eax, dword [dNum4]
mov dword [dAns8], eax

mov eax, dword [dNum1]
imul dword [dNum3]
mov dword [qAns11], eax
mov dword [qAns11 + 4], edx

mov eax, dword [dNum2]
imul eax
mov dword [qAns12], eax
mov dword [qAns12 + 4], edx

mov eax, dword [dNum2]
imul dword [dNum4]
mov dword [qAns13], eax
mov dword [qAns13 + 4], edx 

mov eax, dword [dNum1]
cdq
idiv dword [dNum2]
mov dword [dAns16], eax

mov eax, dword [dNum3]
cdq
idiv dword [dNum4]
mov dword [dAns17], eax

mov eax, dword [qNum1]
mov edx, dword [qNum1 + 4]
idiv dword [dNum4]
mov dword [dAns18], eax
mov dword [dRem18], edx

last:
  mov rax, SYS_exit
  mov rdi, EXIT_SUCCESS
