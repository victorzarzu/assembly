section .bss

hex_value resb 20
one resq 1

section .data

almost_qw equ 8 * 7

SYS_write equ 1
SYS_exit equ 60

EXIT_SUCCESS equ 0
STDOUT equ 1

NULL equ 0
LF equ 10

section .text
global printString
printString:
  
mov rax, SYS_write
mov rsi, rdi
mov rdi, STDOUT
mov rdx, 19 
syscall

ret


global int_to_hex
int_to_hex:

mov rcx, almost_qw 
mov rsi, 16
mov r8, hex_value
add r8, 2

loop_hex:
  mov al, byte [rdi + rcx]
  cqo
  div rsi

  cmp dl, 10
  jl not_btts

  sub rdx, 10
  add dl, 'A'
  mov byte [r8 + 1], dl
  jmp smaller_done

  not_btts:
  add dl, '0'
  mov byte [r8 + 1], dl
  smaller_done:

  cmp rax, 10
  jl not_bttg

  sub rax, 10
  add al, 'A'
  mov byte [r8], al
  jmp bigger_done

  not_bttg:
  add al, '0'
  mov byte [r8], al
  bigger_done:
  
  add r8, 2

  sub rcx, 8
  cmp rcx, 0
  jge loop_hex

mov byte [r8], LF
mov byte [r8 + 1], NULL
mov rdi, hex_value
call printString

ret

global _start
_start:

mov byte [hex_value], '0'
mov byte [hex_value + 1], 'x'

sidt qword [one] 
mov rdi, qword [one]
call int_to_hex

jmp endProgram
mov r10, 256

loop_idt:
  mov rdi, qword [one]
  call int_to_hex
  add qword [one], 8
  dec r10
  cmp r10, 0
  jne loop_idt


endProgram:
  mov rax, SYS_exit
  mov rdi, EXIT_SUCCESS
  syscall
