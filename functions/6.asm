section .bss

num1 resd 1
num2 resd 1
num3 resd 1
num4 resd 1

section .data

SYS_exit equ 60
EXIT_SUCCESS equ 0

str_num1 db "+532531", 0
str_num2 db "-55335", 0
str_num3 db "*1435", 0
str_num4 db "-52 53", 0

section .text

global str_to_num
str_to_num:

push r12
mov r12, 0
mov rcx, 0

cmp byte [rdi], '+'
je plus
cmp byte [rdi], '-'
je minus
jmp invalid
plus:
mov rcx, 1
minus:

mov dword [rsi], 0
inc r12
mov r10d, 10

iterate:
  mov rax, 0
  mov eax, dword [rsi]
  mul r10d
  mov dword [rsi], eax

  mov rax, 0
  mov al, byte [rdi + r12]

  cmp al, '0'
  jb invalid
  cmp al, '9'
  ja invalid

  sub al, '0'
  add dword [rsi], eax 
  inc r12
  cmp byte [rdi + r12], 0
  jne iterate

jmp valid

invalid:
mov rax, 0
mov dword [rsi], 0
jmp exit

valid:
mov rax, 1

cmp rcx, 1
je positive_number
not dword [rsi]
dec dword [rsi]
positive_number:

exit:

pop r12

ret

global _start
_start:

mov rdi, str_num1
mov rsi, num1
call str_to_num

mov rdi, str_num2
mov rsi, num2
call str_to_num

mov rdi, str_num3
mov rsi, num3
call str_to_num

mov rdi, str_num4
mov rsi, num4
call str_to_num

last:
  mov rax, SYS_exit
  mov rdi, EXIT_SUCCESS
  syscall
