section .text
global lstSum
lstSum:

mov r10, 0
mov eax, 0

sumLoop:
  add eax, dword [rdi + r10 * 4]
  inc r10
  cmp r10, rsi
  jne sumLoop

ret


global lstAverage
lstAverage:
  
mov r10, 0
mov eax, 0

avgLoop:
  add eax, dword [rdi + r10 * 4]
  inc r10
  cmp r10, rsi
  jne avgLoop

cqo
idiv rsi

ret


global print
print:

mov r10, 1
mov r11, 10

mov byte [rsi], '+'

cmp rdx, 0
jge pos
not rdi
inc rdi
mov byte [rsi], '-'
pos:


num_to_string:
  mov eax, edi
  cdq
  div r11
  add dl, '0'
  mov byte [rsi + r10], dl
  inc r10
  mov edi, eax
  cmp eax, 0
  jne num_to_string

mov r11, 1
push_string:
  mov rax, 0
  mov al, byte [rsi + r11]
  push rax
  inc r11
  cmp r11, r10
  jne push_string

mov r11, 1
pop_string:
  pop rax
  mov byte [rsi + r11], al
  inc r11
  cmp r11, r10
  jne pop_string
  mov byte [rsi + r11], 10
  inc r11
  mov byte [rsi + r11], 0

mov rax, 1
mov rdi, 1
mov rsi, rsi 
mov rdx, r11
syscall

ret
