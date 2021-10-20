section .bss

idesc resq 1
odesc resq 1
line_nr resq 1
buffer resb 32
line resb 10

section .data

NULL equ 0
LF equ 10
LINE_MAX equ 9
BUFFER_MAX equ 32

SYS_read equ 0
SYS_write equ 1
SYS_open equ 2
SYS_close equ 3
SYS_creat equ 85
SYS_exit equ 60

STDIN equ 0
STDOUT equ 1

O_RDONLY equ 0
S_IRWXU equ 00700q

section .text
global printString
printString:

mov rax, SYS_write
mov rdx, rsi
mov rsi, rdi
mov rdi, STDOUT 
syscall

ret

global openFile
openFile:

mov rax, SYS_open
mov rsi, O_RDONLY
syscall

mov qword [idesc], rax

ret

global createFile
createFile:

mov rax, SYS_creat
mov rsi, S_IRWXU
syscall

mov qword [odesc], rax

ret

global int_to_string
int_to_string:

push r9

mov rcx, 10
mov r10, 0
digits:
  mov rax, rdi
  cqo
  div rcx
  mov rdi, rax
  add dl, '0'
  mov byte [line + r10], dl
  inc r10
  cmp rdi, 0
  jne digits
  mov byte [line + r10], ' '

mov r9, 0
pushing:
  mov al, byte [line + r9]
  push rax
  inc r9
  cmp r9, r10
  jne pushing 
  mov r9, 0
 
popping:
  pop rax
  mov byte [line + r9], al
  inc r9
  cmp r9, r10
  jne popping
  inc r10

pop r9

ret

global getLine
getLine:

mov rdi, qword [line_nr]
call int_to_string 

buffer_loop:
  cmp r8, BUFFER_MAX
  jne no_fetch

  mov rax, SYS_read
  mov rdi, qword [idesc]
  mov rsi, buffer
  mov rdx, BUFFER_MAX
  syscall

  cmp rax, 0
  jne not_empty
  ret

  not_empty:
    mov r8, 0
    mov r9, rax

  no_fetch:

  mov al, byte [buffer + r8]
  mov byte [line + r10], al
  inc r10
  inc r8

  cmp al, LF
  jne not_linefeed
  
  mov rdi, line
  mov rsi, r10
  call printString

  mov rax, 1
  cmp r8, r9
  jne not_eof
  cmp r9, BUFFER_MAX
  je not_smaller
  mov rax, 0
  ret
  not_smaller:
  not_eof:

  ret

  not_linefeed:

  cmp r10, LINE_MAX
  jne not_full_line

  mov rdi, line
  mov rsi, r10
  call printString

  mov r10, 0

  not_full_line:

  jmp buffer_loop
  
mov rax, 1
ret

global main 
main:

mov rdi, qword [rsi + 8]
mov r11, qword [rsi + 16]
call openFile
mov rdi, r11
call createFile

mov r8, BUFFER_MAX
mov qword [line_nr], 1

get_line:
  call getLine
  inc qword [line_nr]
  cmp rax, 0
  jne get_line

endProgram:
  mov rax, SYS_exit
  mov rdi, 0
  syscall
