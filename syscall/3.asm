section .bss

pass_string resb 21
chr resb 1
file_descriptor resq 1

section .data

LF equ 10
NULL equ 0
STDIN equ 0
STDOUT equ 1

SYS_read equ 0
SYS_write equ 1
SYS_exit equ 60
SYS_creat equ 85
SYS_open equ 2
SYS_close equ 3

O_RDWR equ 2
S_IRWXU equ 00700q
len equ 20

status db "NOSUCCESS", NULL
file_path db "pass_write.txt", NULL
success db "SUCCESS", NULL
len_suc dq 8

section .text

global readString
readString:

mov rbx, rdi
mov r12, 0

readchars:
  mov rax, SYS_read
  mov rdi, STDIN
  mov rsi, chr
  mov rdx, 1
  syscall

  mov al, byte [chr]
  cmp al, LF
  je read_done

  inc r12
  cmp r12, len
  jae readchars

  mov byte [rbx], al
  inc rbx

  jmp readchars

read_done:
  mov byte [rbx], NULL

ret

global fileWrite
fileWrite:

mov rax, SYS_write
syscall

ret

global _start
_start:

mov rdi, pass_string
call readString

mov rax, SYS_creat
mov rdi, file_path
mov rsi, S_IRWXU 
syscall

cmp rax, 0
jb its_not_ok

mov rax, SYS_open
mov rdi, file_path
mov rsi, O_RDWR
syscall

cmp rax, 0
jb its_not_ok

mov qword [file_descriptor], rax
mov rdi, rax
mov rsi, pass_string
mov rdx, len
call fileWrite

mov r12, 0
set_success:
 mov al, byte [success + r12]
 mov byte [status + r12], al
 inc r12
 cmp r12, qword [len_suc]
 jne set_success

mov rax, SYS_close
mov rdi, qword [file_descriptor]
syscall

its_not_ok:

last:
  mov rax, SYS_exit
  mov rdi, 0
  syscall
