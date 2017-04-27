; ***********************************************************************
; *  File : Sort_Array.asm
; *  Author : Caroline Lee
; *  Description: sorts an array of at most 10 elements
; *  Register use:
; *	eax: pointer for array location
; *	ebx: value in current array index, variable j
; *	ecx: value in current array index + 1
; *	edx: value of n in sort function
; ***********************************************************************
        .386
        .MODEL FLAT
        ExitProcess PROTO NEAR32 stdcall, dwExitCode:DWORD
        PUBLIC _start   ; make procedure _start public
; ***********************************************************************
; *                     Data Segment                                 
; ***********************************************************************
	.DATA
	n DWORD 10							;max array size
	array DWORD 2,1,3,4,8,5,10,9,6,7	;array initialization
	i DWORD 0							;increment variable
	num1 DWORD ?						;temp storage for ebx value in sort 
	num2 DWORD ?						;temp storage for ecx value in sort
	j DWORD 0							;counter for non-swaps in sort, used
										;to tell program when to finish, i.e.
										;when all numbers are in order
	offload DWORD ?						;temp storage for ebx(takes value j)
	
	

; ***********************************************************************
; *                     Stack Segment                                 
; ***********************************************************************
	.STACK  4096
; ***********************************************************************
; *                     Code Segment                                  
; ***********************************************************************
	.CODE

; *********************************************
; * swap: swaps two numbers if not a<b
; * Parameters: ecx, ebx (nums to be swapped)
; * Return value: ebx, ecx, (swapped nums)
; * Register usage: ebx, ecx
; *********************************************
swap PROC NEAR32
	push ebp   			;establish function stack frame
	mov ebp, esp
	pushfd				;push flags register
	
	inc j 				;j=j+1
	mov ebx, [ebp+8]	;ebx=first num to be swapped
	mov ecx, [ebp+12]	;ecx=second num to be swapped
	cmp ebx, ecx 		;compare ebx to ecx
	jL no_swap 			;if ebx<ecx, don't swap them


	xchg ebx, ecx 		;else, swap them
	mov j, 0 			;reset j to 0


no_swap:
	popfd			; pop flags register
	mov esp, ebp	
	pop ebp			; restore ebp
	ret 

swap ENDP

; *********************************************
; * sort: sorts elements in an array
; * Parameters: eax=pointer to array, edx=n
; * Return value: (changes array order by ref)
; * Register usage: eax, edx, ebx, ecx
; *********************************************
sort PROC NEAR32
	push ebp         	;establish function stack frame
	mov ebp, esp 			
	sub esp, 4 			;make room for local variable 
	pushfd			 	;push flags register
	
	mov ecx, 9 			;ecx=9(to give to local)
	mov [ebp-4], ecx 	;local=9
	mov eax, [ebp+12] 	;eax=pointer to array
	mov edx, [ebp+8] 	;edx=n
	dec edx

swap_loop:
	mov ebx, [eax] 		;ebx=array[i]
	mov ecx, [eax+4] 	;ecx=array[i+1]
	mov num1, ebx 		;num1=ebx(temp store number at index i)
	mov num2, ecx 		;num2=ecx(temp store number at index i+1)
	
	cmp i, edx 			;compare i to edx
	je reboot_prog  	;if i=edx(reach end of array), reboot program
	
	push ecx 			;param for swap function
	push ebx			;param for swap function
	call swap
	mov offload, ebx 	;offload=ebx(temp store value of ebx)
	mov ebx, j 			;ebx=j
	cmp [ebp-4], ebx 	;compare local to j
	je exit 			;if local=j, all nums are in order, exit sort function

	mov ebx, offload 	;put value in offload back in ebx
	mov [eax], ebx 		;array[i]=ebx
	mov [eax+4], ecx 	;array[i+1]=ecx
	inc i 				;increment i
	add eax, 4 			;move to next pair of nums in array, using pointer

	jmp swap_loop 		;do the swap_loop again

reboot_prog:
	mov i, 0 			;start from beginning of array again
	jmp _start 			;start program again
	


exit:
	popfd			;pop flags register
	mov esp, ebp	
	pop ebp			;restore ebp
	ret 

sort ENDP




_start  PROC    NEAR32    ;start procedure called _start. Use flat, 32-bit address memory model

	mov eax, 0
	mov ebx, 0
	mov ecx, 0
	mov edx, 0
	mov esi, 0
	lea esi, array 		;esi=mem address of array variable

	push esi
	push n
	call sort
	


	       EVEN                 ; Make rest of code aligned on an even-addressed byte
exit:   INVOKE  ExitProcess, 0  ; like return( 0 ); in C
_start  ENDP                    ; end procedure _start
        END
