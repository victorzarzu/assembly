section .bss

read_string resb 11
chr resb 1

section .data

NULL equ 0
STDIN equ 0
STDOUT equ 1
SYS_read equ 0
SYS_write equ 1
SYS_exit equ 60
LF equ 10

len dq 10 

section .text

global readString
readString:

mov rbx, rdi
mov r12, 0

read_chars:
  mov rax, SYS_read
  mov rdi, STDIN
  mov rsi, chr 
  mov rdx, 1
  syscall

  mov al, byte [chr]
  cmp al, LF
  je read_done
  
  inc r12
  cmp r12, qword [len]
  jae read_chars

  mov byte [rbx], al
  inc rbx

  jmp read_chars

  read_done:
    mov byte [rbx], NULL

ret

global printString
printString:

mov rdx, rsi
mov rsi, rdi
mov rax, SYS_write
mov rdi, STDOUT
syscall

ret

global _start
_start:

mov rdi, read_string
call readString

mov rdi, read_string
mov rsi, qword [len]
call printString

exit_program:
  mov rax, SYS_exit
  mov rdi, 0
  syscall
