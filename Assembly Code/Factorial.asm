; ***********************************************************************
; *  File : Factorial.asm
; *  Author : Caroline Lee
; *  Description: computes factorial of n
; *  Register use: eax, ebx
; *	eax: n, ans
; *	ebx: n (for decrement loop)
; ***********************************************************************
        .386
        .MODEL FLAT
        ExitProcess PROTO NEAR32 stdcall, dwExitCode:DWORD
        PUBLIC _start   ; make procedure _start public
; ***********************************************************************
; *                     Data Segment                                 
; ***********************************************************************
	.DATA
	n DWORD 5
	ans DWORD ?

; ***********************************************************************
; *                     Stack Segment                                 
; ***********************************************************************
	.STACK  4096
; ***********************************************************************
; *                     Code Segment                                  
; ***********************************************************************
	.CODE

; *********************************************
; * factorial: takes parameter n and calculates factorial 
; * Parameters: n
; * Return value: eax = n
; * Register usage: eax = parameter, ebx = parameter(decremented in loop)
; *********************************************
factorial PROC NEAR32
	push ebp          ; establish function stack frame
	mov ebp, esp
	push eax		  ; push eax 
	push ebx		  ; push ebx
	pushfd			  ; push flags register
	mov eax, [ebp+8]  ; eax = parameter (n)
	mov ebx, [ebp+8]  ; ebx = parameter (n) for decrement

fact_loop:  cmp ebx, 1		; compare decrement variable to 1
			je exit         ; if variable == 1, exit loop
			imul eax, ebx	; n * variable
			dec ebx			; decrement variable
			jmp fact_loop   ; start loop again
exit:		

	popfd			; pop flags register
	pop ebx			; pop ebx
	mov esp, ebp	
	pop ebp			; restore ebp
	ret 

factorial ENDP

_start  PROC    NEAR32    ; start procedure called _start. Use flat, 32-bit address memory model
	

	mov eax, 0		; eax = 0
	mov ebx, n		; ebx = n (for 0 check)

	cmp n, eax	    ; compare n to 0
	jl exit   		; if n < 0, exit program

	mov ebx, 0		; ebx = 0
	push n 			; push n 
	call factorial  ; call function
	mov ans, eax    ; ans = eax


	       EVEN                 ; Make rest of code aligned on an even-addressed byte
exit:   INVOKE  ExitProcess, 0  ; like return( 0 ); in C
_start  ENDP                    ; end procedure _start
        END
