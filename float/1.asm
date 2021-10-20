section .data

SYS_exit equ 60
EXIT_SUCCESS equ 0

fltList dq 16.5, 43.6, 7.75, 6.12, 90.12, 5.1, 6.02, 13.98
        dq 15.8, -1.5, 78.1
length dq ($ - fltList) / 8
sum dq 0.0
avg dq 0.0

section .text
global _start
_start:

mov rcx, qword [length]
mov rbx, fltList
mov rsi, 0
movsd xmm1, qword [sum]

sum_loop:
  movsd xmm0, qword [rbx]
  addsd xmm1, xmm0
  inc rsi
  add rbx, 8
  cmp rsi, qword [length]
  jne sum_loop

movsd qword [sum], xmm1

cvtsi2sd xmm0, dword [length]
divsd xmm1, xmm0
movsd qword [avg], xmm1

endProgram:
  mov rax, SYS_exit
  mov rdi, EXIT_SUCCESS
  syscall 
