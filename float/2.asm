%macro fAbsf 1

cvtsd2ss xmm0, qword [negone]
cvtsd2ss xmm1, qword [zero]
movss xmm2, dword [%1]
ucomiss xmm2, xmm1 

jae %%not_neg
mulss xmm2, xmm0 
movss dword [%1], xmm2 
%%not_neg:

%endmacro

%macro fAbsd 1

movsd xmm0, qword [%1]
ucomisd xmm0, qword [zero]

jae %%not_neg
mulsd xmm0, qword [negone]
movsd qword [%1], xmm0
%%not_neg:

%endmacro

section .data

SYS_exit equ 60
EXIT_SUCCESS equ 0

negone dq -1.0
zero dq 0.0

s1 dd 15.6
s2 dd -112.90
s3 dd -0.8

d1 dq -56.78
d2 dq 12.7
d3 dq 145.009

section .text
global _start
_start:

fAbsf s1
fAbsf s2
fAbsf s3

fAbsd d1
fAbsd d2
fAbsd d3

endProgram:
  mov rax, SYS_exit
  mov rdi, EXIT_SUCCESS
  syscall
