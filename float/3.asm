section .data

SYS_exit equ 60
SYS_write equ 1

STDOUT equ 1

EXIT_SUCCESS equ 0
NULL equ 0


same_text db "Are Same", NULL
len_same dq $ - same_text
not_same_text db "Are Not Same", NULL
len_not_same dq $ - not_same_text
one dq 1.0
add_step dq 0.1
sum dq 0.0
steps dq 10

section .text
global printString
printString:

mov rax, SYS_write
mov rdx, rsi
mov rsi, rdi
mov rdi, STDOUT
syscall

ret

global _start
_start:

movsd xmm0, qword [sum]

loop_sum:
  addsd xmm0, qword [add_step]
  dec qword [steps]
  cmp qword [steps], 0
  jne loop_sum
  movsd qword [sum], xmm0

ucomisd xmm0, qword [one]
jne not_one

mov rdi, same_text
mov rsi, qword [len_same]
call printString
jmp endProgram

not_one:
mov rdi, not_same_text
mov rsi, qword [len_not_same]
call printString

endProgram:
  mov rax, SYS_exit
  mov rdi, EXIT_SUCCESS
  syscall
