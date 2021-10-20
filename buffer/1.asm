section .bss

buffer resb 32 
descriptor resq 1
line resb 10

section .data

NULL equ 0
LF equ 10
LINE_MAX equ 10
BUFFER_MAX equ 32

SYS_read equ 0
SYS_write equ 1
SYS_open equ 2
SYS_exit equ 60

STDIN equ 0
STDOUT equ 1

O_RDONLY equ 0

file db "input.txt"

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

mov qword [descriptor], rax

ret

global myGetLine
myGetLine:

mov r10, 0

buffer_loop:
  cmp r8, BUFFER_MAX
  jne no_fetch

  mov rax, SYS_read
  mov rdi, qword [descriptor]
  mov rsi, buffer
  mov rdx, BUFFER_MAX
  syscall

  cmp rax, 0
  jne not_empty
  ret

  not_empty:
  mov r8, 0
  mov r9, rax
  mov rcx, buffer
  mov rdx, line

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

  cmp r9, BUFFER_MAX
  je not_smaller
  mov rax, 0
  not_smaller:

  ret

  not_linefeed:

  cmp r10, LINE_MAX
  jne not_full_line

  mov rdi, line
  mov rsi, r10
  call printString

  mov rax, 1
  ret

  not_full_line:

  jmp buffer_loop

mov rax, 1
ret

global _start
_start:

mov rdi, file
call openFile

mov r8, BUFFER_MAX
get_line:
  call myGetLine
  cmp rax, 0
  jne get_line

endProgram:
  mov rax, SYS_exit
  mov rdi, 0
  syscall
