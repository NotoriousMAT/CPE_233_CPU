

List FileKey 
----------------------------------------------------------------------
C1      C2      C3      C4    || C5
--------------------------------------------------------------
C1:  Address (decimal) of instruction in source file. 
C2:  Segment (code or data) and address (in code or data segment) 
       of inforation associated with current linte. Note that not all
       source lines will contain information in this field.  
C3:  Opcode bits (this field only appears for valid instructions.
C4:  Data field; lists data for labels and assorted directives. 
C5:  Raw line from source code.
----------------------------------------------------------------------


(0001)                            || 
(0002)                            || .CSEG
(0003)                       016  || .ORG 0x10
(0004)                            || 
(0005)                       144  || .EQU VGA_HADD = 0x90
(0006)                       145  || .EQU VGA_LADD = 0x91
(0007)                       146  || .EQU VGA_COLOR = 0x92
(0008)                       037  || .EQU KEYBOARD = 0x25
(0009)                       130  || .EQU SSEG = 0x82
(0010)                       064  || .EQU LEDS = 0x40
(0011)                            || 
(0012)                       147  || .EQU VGA_READ_ID = 0x93
(0013)                       148  || .EQU BUTTONS_ID  = 0x94
(0014)                            || 
(0015)                       028  || .EQU BG_COLOR       = 0x1C          ; Background:  blue
(0016)                       240  || .EQU SNAKE_COLOR    = 0xF0          ; Snake Color: white
(0017)                       000  || .EQU BLACK          = 0x00
(0018)                       015  || .EQU FOOD_COLOR     = 0x0F			;
(0019)                            || 
(0020)                       001  || .EQU LEFT   = 0x01
(0021)                       002  || .EQU RIGHT  = 0x02
(0022)                       004  || .EQU UP     = 0x04
(0023)                       008  || .EQU DOWN   = 0x08
(0024)                            || 
(0025)                       190  || .EQU OUTSIDE_FOR_COUNT = 0xBE		
(0026)                       190  || .EQU MIDDLE_FOR_COUNT = 0xBE
(0027)                       190  || .EQU INSIDE_FOR_COUNT = 0xBE
(0028)                            || 
(0029)                            || 
(0030)                            || ;r6 is used for color
(0031)                            || ;r7 is used for Y
(0032)                            || ;r8 is used for X
(0033)                            || ;r9 more x-location
(0034)                            || ;r10 more y-location
(0035)                            || ;r11 modifying x
(0036)                            || ;r12 modifying y
(0037)                            || ;r13 snake length
(0038)                            || ;r14 storing and loading x-location
(0039)                            || ;r15 storing and loading y-location
(0040)                            || ;r16 SNAKE_COLOR
(0041)                            || ;r17 x-value
(0042)                            || ;r18 y-value
(0043)                            || ;r20,21,22 delay registers
(0044)                            || ;r23 direction
(0045)                            || ;r24 r23 register
(0046)                            || ;r25 next head square color
(0047)                            || ;r26 score
(0048)                            || 
(0049)                            || ;---------------------------------------------------------------------
(0050)                            || ;STORING CODE, INITIALIZES SNAKE
(0051)                     0x010  || init:
(0052)                            || ;test stuff
(0053)                            || 		 
(0054)  CS-0x010  0x36701         || 		 MOV    r7,  0x01				; initialize y-axis
(0055)  CS-0x011  0x37702         || 		 MOV    r23, 0x02               ; start going right
(0056)  CS-0x012  0x08859         ||          CALL   draw_background         ; draw using default color
(0057)                            || 
(0058)  CS-0x013  0x3700F         || 		 MOV    r16, FOOD_COLOR
(0059)  CS-0x014  0x3710D         || 		 MOV    r17, 0x0D				; initialize snake y
(0060)  CS-0x015  0x3720D         ||          MOV    r18, 0x0D				; initialize snake x
(0061)  CS-0x016  0x35190         || 		 OUT    r17, VGA_HADD
(0062)  CS-0x017  0x35291         ||          OUT    r18, VGA_LADD
(0063)  CS-0x018  0x35092         || 		 OUT    r16, VGA_COLOR
(0064)                            || 
(0065)  CS-0x019  0x3710D         || 		 MOV    r17, 0x0D				; initialize snake y
(0066)  CS-0x01A  0x3720A         ||          MOV    r18, 0x0A				; initialize snake x
(0067)  CS-0x01B  0x35190         || 		 OUT    r17, VGA_HADD
(0068)  CS-0x01C  0x35291         ||          OUT    r18, VGA_LADD
(0069)  CS-0x01D  0x35092         || 		 OUT    r16, VGA_COLOR
(0070)                            || 
(0071)  CS-0x01E  0x3710E         || 		 MOV    r17, 0x0E				; initialize snake y
(0072)  CS-0x01F  0x37208         ||          MOV    r18, 0x08				; initialize snake x
(0073)  CS-0x020  0x35190         || 		 OUT    r17, VGA_HADD
(0074)  CS-0x021  0x35291         ||          OUT    r18, VGA_LADD
(0075)  CS-0x022  0x35092         || 		 OUT    r16, VGA_COLOR
(0076)                            || 
(0077)  CS-0x023  0x37108         || 		 MOV    r17, 0x08				; initialize snake y
(0078)  CS-0x024  0x3720E         ||          MOV    r18, 0x0E				; initialize snake x
(0079)  CS-0x025  0x35190         || 		 OUT    r17, VGA_HADD
(0080)  CS-0x026  0x35291         ||          OUT    r18, VGA_LADD
(0081)  CS-0x027  0x35092         || 		 OUT    r16, VGA_COLOR
(0082)                            || 
(0083)  CS-0x028  0x36D0A         || 		 MOV    r13, 0x0A				; initializes snake size
(0084)  CS-0x029  0x36F01         ||          MOV    r15, 0x01				; initialize snake location in memory
(0085)  CS-0x02A  0x3710E         || 		 MOV    r17, 0x0E				; initialize snake y
(0086)  CS-0x02B  0x3720E         ||          MOV    r18, 0x0E				; initialize snake x
(0087)                            || 
(0088)                     0x02C  || draw1:
(0089)  CS-0x02C  0x04E79         ||          MOV    r14, r15
(0090)  CS-0x02D  0x2CE01         ||          SUB    r14, 0x01
(0091)  CS-0x02E  0x0517B         ||          ST     r17, (r15)
(0092)  CS-0x02F  0x05273         ||          ST     r18, (r14)
(0093)  CS-0x030  0x35190         ||          OUT    r17, VGA_HADD
(0094)  CS-0x031  0x35291         ||          OUT    r18, VGA_LADD
(0095)  CS-0x032  0x370F0         ||          MOV    r16, SNAKE_COLOR
(0096)  CS-0x033  0x35092         ||          OUT    r16, VGA_COLOR
(0097)                            || 
(0098)                     0x034  || move1:
(0099)  CS-0x034  0x28F02         ||         ADD     r15, 0x02
(0100)  CS-0x035  0x04D78         || 		CMP     r13, r15
(0101)  CS-0x036  0x0A1C8         || 		BRCS    delay1
(0102)  CS-0x037  0x29201         || 		ADD		r18, 0x01
(0103)  CS-0x038  0x08160         || 		BRN		draw1
(0104)                            || 
(0105)  CS-0x039  0x37402  0x039  || delay1:		    MOV     R20, 0x02    ;Start delay
(0106)  CS-0x03A  0x2D401  0x03A  || OUTSIDE_FOR0: 	SUB     R20, 0x01
(0107)                            || 
(0108)  CS-0x03B  0x37502         || 		        MOV     R21, 0x02
(0109)  CS-0x03C  0x2D501  0x03C  || MIDDLE_FOR0:  	SUB     R21, 0x01
(0110)                            ||              
(0111)  CS-0x03D  0x37602         || 				MOV     R22, 0x02
(0112)  CS-0x03E  0x2D601  0x03E  || INSIDE_FOR0:  	SUB     R22, 0x01
(0113)  CS-0x03F  0x081F3         || 				BRNE    INSIDE_FOR0
(0114)  CS-0x040  0x23500         || 				OR      R21, 0x00
(0115)  CS-0x041  0x081E3         || 				BRNE    MIDDLE_FOR0
(0116)  CS-0x042  0x23400         || 				OR      R20, 0x00
(0117)  CS-0x043  0x081D3         || 				BRNE    OUTSIDE_FOR0
(0118)  CS-0x044  0x08228         || 				BRN	    init2			
(0119)                            || 
(0120)                            || ;SET SNAKE LENGTH
(0121)                     0x045  || init2:
(0122)  CS-0x045  0x36D0A         || 		 MOV    r13, 0x0A
(0123)  CS-0x046  0x08760         || 		 BRN    initRight
(0124)                            || 
(0125)  CS-0x047  0x18002  0x047  || quit:    RET
(0126)                            || 
(0127)                            || ;copying method from 0 to (r15)
(0128)                     0x048  || draw:
(0129)  CS-0x048  0x04E79         ||          MOV    r14, r15
(0130)  CS-0x049  0x04A79         || 		 MOV    r10, r15
(0131)  CS-0x04A  0x04979         || 		 MOV    r9,  r15
(0132)  CS-0x04B  0x2CE01         ||          SUB    r14, 0x01
(0133)  CS-0x04C  0x2CA02         || 		 SUB    r10, 0x02
(0134)  CS-0x04D  0x2C903         || 		 SUB    r9,  0x03
(0135)                            || 
(0136)  CS-0x04E  0x04B7A         ||          LD     r11, (r15)
(0137)  CS-0x04F  0x04C72         ||          LD     r12, (r14)
(0138)                            || 
(0139)  CS-0x050  0x04B53         || 		 ST     r11, (r10)
(0140)  CS-0x051  0x04C4B         || 		 ST		r12, (r9)
(0141)                            || 
(0142)                     0x052  || move:
(0143)  CS-0x052  0x28F02         || 		ADD    r15, 0x02
(0144)  CS-0x053  0x04F68         || 		CMP    r15, r13
(0145)  CS-0x054  0x0A239         || 		BRCC   quit
(0146)  CS-0x055  0x08240         || 		BRN    draw
(0147)                            || 
(0148)  CS-0x056  0x058B9  0x056  || copy:	MOV    r24, r23
(0149)  CS-0x057  0x18002         || 		RET
(0150)                            || 				
(0151)                            || 
(0152)                            || ;delay method
(0153)  CS-0x058  0x374BE  0x058  || delay:		    MOV    r20, OUTSIDE_FOR_COUNT    ;Start delay
(0154)  CS-0x059  0x2D401  0x059  || OUTSIDE_FOR: 	SUB    r20, 0x01
(0155)                            || 
(0156)  CS-0x05A  0x375BE         || 		        MOV    r21, MIDDLE_FOR_COUNT
(0157)  CS-0x05B  0x2D501  0x05B  || MIDDLE_FOR:  	SUB    r21, 0x01
(0158)                            ||              
(0159)  CS-0x05C  0x376BE         || 				MOV    r22, INSIDE_FOR_COUNT
(0160)  CS-0x05D  0x2D601  0x05D  || INSIDE_FOR:  	SUB    r22, 0x01
(0161)  CS-0x05E  0x082EB         || 				BRNE   INSIDE_FOR
(0162)  CS-0x05F  0x23500         || 				OR     r21, 0x00
(0163)  CS-0x060  0x082DB         || 				BRNE   MIDDLE_FOR
(0164)  CS-0x061  0x23400         || 				OR     r20, 0x00
(0165)  CS-0x062  0x082CB         || 				BRNE   OUTSIDE_FOR
(0166)  CS-0x063  0x33794         || 				IN     r23, BUTTONS_ID
(0167)  CS-0x064  0x31700         || 				CMP    r23, 0x00
(0168)  CS-0x065  0x082B3         || 				BRNE   copy
(0169)  CS-0x066  0x18002         || 				RET				
(0170)                            || 
(0171)                            || ;modifying methods
(0172)  CS-0x067  0x360FF  0x067  || KILL:	 		MOV    r0, 0xFF
(0173)  CS-0x068  0x34040         || 				OUT    r0, LEDS
(0174)  CS-0x069  0x08338         || 				BRN    KILL
(0175)                            || 
(0176)  CS-0x06A  0x370F0  0x06A  || GROW:			MOV    r16, SNAKE_COLOR		
(0177)  CS-0x06B  0x35092         || 				OUT    r16, VGA_COLOR
(0178)  CS-0x06C  0x28D02         || 				ADD    r13, 0x02
(0179)  CS-0x06D  0x29A01         || 				ADD	   r26, 0x01
(0180)  CS-0x06E  0x35A82         || 				OUT    r26, SSEG
(0181)  CS-0x06F  0x082C1         || 				CALL   delay
(0182)                            || 				
(0183)  CS-0x070  0x31802         || 				CMP    r24, RIGHT
(0184)  CS-0x071  0x084D2         || 				BREQ draw_right_grow
(0185)  CS-0x072  0x31801         || 				CMP    r24, LEFT
(0186)  CS-0x073  0x0847A         || 				BREQ draw_left_grow
(0187)  CS-0x074  0x31804         || 				CMP    r24, UP
(0188)  CS-0x075  0x083CA         || 				BREQ draw_up_grow
(0189)  CS-0x076  0x31808         || 				CMP    r24, DOWN
(0190)  CS-0x077  0x08422         || 				BREQ draw_down_grow
(0191)                            || 
(0192)  CS-0x078  0x18002         || 				RET
(0193)                            || 
(0194)                     0x079  || draw_up_grow:
(0195)  CS-0x079  0x04B7A         || 				LD     r11, (r15)
(0196)  CS-0x07A  0x04C72         || 				LD     r12, (r14)
(0197)                            || 
(0198)  CS-0x07B  0x2CB01         || 				SUB    r11, 0x01
(0199)  CS-0x07C  0x28F02         || 				ADD    r15, 0x02
(0200)  CS-0x07D  0x28E02         || 				ADD    r14, 0x02
(0201)  CS-0x07E  0x04B7B         || 				ST	   r11, (r15)
(0202)  CS-0x07F  0x04C73         || 				ST     r12, (r14)
(0203)  CS-0x080  0x34B90         || 				OUT    r11, VGA_HADD
(0204)  CS-0x081  0x34C91         || 				OUT    r12, VGA_LADD
(0205)  CS-0x082  0x35092         || 				OUT    r16, VGA_COLOR
(0206)  CS-0x083  0x08238         || 				BRN    quit
(0207)                            || 
(0208)                     0x084  || draw_down_grow:
(0209)  CS-0x084  0x04B7A         || 				LD     r11, (r15)
(0210)  CS-0x085  0x04C72         || 				LD     r12, (r14)
(0211)                            || 
(0212)  CS-0x086  0x28B01         || 				ADD    r11, 0x01
(0213)  CS-0x087  0x28F02         || 				ADD    r15, 0x02
(0214)  CS-0x088  0x28E02         || 				ADD    r14, 0x02
(0215)  CS-0x089  0x04B7B         || 				ST	   r11, (r15)
(0216)  CS-0x08A  0x04C73         || 				ST     r12, (r14)
(0217)  CS-0x08B  0x34B90         || 				OUT    r11, VGA_HADD
(0218)  CS-0x08C  0x34C91         || 				OUT    r12, VGA_LADD
(0219)  CS-0x08D  0x35092         || 				OUT    r16, VGA_COLOR
(0220)  CS-0x08E  0x08238         || 				BRN    quit
(0221)                            || 
(0222)                     0x08F  || draw_left_grow:
(0223)  CS-0x08F  0x04B7A         || 				LD     r11, (r15)
(0224)  CS-0x090  0x04C72         || 				LD     r12, (r14)
(0225)                            || 
(0226)  CS-0x091  0x2CC01         || 				SUB    r12, 0x01
(0227)  CS-0x092  0x28F02         || 				ADD    r15, 0x02
(0228)  CS-0x093  0x28E02         || 				ADD    r14, 0x02
(0229)  CS-0x094  0x04B7B         || 				ST	   r11, (r15)
(0230)  CS-0x095  0x04C73         || 				ST     r12, (r14)
(0231)  CS-0x096  0x34B90         || 				OUT    r11, VGA_HADD
(0232)  CS-0x097  0x34C91         || 				OUT    r12, VGA_LADD
(0233)  CS-0x098  0x35092         || 				OUT    r16, VGA_COLOR
(0234)  CS-0x099  0x08238         || 				BRN    quit
(0235)                            || 
(0236)                     0x09A  || draw_right_grow:
(0237)  CS-0x09A  0x04B7A         || 				LD     r11, (r15)
(0238)  CS-0x09B  0x04C72         || 				LD     r12, (r14)
(0239)                            || 
(0240)  CS-0x09C  0x28C01         || 				ADD    r12, 0x01
(0241)  CS-0x09D  0x28F02         || 				ADD    r15, 0x02
(0242)  CS-0x09E  0x28E02         || 				ADD    r14, 0x02
(0243)  CS-0x09F  0x04B7B         || 				ST	   r11, (r15)
(0244)  CS-0x0A0  0x04C73         || 				ST     r12, (r14)
(0245)  CS-0x0A1  0x34B90         || 				OUT    r11, VGA_HADD
(0246)  CS-0x0A2  0x34C91         || 				OUT    r12, VGA_LADD
(0247)  CS-0x0A3  0x35092         || 				OUT    r16, VGA_COLOR
(0248)  CS-0x0A4  0x08238         || 				BRN    quit
(0249)                            || 		
(0250)                            || 
(0251)                            || ;loading method
(0252)                     0x0A5  || check_point:	
(0253)  CS-0x0A5  0x0517A         || 				LD     r17, (r15)
(0254)  CS-0x0A6  0x05272         || 				LD     r18, (r14)
(0255)  CS-0x0A7  0x35190         || 				OUT    r17, VGA_HADD
(0256)  CS-0x0A8  0x35291         || 				OUT    r18, VGA_LADD		;LOAD ADDRESS
(0257)                            || 				
(0258)  CS-0x0A9  0x33993         || 				IN     r25, VGA_READ_ID
(0259)  CS-0x0AA  0x31900         || 				CMP    r25, BLACK
(0260)  CS-0x0AB  0x0833A         || 				BREQ   KILL
(0261)  CS-0x0AC  0x319F0         || 				CMP    r25, SNAKE_COLOR
(0262)  CS-0x0AD  0x0833A         || 				BREQ   KILL
(0263)                            || 
(0264)  CS-0x0AE  0x3190F         || 				CMP    r25, FOOD_COLOR
(0265)  CS-0x0AF  0x08352         || 				BREQ   GROW
(0266)                            || 
(0267)                            || 
(0268)  CS-0x0B0  0x370F0         || 				MOV    r16, SNAKE_COLOR		
(0269)  CS-0x0B1  0x35092         || 				OUT    r16, VGA_COLOR
(0270)                            || 
(0271)  CS-0x0B2  0x18002         || 				RET
(0272)                            || 
(0273)                            || 
(0274)                            || ;LOADING CODE, move up
(0275)                     0x0B3  || initUp:
(0276)  CS-0x0B3  0x36F03         || 	     MOV    r15, 0x03
(0277)  CS-0x0B4  0x39101         || 		 LD     r17, 0x01
(0278)  CS-0x0B5  0x39200         || 		 LD     r18, 0x00
(0279)  CS-0x0B6  0x35190         || 		 OUT    r17, VGA_HADD
(0280)  CS-0x0B7  0x35291         ||          OUT    r18, VGA_LADD
(0281)  CS-0x0B8  0x3701C         ||          MOV    r16, BG_COLOR
(0282)  CS-0x0B9  0x35092         ||          OUT    r16, VGA_COLOR
(0283)  CS-0x0BA  0x08241         || 		 CALL   draw
(0284)                            || 
(0285)                            || 
(0286)                     0x0BB  || draw_up1:
(0287)  CS-0x0BB  0x2CF02         || 		SUB     r15, 0x02
(0288)  CS-0x0BC  0x04B7A         || 		LD     r11, (r15)
(0289)                            || 
(0290)  CS-0x0BD  0x2CB01         || 		SUB    r11, 0x01
(0291)  CS-0x0BE  0x04B7B         || 		ST	   r11, (r15)
(0292)                            || 
(0293)  CS-0x0BF  0x08529         || 		CALL   check_point
(0294)                            || 
(0295)  CS-0x0C0  0x082C1         || 		CALL   delay
(0296)                            || 
(0297)  CS-0x0C1  0x31801         || 		CMP     r24, LEFT
(0298)  CS-0x0C2  0x086CA         || 		BREQ    initLeft
(0299)                            || 
(0300)  CS-0x0C3  0x31802         || 		CMP     r24, RIGHT
(0301)  CS-0x0C4  0x08762         || 		BREQ    initRight
(0302)                            || 
(0303)  CS-0x0C5  0x08598         || 		BRN	    initUp
(0304)                            || 
(0305)                            || 
(0306)                            || ;LOADING CODE, move dwon
(0307)                     0x0C6  || initDown:
(0308)  CS-0x0C6  0x36F03         || 	     MOV    r15, 0x03
(0309)  CS-0x0C7  0x39101         || 		 LD     r17, 0x01
(0310)  CS-0x0C8  0x39200         || 		 LD     r18, 0x00
(0311)  CS-0x0C9  0x35190         || 		 OUT    r17, VGA_HADD
(0312)  CS-0x0CA  0x35291         ||          OUT    r18, VGA_LADD
(0313)  CS-0x0CB  0x3701C         ||          MOV    r16, BG_COLOR
(0314)  CS-0x0CC  0x35092         ||          OUT    r16, VGA_COLOR 
(0315)  CS-0x0CD  0x08241         || 		 CALL   draw
(0316)                            || 
(0317)                     0x0CE  || draw_down1:
(0318)  CS-0x0CE  0x2CF02         || 		SUB     r15, 0x02
(0319)  CS-0x0CF  0x04B7A         || 		LD     r11, (r15)
(0320)                            || 
(0321)  CS-0x0D0  0x28B01         || 		ADD    r11, 0x01
(0322)  CS-0x0D1  0x04B7B         || 		ST	   r11, (r15)
(0323)                            || 
(0324)  CS-0x0D2  0x08529         || 		CALL   check_point
(0325)                            || 
(0326)  CS-0x0D3  0x082C1         || 		CALL   delay
(0327)                            || 
(0328)  CS-0x0D4  0x31801         || 		CMP     r24, LEFT
(0329)  CS-0x0D5  0x086CA         || 		BREQ    initLeft
(0330)                            || 
(0331)  CS-0x0D6  0x31802         || 		CMP     r24, RIGHT
(0332)  CS-0x0D7  0x08762         || 		BREQ    initRight
(0333)                            || 
(0334)  CS-0x0D8  0x08630         || 		BRN	    initDown
(0335)                            || 
(0336)                            || 
(0337)                            || ;LOADING CODE, move left
(0338)                     0x0D9  || initLeft:
(0339)  CS-0x0D9  0x36F03         || 	     MOV    r15, 0x03
(0340)  CS-0x0DA  0x39101         || 		 LD     r17, 0x01
(0341)  CS-0x0DB  0x39200         || 		 LD     r18, 0x00
(0342)  CS-0x0DC  0x35190         || 		 OUT    r17, VGA_HADD
(0343)  CS-0x0DD  0x35291         ||          OUT    r18, VGA_LADD
(0344)  CS-0x0DE  0x3701C         ||          MOV    r16, BG_COLOR
(0345)  CS-0x0DF  0x35092         ||          OUT    r16, VGA_COLOR 
(0346)  CS-0x0E0  0x08241         || 		 CALL   draw
(0347)                            || 
(0348)                     0x0E1  || draw_left1:
(0349)  CS-0x0E1  0x2CF02         || 		SUB     r15, 0x02
(0350)  CS-0x0E2  0x04C72         || 		LD     r12, (r14)
(0351)                            || 
(0352)  CS-0x0E3  0x2CC01         || 		SUB    r12, 0x01
(0353)  CS-0x0E4  0x04C73         || 		ST	   r12, (r14)
(0354)                            || 
(0355)  CS-0x0E5  0x08529         || 		CALL   check_point
(0356)                            || 
(0357)  CS-0x0E6  0x082C1         || 		CALL   delay
(0358)                            || 
(0359)  CS-0x0E7  0x31804         || 		CMP     r24, UP
(0360)  CS-0x0E8  0x0859A         || 		BREQ	initUp
(0361)                            || 
(0362)  CS-0x0E9  0x31808         || 		CMP     r24, DOWN
(0363)  CS-0x0EA  0x08632         || 		BREQ    initDown
(0364)                            || 
(0365)  CS-0x0EB  0x086C8         || 				BRN	    initLeft
(0366)                            || 
(0367)                            || ;LOADING CODE, move right
(0368)                     0x0EC  || initRight:
(0369)  CS-0x0EC  0x36F03         || 	     MOV    r15, 0x03
(0370)  CS-0x0ED  0x39101         || 		 LD     r17, 0x01
(0371)  CS-0x0EE  0x39200         || 		 LD     r18, 0x00
(0372)  CS-0x0EF  0x35190         || 		 OUT    r17, VGA_HADD
(0373)  CS-0x0F0  0x35291         ||          OUT    r18, VGA_LADD
(0374)  CS-0x0F1  0x3701C         ||          MOV    r16, BG_COLOR
(0375)  CS-0x0F2  0x35092         ||          OUT    r16, VGA_COLOR 
(0376)  CS-0x0F3  0x08241         || 		 CALL   draw
(0377)                            || 
(0378)                     0x0F4  || draw_right1:
(0379)  CS-0x0F4  0x2CF02         || 		SUB     r15, 0x02
(0380)  CS-0x0F5  0x04C72         || 		LD     r12, (r14)
(0381)                            || 
(0382)  CS-0x0F6  0x28C01         || 		ADD    r12, 0x01
(0383)  CS-0x0F7  0x04C73         || 		ST	   r12, (r14)
(0384)                            || 
(0385)  CS-0x0F8  0x08529         || 		CALL   check_point
(0386)                            || 
(0387)  CS-0x0F9  0x082C1         || 		CALL   delay
(0388)                            || 
(0389)  CS-0x0FA  0x31804         || 		CMP     r24, UP
(0390)  CS-0x0FB  0x0859A         || 		BREQ	initUp
(0391)                            || 
(0392)  CS-0x0FC  0x31808         || 		CMP     r24, DOWN
(0393)  CS-0x0FD  0x08632         || 		BREQ    initDown
(0394)                            || 
(0395)  CS-0x0FE  0x08760         || 		BRN	    initRight			;Branch to next test
(0396)                            || 
(0397)                            || 
(0398)                            || 				
(0399)                            || 
(0400)                            || 
(0401)                            || ;--------------------------------------------------------------------
(0402)                            || ;-  Subroutine: draw_horizontal_line
(0403)                            || ;-
(0404)                            || ;-  Draws a horizontal line from (r8,r7) to (r9,r7) using color in r6
(0405)                            || ;-
(0406)                            || ;-  Parameters:
(0407)                            || ;-   r8  = starting x-coordinate
(0408)                            || ;-   r7  = y-coordinate
(0409)                            || ;-   r9  = ending x-coordinate
(0410)                            || ;-   r6  = color used for line
(0411)                            || ;- 
(0412)                            || ;- Tweaked registers: r8,r9
(0413)                            || ;--------------------------------------------------------------------
(0414)                     0x0FF  || draw_horizontal_line:
(0415)  CS-0x0FF  0x28901         || 				ADD    r9,0x01          ; go from r8 to r15 inclusive
(0416)                            || 
(0417)                     0x100  || draw_horiz1:
(0418)  CS-0x100  0x088A9         || 				CALL   draw_dot         
(0419)  CS-0x101  0x28801         || 				ADD    r8,0x01
(0420)  CS-0x102  0x04848         || 				CMP    r8,r9
(0421)  CS-0x103  0x08803         || 				BRNE   draw_horiz1
(0422)                            || 
(0423)  CS-0x104  0x18002         || 				RET
(0424)                            || ;--------------------------------------------------------------------
(0425)                            || 
(0426)                            || 
(0427)                            || ;---------------------------------------------------------------------
(0428)                            || ;-  Subroutine: draw_vertical_line
(0429)                            || ;-
(0430)                            || ;-  Draws a horizontal line from (r8,r7) to (r8,r9) using color in r6
(0431)                            || ;-
(0432)                            || ;-  Parameters:
(0433)                            || ;-   r8  = x-coordinate
(0434)                            || ;-   r7  = starting y-coordinate
(0435)                            || ;-   r9  = ending y-coordinate
(0436)                            || ;-   r6  = color used for line
(0437)                            || ;- 
(0438)                            || ;- Tweaked registers: r7,r9
(0439)                            || ;--------------------------------------------------------------------
(0440)                     0x105  || draw_vertical_line:
(0441)  CS-0x105  0x28901         ||          ADD    r9,0x01
(0442)                            || 
(0443)                     0x106  || draw_vert1:          
(0444)  CS-0x106  0x088A9         ||          CALL   draw_dot
(0445)  CS-0x107  0x28701         ||          ADD    r7,0x01
(0446)  CS-0x108  0x04748         ||          CMP    r7,R9
(0447)  CS-0x109  0x08833         ||          BRNE   draw_vert1
(0448)  CS-0x10A  0x18002         ||          RET
(0449)                            || ;--------------------------------------------------------------------
(0450)                            || 
(0451)                            || ;---------------------------------------------------------------------
(0452)                            || ;-  Subroutine: draw_background
(0453)                            || ;-
(0454)                            || ;-  Fills the 30x40 grid with one color using successive calls to 
(0455)                            || ;-  draw_horizontal_line subroutine. 
(0456)                            || ;- 
(0457)                            || ;-  Tweaked registers: r13,r7,r8,r9
(0458)                            || ;----------------------------------------------------------------------
(0459)                     0x10B  || draw_background: 
(0460)  CS-0x10B  0x3661C         ||          MOV   r6,BG_COLOR              ; use default color
(0461)  CS-0x10C  0x36D01         ||          MOV   r13,0x01                 ; r13 keeps track of rows
(0462)  CS-0x10D  0x04769  0x10D  || start:   MOV   r7,r13                   ; load current row count 
(0463)  CS-0x10E  0x36802         ||          MOV   r8,0x02                  ; restart x coordinates
(0464)  CS-0x10F  0x36927         ||          MOV   r9,0x27 
(0465)                            ||  
(0466)  CS-0x110  0x087F9         ||          CALL  draw_horizontal_line
(0467)  CS-0x111  0x28D01         ||          ADD   r13,0x01                 ; increment row count
(0468)  CS-0x112  0x30D1D         ||          CMP   r13,0x1D                 ; see if more rows to draw
(0469)  CS-0x113  0x0886B         ||          BRNE  start                    ; branch to draw more rows
(0470)  CS-0x114  0x18002         ||          RET
(0471)                            || ;---------------------------------------------------------------------
(0472)                            ||     
(0473)                            || ;---------------------------------------------------------------------
(0474)                            || ;- Subrountine: draw_dot
(0475)                            || ;- 
(0476)                            || ;- This subroutine draws a dot on the display the given coordinates: 
(0477)                            || ;- 
(0478)                            || ;- (X,Y) = (r8,r7)  with a color stored in r6  
(0479)                            || ;- 
(0480)                            || ;- Tweaked registers: r4,r5
(0481)                            || ;---------------------------------------------------------------------
(0482)                     0x115  || draw_dot: 
(0483)  CS-0x115  0x04439         ||            MOV   r4,r7         ; copy Y coordinate
(0484)  CS-0x116  0x04541         ||            MOV   r5,r8         ; copy X coordinate
(0485)                            || 
(0486)  CS-0x117  0x34591  0x117  || dd_out:    OUT   r5,VGA_LADD   ; write bot 8 address bits to register
(0487)  CS-0x118  0x34490         ||            OUT   r4,VGA_HADD   ; write top 3 address bits to register
(0488)  CS-0x119  0x34692         ||            OUT   r6,VGA_COLOR  ; write data to frame buffer
(0489)  CS-0x11A  0x18002         ||            RET
(0490)                            || 
(0491)                            || ; --------------------------------------------------------------------
(0492)                            || 
(0493)                     0x11B  || ISR:       
(0494)  CS-0x11B  0x35740         || 		   OUT   r23, LEDS
(0495)  CS-0x11C  0x1A002         || 		   RETID
(0496)                            || 
(0497)                            || .CSEG
(0498)                       1023  || .ORG 0x3FF
(0499)  CS-0x3FF  0x088D8  0x3FF  || VECTOR:   BRN ISR
(0500)                            || 





Symbol Table Key 
----------------------------------------------------------------------
C1             C2     C3      ||  C4+
-------------  ----   ----        -------
C1:  name of symbol
C2:  the value of symbol 
C3:  source code line number where symbol defined
C4+: source code line number of where symbol is referenced 
----------------------------------------------------------------------


-- Labels
------------------------------------------------------------ 
CHECK_POINT    0x0A5   (0252)  ||  0293 0324 0355 0385 
COPY           0x056   (0148)  ||  0168 
DD_OUT         0x117   (0486)  ||  
DELAY          0x058   (0153)  ||  0181 0295 0326 0357 0387 
DELAY1         0x039   (0105)  ||  0101 
DRAW           0x048   (0128)  ||  0146 0283 0315 0346 0376 
DRAW1          0x02C   (0088)  ||  0103 
DRAW_BACKGROUND 0x10B   (0459)  ||  0056 
DRAW_DOT       0x115   (0482)  ||  0418 0444 
DRAW_DOWN1     0x0CE   (0317)  ||  
DRAW_DOWN_GROW 0x084   (0208)  ||  0190 
DRAW_HORIZ1    0x100   (0417)  ||  0421 
DRAW_HORIZONTAL_LINE 0x0FF   (0414)  ||  0466 
DRAW_LEFT1     0x0E1   (0348)  ||  
DRAW_LEFT_GROW 0x08F   (0222)  ||  0186 
DRAW_RIGHT1    0x0F4   (0378)  ||  
DRAW_RIGHT_GROW 0x09A   (0236)  ||  0184 
DRAW_UP1       0x0BB   (0286)  ||  
DRAW_UP_GROW   0x079   (0194)  ||  0188 
DRAW_VERT1     0x106   (0443)  ||  0447 
DRAW_VERTICAL_LINE 0x105   (0440)  ||  
GROW           0x06A   (0176)  ||  0265 
INIT           0x010   (0051)  ||  
INIT2          0x045   (0121)  ||  0118 
INITDOWN       0x0C6   (0307)  ||  0334 0363 0393 
INITLEFT       0x0D9   (0338)  ||  0298 0329 0365 
INITRIGHT      0x0EC   (0368)  ||  0123 0301 0332 0395 
INITUP         0x0B3   (0275)  ||  0303 0360 0390 
INSIDE_FOR     0x05D   (0160)  ||  0161 
INSIDE_FOR0    0x03E   (0112)  ||  0113 
ISR            0x11B   (0493)  ||  0499 
KILL           0x067   (0172)  ||  0174 0260 0262 
MIDDLE_FOR     0x05B   (0157)  ||  0163 
MIDDLE_FOR0    0x03C   (0109)  ||  0115 
MOVE           0x052   (0142)  ||  
MOVE1          0x034   (0098)  ||  
OUTSIDE_FOR    0x059   (0154)  ||  0165 
OUTSIDE_FOR0   0x03A   (0106)  ||  0117 
QUIT           0x047   (0125)  ||  0145 0206 0220 0234 0248 
START          0x10D   (0462)  ||  0469 
VECTOR         0x3FF   (0499)  ||  


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
BG_COLOR       0x01C   (0015)  ||  0281 0313 0344 0374 0460 
BLACK          0x000   (0017)  ||  0259 
BUTTONS_ID     0x094   (0013)  ||  0166 
DOWN           0x008   (0023)  ||  0189 0362 0392 
FOOD_COLOR     0x00F   (0018)  ||  0058 0264 
INSIDE_FOR_COUNT 0x0BE   (0027)  ||  0159 
KEYBOARD       0x025   (0008)  ||  
LEDS           0x040   (0010)  ||  0173 0494 
LEFT           0x001   (0020)  ||  0185 0297 0328 
MIDDLE_FOR_COUNT 0x0BE   (0026)  ||  0156 
OUTSIDE_FOR_COUNT 0x0BE   (0025)  ||  0153 
RIGHT          0x002   (0021)  ||  0183 0300 0331 
SNAKE_COLOR    0x0F0   (0016)  ||  0095 0176 0261 0268 
SSEG           0x082   (0009)  ||  0180 
UP             0x004   (0022)  ||  0187 0359 0389 
VGA_COLOR      0x092   (0007)  ||  0063 0069 0075 0081 0096 0177 0205 0219 0233 0247 
                               ||  0269 0282 0314 0345 0375 0488 
VGA_HADD       0x090   (0005)  ||  0061 0067 0073 0079 0093 0203 0217 0231 0245 0255 
                               ||  0279 0311 0342 0372 0487 
VGA_LADD       0x091   (0006)  ||  0062 0068 0074 0080 0094 0204 0218 0232 0246 0256 
                               ||  0280 0312 0343 0373 0486 
VGA_READ_ID    0x093   (0012)  ||  0258 


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
