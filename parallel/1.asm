section .data

MAX equ 1000000000

extern x
extern y
extern val0
extern val1

section .text
global thr0
thr0:

mov rcx, MAX
shr rcx, 1
mov r10, qword [x]
mov r11, qword [y]

loop_thr0:
  mov rax, qword [val0]
  cqo
  div r10
  add rax, r11
  mov qword [val0], rax
  dec rcx
  cmp rcx, 0
  jne loop_thr0

ret

global thr1
thr1:

mov rcx, MAX
shr rcx, 1
mov r10, qword [x]
mov r11, qword [y]

loop_thr1:
  mov rax, qword [val1]
  cqo
  div r10
  add rax, r11
  mov qword [val1], rax
  dec rcx
  cmp rcx, 0
  jne loop_thr1

ret
