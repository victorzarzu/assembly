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


cdq
idiv rsi

ret
