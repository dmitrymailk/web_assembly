; y = 3 * a + b ^ 2

global calc_two_numbers_expression
global unit_test
global number_1
global number_2
global result
section	.text
calc_two_numbers_expression:
  ; call get_numbers_from_string
;--- arithmetic operations start ---  
;--- y = 3 * a + b ^ 2
; a = number_1
; b = number_2 
  mov eax, [number_1]
  mov ebx, 3
  mul ebx
  mov [result], eax

  mov eax, [number_2]
  mul eax
  add [result], eax
;--- arithmetic operations end ---  

;--- print result start ---  
  mov ebx, [result]
  mov [number], ebx
  call print_num_v2
;--- print result end ---  
; 1234 * 3 + 4321^2=18674743
ret

get_numbers_from_string:
  mov ebx, 0
  mov [decimal_num], ebx
;--- convert first number start ---
  mov ebx, number_a_len
  mov [number_len], ebx
  mov esi, 0
  char_to_decimal:
    mov [i], ebx
    ;--- number to decimal convertion 
      mov bl, [number_a + esi]
      sub bl, '0'
      ;--- method one starts
      mov eax, [decimal_num]
      mov ecx, 10
      mul ecx
      add eax, ebx
      mov [decimal_num], eax

      mov ebx, [i]
      dec ebx
      inc esi
      mov [i], ebx
      cmp ebx, 1
      jge char_to_decimal

      mov ebx, [decimal_num]
      mov [number_1], ebx
      mov ebx, 0
      mov [decimal_num], ebx
;--- convert first number end---

;--- print first num start---
  mov ebx, [number_1]
  mov [number], ebx
  call print_num_v2
;--- print first num end---

;--- convert second number start ---
  mov bx, number_b_len
  mov [number_len], bx
  mov esi, 0
  char_to_decimal_2:
    mov [i], ebx
    ;--- number to decimal convertion 
    mov bl, [number_b + esi]
    sub bl, '0'
    ;--- method one start
    mov eax, [decimal_num]
    mov ecx, 10
    mul ecx
    add eax, ebx
    mov [decimal_num], eax

    mov ebx, [i]
    dec ebx
    inc esi
    mov [i], ebx
    cmp ebx, 1
    jge char_to_decimal_2

  mov ebx, [decimal_num]
  mov [number_2], ebx
;--- convert second number end---
  
;--- print first num start---
  mov ebx, [number_2]
  mov [number], ebx
  call print_num_v2
;--- print first num end---
ret

exit:
  call print_newline
  mov	eax, 1
  mov ebx, 0
  int	0x80
  ret

print_num_v2:
  mov rax, [number]
  mov rcx, 0
  mov rbx, 10    
  mov rdi, number
  ; divide until we won't get zero
  .divideLoop:
    mov rdx, 0          
    div rbx           
    add rdx, '0'         
    push rdx             
    inc rcx             
    cmp rax, 0        
    jnz .divideLoop      
  mov [i], rcx

  .reverse:
    pop rax
    mov [edi], rax
    inc edi
    dec rcx
    cmp rcx, 0
    jnz .reverse
    mov byte [edi], 0
    mov byte [edi+1], 0xa
  
  mov rcx, number
  mov rdx, [i]
  call print
  ; we need to empty stack before returning
  ; amount of pushes must equals to pops
  call print_newline
  ; call clear
  mov rbx, 0
  mov [number], rbx
  ret

; help function for old print_num
power_10:
  mov ecx, 1
  mov ax, 1
  mov bx, 10
  cmp ecx, [number_len]  ; compare length with 1, because we can output one digit 
  je power_end ; if we have only one number we'll skip
  ; je power_end ; if we have only one number we'll skip
  power_loop:
    mul bx
    inc ecx
    cmp ecx, [number_len]
    jl power_loop
  power_end:
ret

print:
  mov	ebx, 1 ;file descriptor (stdout)
  mov	eax, 4 ;system call number (sys_write)
  int	0x80 ;call kernel
  ret

print_digit:
  mov ax, [digit]
  add ax, '0'
  mov [digit], ax
  mov ecx, digit
  mov edx, 1
  call print
  call print_delim
  ret

print_delim:
  mov ax, 35
  mov [digit], ax
  mov ecx, digit
  mov edx, 1
  call print
  ret

print_newline:
  mov ax, 10
  mov [digit], ax
  mov ecx, digit
  mov edx, 1
  call print
  ret


; program doesn't work for digits, it's only for numbers 
; old version, need number length
print_num:  
  mov bx, [number_len]
  cmp bx, 1
  je print_num_end
  call power_10
  mov [temp], ax
  mov bx, [temp]
  mov ax, [number]
  div bx
  mov [number], dx
  mov [digit], ax
  call print_digit
  mov dx, [number_len]
  cmp dx, 1
  jg print_num
  print_num_end:
  mov ax, [number]
  mov [digit], ax
  call print_digit
  ret

unit_test:
  ; mov ax, 10
  ; mov [digit], ax
  ; mov ecx, digit
  ; mov edx, 1
  ; mov	ebx, 1 ;file descriptor (stdout)
  ; mov	eax, 4 ;system call number (sys_write)
  ; int	0x80 ;call kernel
ret

section	.data
  msg db 'Start program', 0xa	
  len equ $ - msg		

  number_a db '1234'
  number_a_len equ $ - number_a		

  number_b db '4321'
  number_b_len equ $ - number_b		

  number dw 5678
  number_len db 3

segment .bss
  digit resb 5
  decimal_num resd 5
  i resb 1
  temp resb 5
  num resb 1
  
  number_1 resb 5
  number_2 resb 5
  result resb 5




  