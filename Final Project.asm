
.CSEG
.ORG 0x10

.EQU VGA_HADD = 0x90
.EQU VGA_LADD = 0x91
.EQU VGA_COLOR = 0x92
.EQU KEYBOARD = 0x25
.EQU SSEG = 0x82
.EQU LEDS = 0x40

.EQU VGA_READ_ID = 0x93
.EQU BUTTONS_ID  = 0x94

.EQU BG_COLOR       = 0x1C          ; Background:  blue
.EQU SNAKE_COLOR    = 0xF0          ; Snake Color: white
.EQU BLACK          = 0x00
.EQU FOOD_COLOR     = 0x0F			;

.EQU LEFT   = 0x01
.EQU RIGHT  = 0x02
.EQU UP     = 0x04
.EQU DOWN   = 0x08

.EQU OUTSIDE_FOR_COUNT = 0xBE		
.EQU MIDDLE_FOR_COUNT = 0xBE
.EQU INSIDE_FOR_COUNT = 0xBE


;r6 is used for color
;r7 is used for Y
;r8 is used for X
;r9 more x-location
;r10 more y-location
;r11 modifying x
;r12 modifying y
;r13 snake length
;r14 storing and loading x-location
;r15 storing and loading y-location
;r16 SNAKE_COLOR
;r17 x-value
;r18 y-value
;r20,21,22 delay registers
;r23 direction
;r24 r23 register
;r25 next head square color
;r26 score

;---------------------------------------------------------------------
;STORING CODE, INITIALIZES SNAKE
init:
;test stuff
		 
		 MOV    r7,  0x01				; initialize y-axis
		 MOV    r23, 0x02               ; start going right
         CALL   draw_background         ; draw using default color

		 MOV    r16, FOOD_COLOR
		 MOV    r17, 0x0D				; initialize snake y
         MOV    r18, 0x0D				; initialize snake x
		 OUT    r17, VGA_HADD
         OUT    r18, VGA_LADD
		 OUT    r16, VGA_COLOR

		 MOV    r17, 0x0D				; initialize snake y
         MOV    r18, 0x0A				; initialize snake x
		 OUT    r17, VGA_HADD
         OUT    r18, VGA_LADD
		 OUT    r16, VGA_COLOR

		 MOV    r17, 0x0E				; initialize snake y
         MOV    r18, 0x08				; initialize snake x
		 OUT    r17, VGA_HADD
         OUT    r18, VGA_LADD
		 OUT    r16, VGA_COLOR

		 MOV    r17, 0x08				; initialize snake y
         MOV    r18, 0x0E				; initialize snake x
		 OUT    r17, VGA_HADD
         OUT    r18, VGA_LADD
		 OUT    r16, VGA_COLOR

		 MOV    r13, 0x0A				; initializes snake size
         MOV    r15, 0x01				; initialize snake location in memory
		 MOV    r17, 0x0E				; initialize snake y
         MOV    r18, 0x0E				; initialize snake x

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
		BRCS    delay1
		ADD		r18, 0x01
		BRN		draw1

delay1:		    MOV     R20, 0x02    ;Start delay
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
				BRN	    init2			

;SET SNAKE LENGTH
init2:
		 MOV    r13, 0x0A
		 BRN    initRight

quit:    RET

;copying method from 0 to (r15)
draw:
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

move:
		ADD    r15, 0x02
		CMP    r15, r13
		BRCC   quit
		BRN    draw

copy:	MOV    r24, r23
		RET
				

;delay method
delay:		    MOV    r20, OUTSIDE_FOR_COUNT    ;Start delay
OUTSIDE_FOR: 	SUB    r20, 0x01

		        MOV    r21, MIDDLE_FOR_COUNT
MIDDLE_FOR:  	SUB    r21, 0x01
             
				MOV    r22, INSIDE_FOR_COUNT
INSIDE_FOR:  	SUB    r22, 0x01
				BRNE   INSIDE_FOR
				OR     r21, 0x00
				BRNE   MIDDLE_FOR
				OR     r20, 0x00
				BRNE   OUTSIDE_FOR
				IN     r23, BUTTONS_ID
				CMP    r23, 0x00
				BRNE   copy
				RET				

;modifying methods
KILL:	 		MOV    r0, 0xFF
				OUT    r0, LEDS
				BRN    KILL

GROW:			MOV    r16, SNAKE_COLOR		
				OUT    r16, VGA_COLOR
				ADD    r13, 0x02
				ADD	   r26, 0x01
				OUT    r26, SSEG
				CALL   delay
				
				CMP    r24, RIGHT
				BREQ draw_right_grow
				CMP    r24, LEFT
				BREQ draw_left_grow
				CMP    r24, UP
				BREQ draw_up_grow
				CMP    r24, DOWN
				BREQ draw_down_grow

				RET

draw_up_grow:
				LD     r11, (r15)
				LD     r12, (r14)

				SUB    r11, 0x01
				ADD    r15, 0x02
				ADD    r14, 0x02
				ST	   r11, (r15)
				ST     r12, (r14)
				OUT    r11, VGA_HADD
				OUT    r12, VGA_LADD
				OUT    r16, VGA_COLOR
				BRN    quit

draw_down_grow:
				LD     r11, (r15)
				LD     r12, (r14)

				ADD    r11, 0x01
				ADD    r15, 0x02
				ADD    r14, 0x02
				ST	   r11, (r15)
				ST     r12, (r14)
				OUT    r11, VGA_HADD
				OUT    r12, VGA_LADD
				OUT    r16, VGA_COLOR
				BRN    quit

draw_left_grow:
				LD     r11, (r15)
				LD     r12, (r14)

				SUB    r12, 0x01
				ADD    r15, 0x02
				ADD    r14, 0x02
				ST	   r11, (r15)
				ST     r12, (r14)
				OUT    r11, VGA_HADD
				OUT    r12, VGA_LADD
				OUT    r16, VGA_COLOR
				BRN    quit

draw_right_grow:
				LD     r11, (r15)
				LD     r12, (r14)

				ADD    r12, 0x01
				ADD    r15, 0x02
				ADD    r14, 0x02
				ST	   r11, (r15)
				ST     r12, (r14)
				OUT    r11, VGA_HADD
				OUT    r12, VGA_LADD
				OUT    r16, VGA_COLOR
				BRN    quit
		

;loading method
check_point:	
				LD     r17, (r15)
				LD     r18, (r14)
				OUT    r17, VGA_HADD
				OUT    r18, VGA_LADD		;LOAD ADDRESS
				
				IN     r25, VGA_READ_ID
				CMP    r25, BLACK
				BREQ   KILL
				CMP    r25, SNAKE_COLOR
				BREQ   KILL

				CMP    r25, FOOD_COLOR
				BREQ   GROW


				MOV    r16, SNAKE_COLOR		
				OUT    r16, VGA_COLOR

				RET


;LOADING CODE, move up
initUp:
	     MOV    r15, 0x03
		 LD     r17, 0x01
		 LD     r18, 0x00
		 OUT    r17, VGA_HADD
         OUT    r18, VGA_LADD
         MOV    r16, BG_COLOR
         OUT    r16, VGA_COLOR
		 CALL   draw


draw_up1:
		SUB     r15, 0x02
		LD     r11, (r15)

		SUB    r11, 0x01
		ST	   r11, (r15)

		CALL   check_point

		CALL   delay

		CMP     r24, LEFT
		BREQ    initLeft

		CMP     r24, RIGHT
		BREQ    initRight

		BRN	    initUp


;LOADING CODE, move dwon
initDown:
	     MOV    r15, 0x03
		 LD     r17, 0x01
		 LD     r18, 0x00
		 OUT    r17, VGA_HADD
         OUT    r18, VGA_LADD
         MOV    r16, BG_COLOR
         OUT    r16, VGA_COLOR 
		 CALL   draw

draw_down1:
		SUB     r15, 0x02
		LD     r11, (r15)

		ADD    r11, 0x01
		ST	   r11, (r15)

		CALL   check_point

		CALL   delay

		CMP     r24, LEFT
		BREQ    initLeft

		CMP     r24, RIGHT
		BREQ    initRight

		BRN	    initDown


;LOADING CODE, move left
initLeft:
	     MOV    r15, 0x03
		 LD     r17, 0x01
		 LD     r18, 0x00
		 OUT    r17, VGA_HADD
         OUT    r18, VGA_LADD
         MOV    r16, BG_COLOR
         OUT    r16, VGA_COLOR 
		 CALL   draw

draw_left1:
		SUB     r15, 0x02
		LD     r12, (r14)

		SUB    r12, 0x01
		ST	   r12, (r14)

		CALL   check_point

		CALL   delay

		CMP     r24, UP
		BREQ	initUp

		CMP     r24, DOWN
		BREQ    initDown

				BRN	    initLeft

;LOADING CODE, move right
initRight:
	     MOV    r15, 0x03
		 LD     r17, 0x01
		 LD     r18, 0x00
		 OUT    r17, VGA_HADD
         OUT    r18, VGA_LADD
         MOV    r16, BG_COLOR
         OUT    r16, VGA_COLOR 
		 CALL   draw

draw_right1:
		SUB     r15, 0x02
		LD     r12, (r14)

		ADD    r12, 0x01
		ST	   r12, (r14)

		CALL   check_point

		CALL   delay

		CMP     r24, UP
		BREQ	initUp

		CMP     r24, DOWN
		BREQ    initDown

		BRN	    initRight			;Branch to next test


				


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
				CALL   draw_dot         
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
         MOV   r13,0x01                 ; r13 keeps track of rows
start:   MOV   r7,r13                   ; load current row count 
         MOV   r8,0x02                  ; restart x coordinates
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

dd_out:    OUT   r5,VGA_LADD   ; write bot 8 address bits to register
           OUT   r4,VGA_HADD   ; write top 3 address bits to register
           OUT   r6,VGA_COLOR  ; write data to frame buffer
           RET

; --------------------------------------------------------------------

ISR:       
		   OUT   r23, LEDS
		   RETID

.CSEG
.ORG 0x3FF
VECTOR:   BRN ISR

