section .data

EXIT_SUCCESS equ 0
SYS_exit equ 60
dword_pace equ 4

lst dd -15, 1235, -15, -20, 12, 42, 153, 124, 167, -14, 145, 13, -65, 14, 18
len dd 15
min dd 0
max dd 0
mid dd 0
sum dd 0
avg dd 0
med dd 0
med1_poz dd 0
med2_poz dd -1
neg_sum dd 0
neg_count dd 0
neg_avg dd 0
t_sum dd 0
t_count dd 0
t_avg dd 0


section .text
global _start
_start:

mov rsi, lst
mov ecx, 0
mov eax, [rsi]
mov dword [min], eax 
mov dword [max], eax 
mov dword [sum], eax

mov eax, dword [len]
mov edx, 0
mov r8d, 2
div r8d

cmp edx, 1
je non_even
mov dword [med2_poz], eax
dec eax
mov dword [med1_poz], eax
non_even:
  mov dword [med1_poz], eax

iterate:
  mov eax, dword [rsi + rcx * dword_pace]
  add dword [sum], eax
  
  cmp ecx, dword [med1_poz]
  jne non_med1
  mov dword [med], eax
  non_med1:

  cmp ecx, dword [med2_poz]
  jne non_med2
  add dword [med], eax
  non_med2:

  cmp eax, dword [min]
  jge nothing_min
  mov dword [min], eax
  nothing_min:

  cmp eax, dword [max]
  jle nothing_max
  mov dword [max], eax
  nothing_max

  cmp eax, 0
  jge non_negative
  inc dword [neg_count]
  add dword [neg_sum], eax
  non_negative:

  mov r9d, eax
  cdq
  mov r8d, 3
  idiv r8d
  cmp rdx, 0
  jne non_even_three
  inc dword [t_count]
  add dword [t_sum], r9d 
  non_even_three

  inc ecx
  cmp ecx, dword [len]
  jne iterate

mov eax, dword [sum]
cdq
idiv dword [len]
mov dword [avg], eax

cmp dword [med2_poz], -1
je non_odd
mov r8d, 2
mov eax, dword [med]
cdq
idiv r8d
mov dword [med], eax
non_odd:

mov eax, dword [neg_sum]
cdq
idiv dword [neg_count] 
mov dword [neg_avg], eax

mov eax, dword [t_sum]
cdq
idiv dword [t_count]
mov dword [t_avg], eax

last:
  mov rax, SYS_exit
  mov rdi, EXIT_SUCCESS
  syscall
