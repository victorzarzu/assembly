section .data

EXIT_SUCCESS equ 0
SYS_exit equ 0

bNum1 db 17 
bNum2 db 13 
bNum3 db 9 
bNum4 db 3 
bAns1 db 0
bAns2 db 0
bAns3 db 0
bAns6 db 0
bAns7 db 0
bAns8 db 0
wAns11 dw 0
wAns12 dw 0
wAns13 dw 0
bAns16 db 0
bAns17 db 0
bAns18 db 0
bRem18 db 0
wNum1 db 19

section .text
global _start
_start:

mov al, byte [bNum1]
add al, byte [bNum2]
mov byte [bAns1], al

mov al, byte [bNum1]
add al, byte [bNum3]
mov byte [bAns2], al

mov al, byte [bNum3]
add al, byte [bNum4]
mov byte [bAns3], al

mov al, byte [bNum1]
sub al, byte [bNum2]
mov byte [bAns6], al

mov al, byte [bNum1]
sub al, byte [bNum3]
mov byte [bAns7], al

mov al, byte [bNum2]
sub al, byte [bNum4]
mov byte[bAns8], al

mov al, byte [bNum1]
mov ah, 0
mul byte [bNum3]
mov word [wAns11], ax

mov al, byte [bNum2]
mul al
mov word [wAns12], ax

mov al, byte [bNum2]
mul byte [bNum4]
mov word [wAns13], ax

mov al, byte [bNum1]
mov ah, 0
div byte [bNum2]
mov byte [bAns16], al

mov al, byte [bNum3]
mov ah, 0
div byte [bNum4]
mov byte [bAns17], al

mov ax, word [wNum1]
div byte [bNum4]
mov byte [bAns18], al
mov byte [bRem18], ah

last:
  mov rax, SYS_exit
  mov rdi, EXIT_SUCCESS
  syscall
