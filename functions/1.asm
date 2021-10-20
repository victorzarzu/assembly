section .data

SYS_exit equ 60
EXIT_SUCCESS equ 0

len dd 7
arr dd 8, -10, -15, 90, 15, 13
ave dd 0
sum dd 0

section .text

global stats1
stats1:
  push r12

  mov r12, 0
  mov rax, 0

  sumLoop:
    add eax, dword [rdi + r12 * 4]
    inc r12
    cmp r12, rsi
    jne sumLoop

    mov dword [rdx], eax

    cdq
    idiv esi
    mov dword [rcx], eax
    
    pop r12
    ret

global _start
_start:

mov rcx, ave
mov rdx, sum
mov esi, dword [len]
mov rdi, arr
call stats1


last:
  mov rax, SYS_exit
  mov rdi, EXIT_SUCCESS
  syscall
