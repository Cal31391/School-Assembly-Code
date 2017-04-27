; ***********************************************************************
; *  File : MPG.asm
; *  Author : Caroline Lee
; *  Description: This program calculates miles per gallon
; *  Register use:
; *	eax: ax: value of miles, quotient
; *	ebx: bx: value of gallons
; *	ecx: 
; *	edx: dx: remainder 
; ***********************************************************************
        .386
        .MODEL FLAT
        ExitProcess PROTO NEAR32 stdcall, dwExitCode:DWORD
        PUBLIC _start   ; make procedure _start public
; ***********************************************************************
; *                     Data Segment                                 
; ***********************************************************************
	.DATA
	miles WORD 450 
	gallons WORD 12 
	mpg WORD ?

; ***********************************************************************
; *                     Stack Segment                                 
; ***********************************************************************
	.STACK  4096
; ***********************************************************************
; *                     Code Segment                                  
; ***********************************************************************
	.CODE
_start  PROC    NEAR32    ; start procedure called _start. Use flat, 32-bit address memory model

;set all registers to 0
	mov eax, 0
	mov ebx, 0
	mov ecx, 0
	mov edx, 0
	mov ax, miles    ; ax = value of miles
	mov bx, gallons  ; bx = value of gallons
	idiv bx          ; ax = miles/gallons
	mov mpg, ax      ; mpg = ax



	       EVEN                 ; Make rest of code aligned on an even-addressed byte
exit:   INVOKE  ExitProcess, 0  ; like return( 0 ); in C
_start  ENDP                    ; end procedure _start
        END
