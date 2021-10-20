section .bss

sum resb 20
sum_int resq 1

section .data

NULL equ 0
LF equ 10

SYS_read equ 0
SYS_write equ 1
SYS_exit equ 60

STDIN equ 0
STDOUT equ 1
                                     
O_RDONLY equ 0
                                     
not_params db "The number of parameters enterd is wrong", NULL
len_params dq $ - not_params
not_numbers db "The parameters need to have the number format", NULL
len_numbers dq $ - len_numbers
                                     
section .text
global printString
printString:
                                     
mov rax, SYS_write
mov rdx, rsi
mov rsi, rdi
mov rdi, STDOUT
syscall

ret
                                     

global exitProgram
exitProgram:
                                     
mov rax, SYS_exit
mov rdi, 0
syscall
                                     
ret
                                     
                                     
global check_params_number
check_params_number:
                                     
cmp r8, 4
je number_params_ok
mov rdi, not_params
mov rsi, qword [len_params]
call printString
call exitProgram

number_params_ok:
                                     
ret
                                     
                                     
global check_string
check_string:
                                     
check_loop:
  cmp byte [rdi], NULL
  je end_of_string

  cmp byte [rdi], '0'
  jae above_zero
  mov rdi, not_numbers
  mov rsi, len_numbers
  call printString
  call endProgram
  above_zero:

  cmp byte [rdi], '9'
  jbe below_nine
  mov rdi, not_numbers
  mov rsi, len_numbers
  call printString
  call endProgram
  below_nine:

  inc rdi
  jmp check_loop
                                     
end_of_string:
                                     
ret


global string_to_number
string_to_number:

mov rcx, 10
mov r12, 0

loop_convert:
  cmp byte [rdi], NULL
  je end_number
  
  mov rax, r12
  mul rcx
  mov r12, rax

  mov al, byte [rdi]
  sub al, '0'
  add r12, rax
  inc rdi
  
  jmp loop_convert

end_number:
  mov rax, r12

ret


global printString_nolength
printString_nolength:

push r12
mov r12, 0
mov rcx, rdi

count_digits:
  cmp byte [rcx], NULL
  je count_done
  inc r12
  inc rcx
  jmp count_digits

count_done:
  inc r12
  mov byte [rcx], LF

mov rdi, r13
mov rsi, r12
;call printString

mov byte [rcx], NULL

pop r12

ret


global printSum
printSum:

push r12
push r13

mov r12, sum
mov r10, 1
mov rcx, 10
mov rax, rdi

sum_to_string:
  cqo
  div rcx
  add rdx, '0'
  mov byte [r12], dl 
  inc r10
  inc r12
  cmp rax, 0
  jne sum_to_string

mov byte [r12], NULL
mov r12, sum

pushing:
  mov al, byte [r12]
  cmp al, NULL
  je push_done
  push rax
  inc r12 
  jne pushing

push_done:
  mov byte [r12], LF
  mov r12, sum
  mov r13, 1

popping:
  pop rax
  mov byte [r12], al
  inc r12
  inc r13
  cmp r13, r10
  jne popping

mov rdi, sum
mov rsi, r10
call printString

pop r13
pop r12

ret

                                    
global main
main:
                                    
mov r8, rdi
mov r9, rsi
add r9, 8
                                    
call check_params_number
                                    
mov r10, 0
mov r11, r9
                                 
loop_for_check:
  mov rdi, qword [r11]
  call check_string
  inc r10
  add r11, 8
  cmp r10, 3
  jne loop_for_check

mov r10, 0
mov r13, 0
mov r11, r9

loop_for_sum:
  mov rdi, qword [r11]
  call string_to_number
  add r13, rax
  inc r10
  add r11, 8
  cmp r10, 3
  jne loop_for_sum

mov qword [sum_int], r13
                                    
mov r11, r9
mov r10, 0

;jmp summ

loop_for_print_string:
  mov rdi, qword [r11]
  call printString_nolength
  inc r10
  add r11, 8
  cmp r10, 3
  jne loop_for_print_string

summ:

mov rdi, qword [sum_int] 
call printSum

endProgram:
  call exitProgram
