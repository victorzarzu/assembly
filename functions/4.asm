section .bss

min1 resd 1
max1 resd 1
sum1 resd 1
ave1 resd 1
med11 resd 1
med12 resd 1
std1 resd 1

min2 resd 1
max2 resd 1
sum2 resd 1
ave2 resd 1
med21 resd 1
med22 resd 1
std2 resd 1

min3 resd 1
max3 resd 1
sum3 resd 1
ave3 resd 1
med31 resd 1
med32 resd 1
std3 resd 1

section .data

SYS_exit equ 60
EXIT_SUCCESS equ 0

list1 dd -9, -15, 9, 0, 17, 38
len1 dd 6

list2 dd 5, 2, 10, -12, -124, 14, 13, 0, -1, 6, 10
len2 dd 11

list3 dd 2, 6, 1, 10, -5, -13, 15, 34
len3 dd 8

section .text

global sort
sort:

push r12
mov r12, 0

iterate:
  mov r10d, dword [rdi + r12 * 4]
  mov r11, r12
  mov rcx, r12

  minimum:
    cmp r10d, dword [rdi + rcx * 4]
    jl non_minim
    mov r10d, dword [rdi + rcx * 4] 
    mov r11, rcx
    non_minim:
    inc rcx
    cmp ecx, esi
    jl minimum
  mov eax, dword [rdi + r12 * 4] 
  mov dword [rdi + r12 * 4], r10d
  mov dword [rdi + r11 * 4], eax
  inc r12
  cmp r12d, esi
  jne iterate

pop r12
ret

global stats
stats:

push rbp
mov rbp, rsp
push r12
push rbx
mov r12, 0

mov r10, qword [rbp + 16]
mov r11d, dword [rdi]
mov dword [r10], r11d

mov r11, rdx
mov eax, esi
cdq
mov rbx, 2
div rbx

mov r10d, dword [rdi + rax * 4]
mov dword [r11], r10d 
mov dword [rcx], r10d

cmp edx, 0
jne odd
dec eax
mov r10d, dword [rdi + rax * 4]
mov dword [r11], r10d
odd:

dec rsi
mov r10, qword [rbp + 24]
mov r11d, dword [rdi + rsi * 4]
mov dword [r10], r11d 
inc rsi

mov eax, 0

loop_stats:
  add eax, dword [rdi + r12 * 4]
  inc r12
  cmp r12d, esi
  jne loop_stats 


mov dword [r8], eax
cdq
mov r10d, esi
idiv r10d
mov dword [r9], eax

pop rbx
pop r12
mov rsp, rbp
pop rbp
ret

global std_f 
std_f:

push rdx
push r12
mov r12, 0 
mov r11d, 0

std_iterate:
  mov eax, dword [rdi + r12 * 4]
  sub eax, ecx 
  cdq
  imul eax
  add r11d, eax
  inc r12
  cmp r12, rsi
  jne std_iterate

pop r12
mov eax, r11d
cdq
div rsi
pop rdx
mov dword [rdx], eax 
ret   


global sqrt
sqrt:

mov r10d, dword [rdi] 
mov rcx, 0

sqrt_iterate:
  mov eax, dword [rdi] 
  cdq
  div r10d
  add eax, r10d
  mov r11d, 2
  cdq
  div r11d
  mov r10d, eax
  inc rcx
  cmp rcx, 50
  jne sqrt_iterate

mov dword [rdi], r10d
ret


global _start
_start:

mov rdi, list1
mov esi, dword [len1]
call sort

mov rdx, med11 
mov rcx, med12
mov r8, sum1
mov r9, ave1
push max1
push min1
call stats

mov rdx, std1
mov ecx, dword [ave1]
call std_f 

mov rdi, std1
call sqrt

mov rdi, list2
mov esi, dword [len2]
call sort

mov rdx, med21 
mov rcx, med22
mov r8, sum2
mov r9, ave2
push max2
push min2
call stats

mov rdx, std2
mov ecx, dword [ave2]
call std_f

mov rdi, std2
call sqrt


mov rdi, list3
mov esi, dword [len3]
call sort

mov rdx, med31 
mov rcx, med32
mov r8, sum3
mov r9, ave3
push max3
push min3
call stats

mov rdx, std3
mov ecx, dword [ave3]
call std_f

mov rdi, std3
call sqrt


last:
  mov rax, SYS_exit
  mov rdi, EXIT_SUCCESS
  syscall
