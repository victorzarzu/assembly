section .data

EXIT_SUCCESS equ 0
SYS_exit equ 60

bNumA db 42
bNumB db 73
wAns dw 0
wAns1 dw 0

w1 db -12
w2 db -4

wNumA dw 4321
wNumB dw 1234
dAns2 dd 0

dNumA dd 42000
dNumB dd 73000
qAns3 dq 0

qNumA dq 420000
qNumB dq 730000
dqAns4 ddq 0


wNumC dw 1200
wNumD dw -2000
wAns11 dw 0
wAns22 dw 0

dNumC dd 42000
dNumD dd -13000
dAns11 dd 0
dAns22 dd 0

qNumC dq 120000
qNumD dq -230000
qAns11 dq 0
qAns22 dq 0

section .text
global _start
_start:

mov al, byte [bNumA]
mul al
mov word [wAns], ax

mov al, byte [bNumA]
mul byte [bNumB]
mov word [wAns1], ax

mov ax, word [wNumA]
mul word [wNumB]
mov word [dAns2], ax
mov word [dAns2 + 2], dx

mov eax, dword [dNumA]
mul dword [dNumB]
mov dword [qAns3], eax
mov dword [qAns3 + 4], edx

mov rax, qword [qNumA]
mul qword [qNumB]
mov qword [dqAns4], rax
mov qword [dqAns4 + 8], rdx

mov al, byte [w1]
imul byte [w2]
mov byte [w2], al 

mov ax, word [wNumC]
imul ax, -13
mov word [wAns11], ax

mov ax, word [wNumC]
imul ax, word [wNumD]
mov word [wAns22], ax

mov eax, dword [dNumC]
imul eax, 113
mov dword [dAns11], eax

mov eax, dword [dNumC]
imul eax, dword [dNumD]
mov dword [dAns22], eax

mov rax, qword [qNumC]
imul rax, 7096
mov qword [qAns11], rax

mov rcx, qword [qNumC]
imul rbx, rcx, 7096
mov qword [qAns22], rbx

mov rax, qword [qNumC]
imul rax, qword [qNumD]
mov qword [qAns22], rax

last:
  mov rax, SYS_exit
  mov rdi, EXIT_SUCCESS
  syscall
