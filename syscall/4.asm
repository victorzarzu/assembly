section .bss

pass resb 14
chr resb 1
file_descriptor resq 1

section .data

NULL equ 0
LF equ 10

SYS_read equ 0
SYS_write equ 1
SYS_open equ 2
SYS_close equ 3
SYS_exit equ 60

O_RDONLY equ 0
STDOUT equ 1

len equ 13

status db "NOSUCCESS", NULL
success db "SUCCESS", NULL
len_suc dq $ - success 
file_path db "pass_write.txt", NULL

section .text

global openFile
openFile:

mov rax, SYS_open
mov rdi, file_path
mov rsi, O_RDONLY
syscall

mov qword [file_descriptor], rax

ret


global readFile
readFile:

mov rax, SYS_read
mov rdi, qword [file_descriptor]
mov rsi, pass
mov rdx, len
syscall

mov byte [pass + rax], NULL

ret


global closeFile 
closeFile:

mov rdi, file_path

ret

global writePass
writePass:

mov rax, SYS_write
mov rdi, STDOUT
mov rsi, pass
mov rdx, len
syscall

ret

global _start
_start:

call openFile

cmp qword [file_descriptor], 0
jl its_not_ok

call readFile

cmp rax, 0
jl its_not_ok

call closeFile

mov rcx, 0
set_status:
  mov al, byte [success + rcx]
  mov byte [status + rcx], al
  inc rcx
  cmp rcx, qword [len_suc]
  jne set_status

call writePass

its_not_ok:

last:
  mov rax, SYS_exit
  mov rdi, 0
  syscall



