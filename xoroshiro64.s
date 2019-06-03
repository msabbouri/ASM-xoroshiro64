;;;; 
;;;; xoroshiro64.s
;;;;
section .data

s0:         dd      137546 
s1:         dd      729 

buffer:     dd      0            

section .text
global next
global _start
_start:

    push rbp
    mov rbp, rsp

.loop:

    call next
    mov dword [buffer], eax ; Return value from next in eax

    mov rax, 1          ; Write syscall
    mov rdi, 1          ; Stdout
    mov rsi, buffer     ; Address 
    mov rdx, 4          ; Length
    syscall

    jmp .loop

    pop rbp

    mov rax, 60
    mov rdi, 0
    syscall

next: 
    ; Next function here. 

	mov eax, [s0]
	mov edi, 0x9E3779BB
	mul edi

	rol eax, 5
	mov esi, 5
	mul esi

	mov ebx, [s1]
	xor ebx, [s0]

	rol dword[s0], 26
	xor [s0], ebx
	shl ebx, 9
	xor [s0], ebx

	rol ebx, 13
	mov dword[s1], ebx
	
    ; Return results in eax.
    ret