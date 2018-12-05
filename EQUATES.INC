		data	
;============================================================================
; Zero Page Ram (0xBE-0xFF)
;----------------------------------------------------------------------------
		org	0BEh
FMV_Frame	defs	1	; the player's pressed buttons for the frame
prevVtick	defs	1
	
; Check to make sure that the space within zero page RAM hasn't been exceeded
chk_FF:
            if      chk_FF .gt. 0FFh
            error 	Too much data in zero page ram
            endif
;============================================================================
; Non-zero Page Ram (0x208-0x37F)
;----------------------------------------------------------------------------
		org	0208h
	
; Check to make sure that the space within zero page RAM hasn't been exceeded
chk_37F:
            if      chk_37F .gt. 037Fh
            error 	Too much data in non-zero page ram
            endif
;============================================================================  
; User Input Equates
;----------------------------------------------------------------------------
; For touch inputs...
; Value = Row*13+Column+1
; EXAMPLE: Top Left = 0x01, Bottom Right = 0x82

inputUp		equ	001h	; joypad up
inputDown	equ	002h	; joypad down
inputLeft	equ	004h	; joypad left
inputRight	equ	008h	; joypad right

inputMenu	equ	010h	; Menu button
inputSound	equ	040h	; Sound button
inputPause	equ	020h	; Pause button

inputA		equ	080h	; A button
inputB		equ	001h	; B button
inputC		equ	002h	; C button
inputD		equ	008h	; D button
;============================================================================