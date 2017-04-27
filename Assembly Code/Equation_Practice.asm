; ***********************************************************************
; *  File : Equation_Practice.asm
; *  Author : Caroline Lee
; *  Description: Computes this equation: -102 * x^4 + 11 * x^2* 6 + 55
; *  Register use:
; *	eax: 0, x, x4p, x2p, -102, a, b
; *	ebx: x, x4p, x2p, b
; *	ecx: 0 --> used in loops as counter, 6 
; ***********************************************************************
        .386
        .MODEL FLAT
        ExitProcess PROTO NEAR32 stdcall, dwExitCode:DWORD
        PUBLIC _start   ; make procedure _start public
; ***********************************************************************
; *                     Data Segment                                 
; ***********************************************************************
	.DATA
	x DWORD 2    ; store 2 in variable x
	x4p DWORD ?	 ; x^4
	x2p DWORD ?	 ; x^2
	a DWORD ?	 ; 102 * x4p
	b DWORD ?	 ; 11 * x2p * 6
	ans DWORD ?	 ; a + b

; ***********************************************************************
; *                     Stack Segment                                 
; ***********************************************************************
	.STACK  4096
; ***********************************************************************
; *                     Code Segment                                  
; ***********************************************************************
	.CODE
_start  PROC    NEAR32    ; start procedure called _start. Use flat, 32-bit address memory model

	;set registers
	mov eax, 0  ; eax = 0   
	mov ebx, x  ; ebx = x 
	mov ecx, 1  ; ecx = 1
	mov eax, ebx

powL: ;loop for exponent x^4 -> x4p
	imul ebx      ; eax = eax*ebx
	inc ecx       ; ecx + 1
	cmp ecx, 4    ; compare ecx and ebx
	jne powL	  ; if ecx != ebx, loop
				  ; when ecx = ebx, continue
	mov x4p, eax  ; x4p = eax

	;set registers again
	mov eax, 0  ; eax = 0	
	mov ebx, x  ; ebx = x
	mov ecx, 1  ; ecx = 1
	mov eax, ebx

	;exponent x^2 -> x2p
	imul ebx      ; eax = eax*ebx
	mov x2p, eax  ; x2p = eax

	;102 * x4p -> a
	mov eax, -102  ; eax = -102
	neg eax		   ; neg to track values easily
	mov ebx, x4p   ; ebx = x4p
	imul ebx       ; eax = eax * ebx
	mov a, eax     ; a = eax

	;11 * x2p * 6 -> b
	mov eax, 11  ; eax = 11
	mov ebx, x2p ; ebx = x2p
	mov ecx, 6   ; ecx = 6
	imul ebx     ; eax = eax * ebx
	imul ecx     ; eax = eax * ecx
	mov b, eax   ; b = eax

	;a + b + 55 -> ans
	mov eax, a   ; eax = a
	mov ebx, b   ; ebx = b
	sub eax, ebx ; eax = eax + ebx
	sub eax, 55  ; eax = eax + 55
	mov ans, eax ; ans = eax
	neg ans      ; put correct sign back




	       EVEN                 ; Make rest of code aligned on an even-addressed byte
exit:   INVOKE  ExitProcess, 0  ; like return( 0 ); in C
_start  ENDP                    ; end procedure _start
        END
