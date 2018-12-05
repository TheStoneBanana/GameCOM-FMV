; ===========================================================================
		title   FreddyFreak
		type	8521
		org		4000h
; ---------------------------------------------------------------------------		
		NLIST
		include source/EQUATES.INC		; Equates
		LIST		
; ---------------------------------------------------------------------------		
		program	

; ===========================================================================	
		db      08h
		db      20h
		dw      EntryPoint
		db      00000011b           ;3
		dm      'TigerDMGC'
		db      36	         		;icon located bank no.
		db      0                  	;x_coord.
		db      160                 ;y_coord.
		dm      'FredFreak'			; Game Title
		dw      1A18h				; Game ID (just something random here)
		db      97h
		db      0
		dw      0
; ===========================================================================	
EntryPoint:
		clr     r0
		cmp     r2,#0			; is the Game.COM turning on from a cold boot?
		br      eq,GameInit		; if so, branch
		cmp     r2,#1			; has the game been entered from the main menu?
		jmp     eq,Game_Exe		; if so, branch
		cmp     r2,#2			; is the game being closed?
		br      eq,GameInit		; if so, branch
		cmp     r2,#3			; is the game being reset?
		br      eq,GameInit		; if so, branch
		mov     r0,#-1			; otherwise, indicate that none of the above conditions were able to be met
		ret				; return
; ---------------------------------------------------------------------------
GameInit:
		ret				; return, doing nothing
; ---------------------------------------------------------------------------		
Game_Reset:
Game_Exe:
		mov		FMV_Frame,#18		; set FMV frame to the very first frame stored
MainLoop:
		; wait for a while
		; (this is to do speed control, but is less than proper)
		call	WaitForVInt	
		call	WaitForVInt
		call	WaitForVInt
		call	WaitForVInt
		call	WaitForVInt	
		call	WaitForVInt
		call	WaitForVInt
		call	WaitForVInt
		call	WaitForVInt	
		call	WaitForVInt
		call	WaitForVInt
		call	WaitForVInt
		call	WaitForVInt	
		call	WaitForVInt
		call	WaitForVInt
		call	WaitForVInt
		
		mov		r8,#0
		mov		r9,#0
		mov		r10,#0
		mov		r11,#0
		mov		r12,#200			; Horizontal size
		mov		r13,#160			; Vertical size
		mov		r14,FMV_Frame		; Bank #
		mov		r15,#0				; Write mode
		call 	FBDrawGraphicF		
		
		add	FMV_Frame,#1			; increment the framecounter
		cmp	FMV_Frame,#47			; has the framecounter reached the max?
		br	ult,KeepGoing			; if not, branch
		mov	FMV_Frame,#18			; otherwise, set the frame to the beginning of the loop
KeepGoing:
		jmp	MainLoop

; ===========================================================================
; Subroutine to wait for a vertical interrupt
; ===========================================================================	
WaitForVInt:
		pushw	rr2					; store rr2 onto the stack
		push	r0					; store r0 onto the stack
		push	r1					; store r1 onto the stack

		movw	rr2,#0112h			; load the DMG_timer into rr2
		mov	r1, prevVtick			; load the previous V-Int tick into r1
		
WaitForVInt_Wait:
		mov	r0,	0(rr2)				; load the value of the timer into r0
		cmp	r0,	r1					; is the timer on the same tick as before?
		br	eq,	WaitForVInt_Wait	; if so, loop and wait
		
		mov	prevVtick,r0			; store the new V-Int tick

		pop	r1						; restore r1 from the stack		
		pop	r0						; restore r0 from the stack
		popw	rr2					; restore rr2 from the stack
		ret							; return
; ===========================================================================			
		
; ===========================================================================	
		include	source/SYSCALL.ASM
; ---------------------------------------------------------------------------
	end