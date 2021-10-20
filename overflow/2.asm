section .data

LF equ 10
NULL equ 0

EXIT_SUCCESS equ 0

STDIN equ 0
STDOUT equ 1

SYS_read equ 0
SYS_write equ 1
SYS_exit equ 60

STRLEN equ 10

section .bss

chr resb 1

section .text
global _start
_start:

call readString

exampleDone:
  mov rax, SYS_exit
  mov rdi, EXIT_SUCCESS
  syscall

global readString
readString:

push rbp
mov rbp, rsp
push rbx
lea rbx, byte [rbp - STRLEN - 1] 

mov rax, 0

readCharacters:
  mov rax, SYS_read
  mov rdi, STDIN
  lea rsi, byte [chr]
  mov rdx, 1
  syscall

  mov al, byte [chr]
  cmp al, LF
  je readDone
  
  mov byte [rbx], al
  inc rbx
  inc rax

  jmp readCharacters

readDone:
  mov byte [rbx], NULL

strCountDone:
  cmp rax, 0
  je prtDone

mov rdx, rax
mov rax, SYS_write
lea rsi, byte [rbp - STRLEN - 1] 
mov rdi, STDOUT
syscall

prtDone:
  pop rbx
  mov rsp, rbp
  pop rbp
  ret
