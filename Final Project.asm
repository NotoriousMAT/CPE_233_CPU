
;---------------------------------------------------------------------
; An expanded "draw_dot" program that includes subrountines to draw
; vertical lines, horizontal lines, and a full background. 
; 
; As written, this programs does the following: 
;   1) draws a the background blue (draws all the tiles)
;   2) draws a red dot
;   3) draws a red horizontal lines
;   4) draws a red vertical line
;
; Author: Bridget Benson 
; Modifications: bryan mealy
;---------------------------------------------------------------------

.CSEG
.ORG 0x10

.EQU VGA_HADD = 0x90
.EQU VGA_LADD = 0x91
.EQU VGA_COLOR = 0x92
.EQU KEYBOARD = 0x25
.EQU SSEG = 0x81
.EQU LEDS = 0x40

.EQU BG_COLOR       = 0xFF             ; Background:  blue
.EQU SNAKE_COLOR    = 0x00             ; Snake Color: white

.EQU OUTSIDE_FOR_COUNT = 0xBE
.EQU MIDDLE_FOR_COUNT = 0xBE
.EQU INSIDE_FOR_COUNT = 0xBE

;r6 is used for color
;r7 is used for Y
;r8 is used for X
;r9
;r10
;r11
;r12
;r13 snake length
;r14 storing and loading x-location
;r15 storing and loading y-location
;r16 SNAKE_COLOR
;r17 x-value
;r18 y-value
;r20,21,22 delay registers


;---------------------------------------------------------------------
;STORING CODE, INITIALIZES SNAKE
init:
         CALL   draw_background         ; draw using default color
		 MOV    r13, 0x0A
         MOV    r15, 0x01
		 MOV    r17, 0x00
         MOV    r18, 0x00

draw1:
         MOV    r14, r15
         SUB    r14, 0x01
         ST     r17, (r15)
         ST     r18, (r14)
         OUT    r17, VGA_HADD
         OUT    r18, VGA_LADD
         MOV    r16, SNAKE_COLOR
         OUT    r16, VGA_COLOR

move1:
        ADD     r15, 0x02
		CMP     r13, r15
		BRCS    delay0
		ADD		r18, 0x01
		BRN		draw1

delay0:		    MOV     R20, 0x02    ;Start delay
OUTSIDE_FOR0: 	SUB     R20, 0x01

		        MOV     R21, 0x02
MIDDLE_FOR0:  	SUB     R21, 0x01
             
				MOV     R22, 0x02
INSIDE_FOR0:  	SUB     R22, 0x01
				BRNE    INSIDE_FOR0
				OR      R21, 0x00
				BRNE    MIDDLE_FOR0
				OR      R20, 0x00
				BRNE    OUTSIDE_FOR0
				BRN	    init2			;Branch to next test


;SET SNAKE LENGTH
init2:
		 MOV    r13, 0x0A

;LOADING CODE, shift down
init3:
	     MOV    r15, 0x03
		 LD     r17, 0x01
		 LD     r18, 0x00
		 OUT    r17, VGA_HADD
         OUT    r18, VGA_LADD
         MOV    r16, BG_COLOR
         OUT    r16, VGA_COLOR 

draw2:
         MOV    r14, r15
		 MOV    r10, r15
		 MOV    r9,  r15
         SUB    r14, 0x01
		 SUB    r10, 0x02
		 SUB    r9,  0x03

         LD     r11, (r15)
         LD     r12, (r14)

		 ST     r11, (r10)
		 ST		r12, (r9)

move2:
        ADD     r15, 0x02
		CMP     r15, r13
		BRCC	draw_right1
		BRN 	draw2

draw_right1:
		LD     r12, (r14)

		ADD    r12, 0x01
		ST	   r12, (r14)

		LD     r17, (r15)
		LD     r18, (r14)
		OUT    r17, VGA_HADD
        OUT    r18, VGA_LADD
        MOV    r16, SNAKE_COLOR
        OUT    r16, VGA_COLOR 


delay1:		    MOV     R20, OUTSIDE_FOR_COUNT    ;Start delay
OUTSIDE_FOR1: 	SUB     R20, 0x01

		        MOV     R21, MIDDLE_FOR_COUNT
MIDDLE_FOR1:  	SUB     R21, 0x01
             
				MOV     R22, INSIDE_FOR_COUNT
INSIDE_FOR1:  	SUB     R22, 0x01
				BRNE    INSIDE_FOR1
				OR      R21, 0x00
				BRNE    MIDDLE_FOR1
				OR      R20, 0x00
				BRNE    OUTSIDE_FOR1
				BRN	    init3			;Branch to next test


				


;--------------------------------------------------------------------
;-  Subroutine: draw_horizontal_line
;-
;-  Draws a horizontal line from (r8,r7) to (r9,r7) using color in r6
;-
;-  Parameters:
;-   r8  = starting x-coordinate
;-   r7  = y-coordinate
;-   r9  = ending x-coordinate
;-   r6  = color used for line
;- 
;- Tweaked registers: r8,r9
;--------------------------------------------------------------------
draw_horizontal_line:
        ADD    r9,0x01          ; go from r8 to r15 inclusive

draw_horiz1:
        CALL   draw_dot         ; 
        ADD    r8,0x01
        CMP    r8,r9
        BRNE   draw_horiz1
        RET
;--------------------------------------------------------------------


;---------------------------------------------------------------------
;-  Subroutine: draw_vertical_line
;-
;-  Draws a horizontal line from (r8,r7) to (r8,r9) using color in r6
;-
;-  Parameters:
;-   r8  = x-coordinate
;-   r7  = starting y-coordinate
;-   r9  = ending y-coordinate
;-   r6  = color used for line
;- 
;- Tweaked registers: r7,r9
;--------------------------------------------------------------------
draw_vertical_line:
         ADD    r9,0x01

draw_vert1:          
         CALL   draw_dot
         ADD    r7,0x01
         CMP    r7,R9
         BRNE   draw_vert1
         RET
;--------------------------------------------------------------------

;---------------------------------------------------------------------
;-  Subroutine: draw_background
;-
;-  Fills the 30x40 grid with one color using successive calls to 
;-  draw_horizontal_line subroutine. 
;- 
;-  Tweaked registers: r13,r7,r8,r9
;----------------------------------------------------------------------
draw_background: 
         MOV   r6,BG_COLOR              ; use default color
         MOV   r13,0x00                 ; r13 keeps track of rows
start:   MOV   r7,r13                   ; load current row count 
         MOV   r8,0x00                  ; restart x coordinates
         MOV   r9,0x27 
 
         CALL  draw_horizontal_line
         ADD   r13,0x01                 ; increment row count
         CMP   r13,0x1D                 ; see if more rows to draw
         BRNE  start                    ; branch to draw more rows
         RET
;---------------------------------------------------------------------
    
;---------------------------------------------------------------------
;- Subrountine: draw_dot
;- 
;- This subroutine draws a dot on the display the given coordinates: 
;- 
;- (X,Y) = (r8,r7)  with a color stored in r6  
;- 
;- Tweaked registers: r4,r5
;---------------------------------------------------------------------
draw_dot: 
           MOV   r4,r7         ; copy Y coordinate
           MOV   r5,r8         ; copy X coordinate

           AND   r5,0x3F       ; make sure top 2 bits cleared
           AND   r4,0x1F       ; make sure top 3 bits cleared
           LSR   r4             ; need to get the bot 2 bits of r4 into sA
           BRCS  dd_add40
t1:        LSR   r4
           BRCS  dd_add80

dd_out:    OUT   r5,VGA_LADD   ; write bot 8 address bits to register
           OUT   r4,VGA_HADD   ; write top 3 address bits to register
           OUT   r6,VGA_COLOR  ; write data to frame buffer
           RET

dd_add40:  OR    r5,0x40       ; set bit if needed
           CLC                  ; freshen bit
           BRN   t1             

dd_add80:  OR    r5,0x80       ; set bit if needed
           BRN   dd_out
; --------------------------------------------------------------------

