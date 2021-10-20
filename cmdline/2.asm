section .bss

len_read db 1
chr db 1
read_string db 255

section .data

NULL equ 0
LF equ 10

SYS_read equ 0
SYS_write equ 1
SYS_open equ 2
SYS_exit equ 60

STDIN equ 0
STDOUT equ 1

O_RDONLY equ 0

max_read equ 254

many_par db "Not the correct number of parameters", NULL
len_many dq $ - many_par
not_open db "The file couldn't be opened", NULL
len_not_open dq $ - not_open
not_read db "Couldn't read from file", NULL
len_not_read dq $ - not_read


section .text
global exitProgram
exitProgram:

mov rax, SYS_exit
mov rdi, 0
syscall

ret


global printString
printString:

mov rax, SYS_write
mov rdx, rsi
mov rsi, rdi
mov rdi, STDOUT
syscall

ret


global checkRead
checkRead:

cmp rax, 0
jge read
mov rdi, not_read
mov rsi, qword [len_not_read]
call printString
call exitProgram
read:

ret


global main
main:

mov r10, rdi
mov r11, rsi
add r11, 8

cmp rdi, 2
je params_ok
mov rdi, many_par
mov rsi, qword [len_many] 
call printString
call exitProgram
params_ok:

mov rax, SYS_open
mov rdi, qword [r11]
mov rsi, O_RDONLY
syscall

cmp rax, 0
jge opened
mov rdi, not_open
mov rsi, qword [len_not_open]
call printString
call exitProgram
opened:
mov r12, rax

mov rbx, read_string
mov r13, 0

read_file:
  mov rax, SYS_read
  mov rdi, r12
  mov rsi, chr
  mov rdx, 1
  syscall

  call checkRead

  mov al, byte [chr]
  cmp al, LF 
  je read_done

  inc r13
  cmp r13, max_read
  jge read_file

  mov byte [rbx], al
  inc rbx

  jmp read_file

cmp r13, max_read
jle len_ok
mov r13, max_read
len_ok:

read_done:
  mov byte [rbx], NULL

mov rax, SYS_write
mov rdi, STDOUT
mov rsi, read_string
mov rdx, r13 
syscall

endProgram:
  mov rax, SYS_exit
  mov rdi, 0
  syscall
