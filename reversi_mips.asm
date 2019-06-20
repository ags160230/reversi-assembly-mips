.data

.macro TuneOne
		li $a0, 50 				# pitch
		li $a1, 800 				# duration
		li $a2, 0 				# instrument
		li $a3, 127 				# volume
		#default values

		#note to start (initial note is silent)
		li $a1, 10 				# duration
		li $a0, 48 				# pitch
		li $v0, 31 				# play note
		syscall
		
		li $a0, 10 				# delay
		li $v0, 32 				# sleep
		syscall
		
		#note 1
		li $a1, 500 				# duration
		li $a0, 52 				# pitch
		li $v0, 31 				# play note
		syscall
		
		li $a0, 430 				#delay
		li $v0, 32 				#sleep
		syscall
.end_macro	

.macro TuneTwo
		li $a0, 50 #pitch
		li $a1, 800 #duration
		li $a2, 0 #instrument
		li $a3, 127 #volume
		#default values

		#note to start (initial note is silent)
		li $a1, 10 				# duration
		li $a0, 48 				# pitch
		li $v0, 31 				# play note
		syscall
		
		li $a0, 10 				# delay
		li $v0, 32 				# sleep
		syscall
		
		#note 1
		li $a1, 500 				# duration
		li $a0, 48 				# pitch
		li $v0, 31 				# play note
		syscall
		
		li $a0, 430 				# delay
		li $v0, 32 				# sleep
		syscall
		
		#note 2
		li $a1, 500 				# duration
		li $a0, 52 				# pitch
		li $v0, 31 				# play note
		syscall
.end_macro

boardSpace:     .space 256
board:      	.word 0, 0, 0, 0, 0, 0, 0, 0, 		# 00, 01, 02, 03, 04, 05, 06, 07,
		      0, 0, 0, 0, 0, 0, 0, 0,		# 08, 09, 10, 11, 12, 13, 14, 15,
   	              0, 0, 0, 0, 0, 0, 0, 0,		# 16, 17, 18, 19, 20, 21, 22, 23,
   	              0, 0, 0, 1, 2, 0, 0, 0,		# 24, 25, 26, 27, 28, 29, 30, 31,
   	              0, 0, 0, 2, 1, 0, 0, 0,		# 32, 33, 34, 35, 36, 37, 38, 39,
   	              0, 0, 0, 0, 0, 0, 0, 0,		# 40, 41, 42, 43, 44, 45, 46, 47, 
   	              0, 0, 0, 0, 0, 0, 0, 0,		# 48, 49, 50, 51, 52, 53, 54, 55,
   	              0, 0, 0, 0, 0, 0, 0, 0		# 56, 57, 58, 59, 60, 61, 62, 63

dimSize:        .word 8

p1Score:   	.word 2
p2Score:   	.word 2

colorTurn: 	.word 1

isLR:		.word 0		# is left rows condition variable
isRR:		.word 0		# is right rows condition variable
isUC:		.word 0		# is up columns condition variable
isDC:		.word 0		# is down columns condition variable
isUPD:		.word 0		# is up positive diagonals condition variable
isDPD:		.word 0		# is down positive diagonals condition variable
isUND:		.word 0		# is up negative diagonals condition variable
isDND:		.word 0		# is down negative diagonals condition variable

p1Prompt:  	.asciiz "Player 1's (white / o) turn!"
p2Prompt:  	.asciiz "Player 2's (black / x) turn!"

empty:     	.asciiz "- "
white:     	.asciiz "o "
black:     	.asciiz "x "
newLine:        .asciiz "\n"
tab:            .asciiz "\t"

p1ScorePrompt:	.asciiz "Player 1 score: "
p2ScorePrompt:	.asciiz "Player 2 score: "

movePrompt:     .asciiz "Enter the coordinates for where you wish to place a disk."
Xprompt:        .asciiz "Enter X: "
Yprompt:        .asciiz "Enter Y: "

notIntPrompt:   .asciiz "Please enter only an integer: "
errorPrompt:    .asciiz "That is an invalid move! Please try again."

.text
		
#---------------------------------------------------------------------#
#---------------------------------------------------------------------#

main:		jal printBoard
		
		# Print player 1 score
		la $a0, p1ScorePrompt
		li $v0, 4
		syscall
		
		lw $a0, p1Score
      		li $v0, 1
      		syscall
      		
      		la $a0, tab
		li $v0, 4
		syscall
      		
      		# Print player 2 score
		la $a0, p2ScorePrompt
		li $v0, 4
		syscall
		
		lw $a0, p2Score
      		li $v0, 1
      		syscall
      		
      		la $a0, newLine
		li $v0, 4
		syscall
		
		la $a0, newLine
		li $v0, 4
		syscall
		
		lw $s2, colorTurn
		
		beq $s2, 1, promptP1
		beq $s2, 2, promptP2	
      		
promptP1:      	# Player 1 prompt
		TuneOne
		la $a0, p1Prompt
		li $v0, 4
		syscall
		
		la $a0, newLine
		li $v0, 4
		syscall
		
		la $a0, newLine
		li $v0, 4
		syscall
		
		b contMain

promptP2:       # Player 2 prompt
		TuneTwo
		la $a0, p2Prompt
		li $v0, 4
		syscall
		
		la $a0, newLine
		li $v0, 4
		syscall
		
		la $a0, newLine
		li $v0, 4
		syscall
		
		b contMain
      		
contMain:	# Prompt player for coordinates
		la $a0, movePrompt
		li $v0, 4
		syscall
		
		la $a0, newLine
		li $v0, 4
		syscall

		# X prompt
		la $a0, Xprompt
		li $v0, 4
		syscall
		
		# Get X
		li $v0, 5
		syscall
		move $a1, $v0
		
		# Y prompt
		la $a0, Yprompt
		li $v0, 4
		syscall
		
		# Get Y
		li $v0, 5
		syscall
		move $a2, $v0
		
		la $a0, newLine
		li $v0, 4
		syscall
		
		# Check placement of disc
		jal placeCheck
		
		# Branch to badMove if an erroneous move is made
		beq $v0, 1, badMove
		
		# Else place disc
		jal place
		
		# Branch condition to alternate turns of players
		beq $s2, 1, blackTurn
		beq $s2, 2, whiteTurn

blackTurn: 	lw $t7, colorTurn

		add $s2, $s2, 1
		sw $s2, colorTurn
			
		b main
		
whiteTurn:      sub $s2, $s2, 1
		sw $s2, colorTurn
		
		b main
		
badMove:    	# print error prompt
		la $a0, errorPrompt
		li $v0, 4
		syscall
		
		la $a0, newLine
		li $v0, 4
		syscall
		
		la $a0, newLine
		li $v0, 4
		syscall
		
		b main
				
#---------------------------------------------------------------------#
# getCMTelement subroutine performs a column major traversal of the 
# array to return the desired element of the given coordinates
#---------------------------------------------------------------------#

getCMTelement:  la $s0, board				# board
		lw $s1, dimSize				# row size 
		
    		mul $t2, $s1, $a2       		# $t2 <-- width * i
    		add $t2, $t2, $a1       		# $t2 <-- width * i + j
    		sll $t2, $t2, 2         		# $t2 <-- 2^2 * (width * i + j)
    		add $t2, $s0, $t2       		# $t2 <-- base address + (2^2 * (width * i + j))
    		
    		lw $v0, 0($t2)				# load value at array[i] for coordinates (x,y = $a1, $a2)
    		 
    		jr $ra
    		
#---------------------------------------------------------------------#
#---------------------------------------------------------------------#

updateCMTelem:  la $s0, board				# board
		lw $s1, dimSize				# row size 
		
   		mul $t2, $s1, $a2       		# $t2 <-- width * i
   		add $t2, $t2, $a1       		# $t2 <-- width * i + j
    		sll $t2, $t2, 2         		# $t2 <-- 2^2 * (width * i + j)
    		add $t2, $s0, $t2       		# $t2 <-- base address + (2^2 * (width * i + j))

    		add $t0, $zero, $s2
    		
    		sw $t0, 0($t2)
    		 
   		jr $ra
    		
#---------------------------------------------------------------------#
# getCMTindex subroutine performs a column major traversal of the 
# array to return the desired index of the given coordinates
#---------------------------------------------------------------------#

getCMTindex:  	la $s0, board				# board
		lw $s1, dimSize				# row size 
		
    		mul $t2, $s1, $a2       		# $t2 <-- width * i
    		add $t2, $t2, $a1       		# $t2 <-- width * i + j
    		sll $t2, $t2, 2         		# $t2 <-- 2^2 * (width * i + j)
    		
    		move $v0, $t2				# move coordinates (x,y = $a1, $a2) index into return variable
    		 
    		jr $ra
				
#---------------------------------------------------------------------#
# place subroutine places a disc into the array at the given coordinates
#---------------------------------------------------------------------#

place:          move $s3, $ra
		jal getCMTelement
    		
    		add $v0, $zero, $zero			# clear value
    		add $v0, $v0, $s2			# insert appropriate color value
    		
    		sw $v0, 0($t2)				# store array[i]
    		
    		jal flipColors
    		
    		jal updateScores
		
		move $ra, $s3
	   	jr $ra

#---------------------------------------------------------------------#
# placeCheck subroutine contains various nested subroutines to check
# the various cases possible in placing a disk
#---------------------------------------------------------------------#

placeCheck:    	# check if the provided coordinates are within the bounds of the board
		move $s3, $ra
		jal checkBounds
		beq $v0, 1, checkIsBad
		
		# check if cell is empty
		jal checkIfEmpty
		beq $v0, 1, checkIsBad
		
		# check outer top left corner
		jal checkOTLcorner
		beq $v0, 1, checkIsBad
		
		# check outer top right corner
		jal checkOTRcorner
		beq $v0, 1, checkIsBad
		
		# check outer bottom left corner
		jal checkOBLcorner
		beq $v0, 1, checkIsBad
		
		# check outer bottom right corner
		jal checkOBRcorner
		beq $v0, 1, checkIsBad
		
		# check outer left wall
		jal checkOleftWall
		beq $v0, 1, checkIsBad
		
		# check outer right wall
		jal checkOrightWall
		beq $v0, 1, checkIsBad
		
		# check outer ceiling
		jal checkOceiling
		beq $v0, 1, checkIsBad
		
		# check outer floor
		jal checkOfloor
		beq $v0, 1, checkIsBad
		
		# check inner top left corner
		jal checkITLcorner
		beq $v0, 1, checkIsBad
		
		# check inner top right corner
		jal checkITRcorner
		beq $v0, 1, checkIsBad
		
		# check inner bottom left corner
		jal checkIBLcorner
		beq $v0, 1, checkIsBad
		
		# check inner bottom right corner
		jal checkIBRcorner
		beq $v0, 1, checkIsBad
		
		# check innner ceiling
		jal checkIceiling
		beq $v0, 1, checkIsBad
		
		# check inner floor
		jal checkIfloor
		beq $v0, 1, checkIsBad
		
		# check inner matrix
		jal checkInnerMat
		beq $v0, 1, checkIsBad

checkIsGood:    add $v0, $zero, $zero
		move $ra, $s3
		jr $ra
		
checkIsBad:     add $v0, $zero, 1
		move $ra, $s3
		jr $ra
		
#---------------------------------------------------------------------#
# flipColors subroutine contains various nested subroutines to flip the
# colors, depending on which direction variable was marked in placeCheck
#---------------------------------------------------------------------#

flipColors:	lw $t0, isLR
		lw $t1, isRR
		lw $t2, isUC
		lw $t3, isDC
		lw $t4, isUPD
		lw $t5, isDPD
		lw $t6, isUND
		lw $t7, isDND
		
		move $s4, $ra
		
		# Cases to branch to, depending on which direction variables were marked
		beq $t0, 1, FC_LR
FC_b1:		beq $t1, 1, FC_RR
FC_b2:		beq $t2, 1, FC_UC
FC_b3:		beq $t3, 1, FC_DC
FC_b4:		beq $t4, 1, FC_UPD
FC_b5:		beq $t5, 1, FC_DPD
FC_b6:		beq $t6, 1, FC_UND
FC_b7:		beq $t7, 1, FC_DND

		b FC_exit
		
FC_LR:		jal adjustRowL
		b FC_b1

FC_RR:		jal adjustRowR
		b FC_b2

FC_UC:		jal adjustColumnU
		b FC_b3

FC_DC:		jal adjustColumnD
		b FC_b4

FC_UPD:		jal adjustPosDiagU
		b FC_b5

FC_DPD:		jal adjustPosDiagD
		b FC_b6

FC_UND:		jal adjustNegDiagU
		b FC_b7

FC_DND:		jal adjustNegDiagD
		
FC_exit:	# Restore direction variables
		add $t0, $zero, $zero
		add $t1, $zero, $zero
		add $t2, $zero, $zero
		add $t3, $zero, $zero
		add $t4, $zero, $zero
		add $t5, $zero, $zero
		add $t6, $zero, $zero
		add $t7, $zero, $zero
		
		sw $t0, isLR
		sw $t1, isRR
		sw $t2, isUC
		sw $t3, isDC
		sw $t4, isUPD
		sw $t5, isDPD
		sw $t6, isUND
		sw $t7, isDND
		
		move $ra, $s4
		jr $ra

#---------------------------------------------------------------------#
# checkBounds subroutine checks the bounds of the given coordinates
#---------------------------------------------------------------------#
	    		
checkBounds:    lw $s1, dimSize				# row size 

		slti $t0, $a1, 0			# if X < 0
		beq $t0, 1, outOfBounds
		
		slt $t0, $s1, $a1			# if X > 8
		beq $t0, 1, outOfBounds
		
		beq $a1, 8, outOfBounds			# if x == 8
		
		slti $t0, $a2, 0			# if Y < 0
		beq $t0, 1, outOfBounds
		
		slt $t0, $s1, $a2			# if Y > 8
		beq $t0, 1, outOfBounds
		
		beq $a2, 8, outOfBounds			# if Y == 8	
		
		add $v0, $zero, $zero
		jr $ra
		
outOfBounds:    add $v0, $zero, 1
		jr $ra
		
#---------------------------------------------------------------------#
# checkIfEmpty subroutine checks if there is already a disc at the given
# coordinates
#---------------------------------------------------------------------#
		
checkIfEmpty:	move $s4, $ra
		jal getCMTelement
    		
    		bne $v0, 0, notEmpty			# if $t0 != 0
    		
    		add $v0, $zero, $zero
    		move $ra, $s4
    		jr $ra

notEmpty:       add $v0, $zero, 1
		move $ra, $s4
    		jr $ra
    		
#---------------------------------------------------------------------#
# checkOTLcorner subroutine checks if the outer top left corner (0,0)
# is a valid move
#---------------------------------------------------------------------#

checkOTLcorner: lw $s2, colorTurn
	
		bne $a1, $zero, notOTLC			# if $a1 != 0
		bne $a2, $zero, notOTLC			# if $a2 != 0
		
OTLCifDisjoint: add $a1, $a1, 1 			# increment X by 1 to check right adjacent cell
		
		move $s4, $ra
		jal getCMTelement			# return array[Y][X + 1]
		
		add $t0, $zero, $v0			# $t0 = condition helper variable 
							# (if register is greater than zero, than TLC is not disjointed
		
		sub $a1, $a1, 1				# restore X value
		add $a2, $a2, 1				# increment Y by 1 to check right underlying adjacent cell
		
		jal getCMTelement			# return array[Y + 1][X]
		
		add $t0, $t0, $v0			# increment condition helper variable
		
		add $a1, $a1, 1				# increment X by 1 to check negative diagonal
		
		jal getCMTelement			# return array[Y + 1][X + 1]
		
		add $t0, $t0, $v0			# increment condition helper variable
		beq $t0, $zero, OTLCcaseFailed		# if $t0 == 0, then TLC is disjointed
		
		sub $a1, $a1, 1				# restore X value
		sub $a2, $a2, 1				# restore Y value
		add $t0, $zero, $zero			# restore condition helper variable
		
OTLCifSandwhich:# check for sandwhiching
		jal OTLC_sandwhich
		beq $v0, 1, OTLCcaseFailed
		
		add $v0, $zero, $zero
		move $ra, $s4
		jr $ra
		
OTLCcaseFailed: add $v0, $zero, 1
		move $ra, $s4
		jr $ra

notOTLC:	jr $ra

#---------------------------------------------------------------------#

OTLC_sandwhich:	la $s0, board				# board
		lw $s1, dimSize				# row size 
		lw $s2, colorTurn			# color turn
		
		li $t0, 0				# cell counter
		li $t1, 6                               # cell counter limit
		li $t2, 0				# condition helper variable
		
		move $s5, $ra
		
OTLC_vRows:	# Verify that the (right) rows is a direction to check
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0				
		add $s7, $s7, 8				# i = index (array[(x,y)]) + 8 (2 * 4 bytes)	
		
		add $a1, $a1, 1
		jal getCMTelement			# if array[Y][X + 1]
		sub $a1, $a1, 1
		
		beqz $v0, OTLC_vDownCols		# if array[Y][X + 1] == 0
		beq $v0 $s2,  OTLC_vDownCols		# if array[Y][X + 1] == colorTurn
				
OTLC_rows:      lw $a0, ($s7)           		# load array[Y][X]
		
		# Cases to branch to depending on contents of the cell
		beqz $a0, OTLC_breakR
		beq $a0, $s2, OTLC_trueR
		bne $a0, $s2, OTLC_iterateR
		
OTLC_breakR:    # Branch to down columns if disjointed
		add $t0, $zero, $zero
		
		b OTLC_vDownCols
		
OTLC_trueR:     # Mark RR if same color is found & break
		add $t7, $zero, 1
		sw $t7, isRR
		
		add $t2, $t2, 1
		
		b OTLC_breakR
		
OTLC_iterateR:  # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, OTLC_breakR
		
		add $s7, $s7, 4
		
		b OTLC_rows
		
OTLC_vDownCols: # Verify that down columns is a direction to check
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0
		add $s7, $s7, 64			# array[cur] = array[(x,y)] +  64 (16 * 4 bytes)
		
		add $a2, $a2, 1
		jal getCMTelement			# return array[Y + 1][X]
		sub $a2, $a2, 1
		
		beqz $v0, OTLC_vNegDiags		# if array[Y + 1][X] == 0
		beq $v0, $s2, OTLC_vNegDiags		# if array[Y + 1][X] == colorTurn
		
OTLC_downCols:  lw $a0, ($s7)           		# load array[Y][X]
		
		# Cases to branch to depending on contents of the cell
		beqz $a0, OTLC_breakDC
		beq $a0, $s2, OTLC_trueDC
		bne $a0, $s2, OTLC_iterateDC
		
OTLC_breakDC:   # Branch to neg diagonals if disjointed
		add $t0, $zero, $zero
		
		b OTLC_vNegDiags
		
OTLC_trueDC:    # Mark DC if same color is found & break
		add $t7, $zero, 1
		sw $t7, isDC
		
		add $t2, $t2, 1
		
		b OTLC_breakDC

OTLC_iterateDC: # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, OTLC_breakDC
		
		add $s7, $s7, 32			# 32 => i += (8 * 4 bytes)
		
		b OTLC_downCols
		
OTLC_vNegDiags:	# Verify that (down) negative diagonals is a direction to check
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0
		add $s7, $s7, 72			# index = array[(x,y)] + 72 (18 * 4 bytes)
		
		add $a1, $a1, 1
		add $a2, $a2, 1
		jal getCMTelement			# if array[Y + 1][X + 1]
		sub $a1, $a1, 1
		sub $a2, $a2, 1
		
		beqz $v0, OTLC_breakND			# if array[Y + 1][X + 1] == 0 
		beq $v0, $s2 OTLC_breakND		# if array[Y + 1][X + 1] == colorTurn
		
OTLC_negDiags:  lw $a0, ($s7)           		# load array[Y][X]
		
		# Cases to branch to depending on contents of the cell
		beqz $a0, OTLC_breakND
		beq $a0, $s2, OTLC_trueND
		bne $a0, $s2, OTLC_iterateND
		
OTLC_breakND:   # Branch to exit (fail) if no other cases checked out or return true
		beqz $t2, OTLC_sandExit
		
		add $v0, $zero, $zero
		
		move $ra, $s5
		jr $ra
		
OTLC_trueND:    # Mark DND if same color is found & break
		add $t7, $zero, 1
		sw $t7, isDND
		
		add $t2, $t2, 1
		
		b OTLC_breakND
		
OTLC_iterateND: # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, OTLC_breakND
		
		add $s7, $s7, 36			# # 36 => i += (9 * 4 bytes)
		
		b OTLC_negDiags
		
OTLC_sandExit:	# Return false if nothing found
		add $v0, $zero, 1
		
		move $ra, $s5
		
		jr $ra
		
#---------------------------------------------------------------------#
# checkOTRcorner subroutine checks if the outer top right corner (7,0)
# is a valid move
#---------------------------------------------------------------------#

checkOTRcorner: lw $s2, colorTurn
	
		bne $a1, 7, notOTRC			# if $a1 != 7
		bnez $a2, notOTRC			# if $a2 != 0
		
OTRCifDisjoint: sub $a1, $a1, 1 			# decrement X by 1 to check left adjacent cell
		
		move $s4, $ra
		jal getCMTelement			# get array[Y][X - 1]
		
		add $t0, $zero, $v0			# $t0 = condition helper variable 
							# (if register is greater than zero, than TLC is not disjointed
		
		add $a1, $a1, 1				# restore X value
		add $a2, $a2, 1				# increment Y by 1 to check right underlying adjacent cell
		
		jal getCMTelement			# get array[Y + 1][X]
		
		add $t0, $t0, $v0			# increment condition helper variable
		
		sub $a1, $a1, 1				# decrement X by 1 to check negative diagonal
		
		jal getCMTelement			# get array[X - 1][Y + 1]
		
		add $t0, $t0, $v0			# increment condition helper variable
		beq $t0, $zero, OTRCcaseFailed		# if $t0 == 0, then TLC is disjointed
		
		add $a1, $a1, 1				# restore X value
		sub $a2, $a2, 1				# restore Y value
		add $t0, $zero, $zero			# restore condition helper variable
		
OTRifSandwhich: # check for sandwhiching
		jal OTRC_sandwhich
		beq $v0, 1, OTRCcaseFailed
		
		add $v0, $zero, $zero
		move $ra, $s4
		jr $ra
		
OTRCcaseFailed: add $v0, $zero, 1
		move $ra, $s4
		jr $ra
		
notOTRC:	jr $ra

#---------------------------------------------------------------------#

OTRC_sandwhich:	la $s0, board				# board
		lw $s1, dimSize				# row size 
		lw $s2, colorTurn			# color turn
		
		li $t0, 0				# cell counter
		li $t1, 6                               # cell counter limit
		li $t2, 0				# condition helper variable
		
		move $s5, $ra
		
OTRC_vRows:	# Verify that (left) rows is a direction to check
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0				
		sub $s7, $s7, 8				# i = index (array[(x,y)]) - 8 (2 * 4 bytes)	
		
		sub $a1, $a1, 1
		jal getCMTelement			# return array[Y][X - 1]
		add $a1, $a1, 1	
		
		beqz $v0, OTRC_vDownCols		# if array[Y][X - 1] == 0
		beq $v0, $s2, OTRC_vDownCols		# if array[Y][X - 1] == colorTurn
						
OTRC_rows:      lw $a0, ($s7)           		# load array[Y][X]

		# Cases to branch to depending on contents of the cell
		beqz $a0, OTRC_breakR
		beq $a0, $s2, OTRC_trueR
		bne $a0, $s2, OTRC_iterateR
		
OTRC_breakR:    # Branch to columns if disjointed
		add $t0, $zero, $zero
		
		b OTRC_vDownCols
		
OTRC_trueR:     # Mark LR if same color is found & break
		add $t7, $zero, 1
		sw $t7, isLR
		
		add $t2, $t2, 1
		
		b OTRC_breakR
		
OTRC_iterateR:  # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, OTRC_breakR
		
		sub $s7, $s7, 4
		
		b OTRC_rows
		
OTRC_vDownCols: # Verify that down columns is a direction to check
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0
		add $s7, $s7, 64			# array[cur] = array[(x,y)] +  64 (16 * 4 bytes)
		
		add $a2, $a2, 1
		jal getCMTelement			# return array[Y + 1][X]
		sub $a2, $a2, 1
		
		beqz $v0, OTRC_vPosDiags
		beq $v0, $s2, OTRC_vPosDiags
						
OTRC_downCols:  lw $a0, ($s7)           		# load array[Y][X]

		# Cases to branch to depending on contents of the cell
		beqz $a0, OTRC_breakDC
		beq $a0, $s2, OTRC_trueDC
		bne $a0, $s2, OTRC_iterateDC
		
OTRC_breakDC:   # Branch to pos diagonals if disjointed
		add $t0, $zero, $zero
		
		b OTRC_vPosDiags
		
OTRC_trueDC:    # Mark DC if same color is found & break
		add $t7, $zero, 1
		sw $t7, isDC
		
		add $t2, $t2, 1
		
		b OTRC_breakDC

OTRC_iterateDC: # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, OTRC_breakDC
		
		add $s7, $s7, 32			# 32 => i += (8 * 4 bytes)
		
		b OTRC_downCols
		
OTRC_vPosDiags: # Verify that (down) positive diagonals is a direction to check
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0
		add $s7, $s7, 56			# index = array[(x,y)] + 56 (14 * 4 bytes)
		
		sub $a1, $a1, 1
		add $a2, $a2, 1
		jal getCMTelement			# return array[Y + 1][X - 1]
		add $a1, $a1, 1
		sub $a2, $a2, 1
		
		beqz $v0, OTRC_breakPD			# if array[Y + 1][X - 1] == 0
		beq $v0, $s2, OTRC_breakPD		# if array[Y + 1][X - 1] == colorTurn
		
OTRC_posDiags:  lw $a0, ($s7)           		# load array[Y][X]

		# Cases to branch to depending on contents of the cell
		beqz $a0, OTRC_breakPD
		beq $a0, $s2, OTRC_truePD
		bne $a0, $s2, OTRC_iteratePD
		
OTRC_breakPD:   # Branch to exit (fail) if no other cases checked out or return true
		beqz $t2, OTRC_sandExit
		
		add $v0, $zero, $zero
		
		move $ra, $s5
		jr $ra
		
OTRC_truePD:    # Mark DPD if same color is found & break
		add $t7, $zero, 1
		sw $t7, isDPD
		
		add $t2, $t2, 1
		
		b OTRC_breakPD
		
OTRC_iteratePD: # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, OTRC_breakPD
		
		add $s7, $s7, 28			# # 36 => i += (7 * 4 bytes)
		
		b OTRC_posDiags
		
OTRC_sandExit:	# Return false if nothing found
		add $v0, $zero, 1
		
		move $ra, $s5
		
		jr $ra
		
#---------------------------------------------------------------------#
# checkOBLcorner subroutine checks if the outer bottom left corner (0,7)
# is a valid move
#---------------------------------------------------------------------#

checkOBLcorner: lw $s2, colorTurn
	
		bne $a1, $zero, notOBLC			# if $a1 != 0
		bne $a2, 7, notOBLC			# if $a2 != 7
		
OBLifDisjoint:  add $a1, $a1, 1 			# increment X by 1 to check right adjacent cell
		
		move $s4, $ra
		jal getCMTelement			# return array[Y][X + 1]
		
		add $t0, $zero, $v0			# $t0 = condition helper variable 
							# (if register is greater than zero, than TLC is not disjointed
		
		sub $a1, $a1, 1				# restore X value
		sub $a2, $a2, 1				# decrement Y by 1 to check right underlying adjacent cell
		
		jal getCMTelement			# return array[Y - 1][X]
		
		add $t0, $t0, $v0			# increment condition helper variable
		
		add $a1, $a1, 1				# increment X by 1 to check negative diagonal
		
		jal getCMTelement			# return array[Y - 1][X + 1]
		
		add $t0, $t0, $v0			# increment condition helper variable
		beq $t0, $zero, OBLCcaseFailed		# if $t0 == 0, then TLC is disjointed
		
		sub $a1, $a1, 1				# restore X value
		add $a2, $a2, 1				# restore Y value
		add $t0, $zero, $zero			# restore condition helper variable
		
OBLifSandwhich: # Check for sandwhiching
		jal OBLC_sandwhich
		beq $v0, 1, OBLCcaseFailed
		
		add $v0, $zero, $zero
		move $ra, $s4
		jr $ra
		
OBLCcaseFailed: add $v0, $zero, 1
		move $ra, $s4
		jr $ra

notOBLC:	jr $ra

#---------------------------------------------------------------------#

OBLC_sandwhich:	la $s0, board				# board
		lw $s1, dimSize				# row size 
		lw $s2, colorTurn			# color turn
		
		li $t0, 0				# cell counter
		li $t1, 6                               # cell counter limit
		li $t2, 0				# condition helper variable
		
		move $s5, $ra
		
OBLC_vRows:	# Verify that (right) rows is a direction to check
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0				
		add $s7, $s7, 8				# i = index (array[(x,y)]) + 8 (2 * 4 bytes)	
		
		add $a1, $a1, 1
		jal getCMTelement			# return array[Y][X + 1]
		sub $a1, $a1, 1
		
		beqz $v0, OBLC_vUpCols			# if array[Y][X + 1] == 0
		beq $v0, $s2, OBLC_vUpCols		# if array[Y][X + 1] == colorTurn		
		
OBLC_rows:      lw $a0, ($s7)           		# load array[Y][X]
		
		# Cases to branch to depending on contents of the cell
		beqz $a0, OBLC_breakR
		beq $a0, $s2, OBLC_trueR
		bne $a0, $s2, OBLC_iterateR
		
OBLC_breakR:    # Branch to columns if disjointed
		add $t0, $zero, $zero
		
		b OBLC_vUpCols
		
OBLC_trueR:     # Mark RR if same color is found & break
		add $t7, $zero, 1
		sw $t7, isRR
		
		add $t2, $t2, 1
		
		b OBLC_breakR
		
OBLC_iterateR:  # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, OBLC_breakR
		
		add $s7, $s7, 4
		
		b OBLC_rows
		
OBLC_vUpCols:   # Verify that up columns is a direction to check
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0
		sub $s7, $s7, 64			# array[cur] = array[(x,y)] +  64 (16 * 4 bytes)
		
		sub $a2, $a2, 1
		jal getCMTelement			# return array[Y - 1][X]
		add $a2, $a2, 1
		
		beqz $v0, OBLC_vPosDiags		# if array[Y - 1][X] == 0
		beq $v0, $s2, OBLC_vPosDiags		# if array[Y - 1][X] == colorTurn
						
OBLC_upCols:   	lw $a0, ($s7)           		# load array[Y][X]
		
		# Cases to branch to depending on contents of the cell
		beqz $a0, OBLC_breakUC
		beq $a0, $s2, OBLC_trueUC
		bne $a0, $s2, OBLC_iterateUC
		
OBLC_breakUC:   # Branch to pos diagonals if disjointed
		add $t0, $zero, $zero
		
		b OBLC_vPosDiags
		
OBLC_trueUC:    # Mark UC if same color is found & break
		add $t7, $zero, 1
		sw $t7, isUC
		
		add $t2, $t2, 1
		
		b OBLC_breakUC

OBLC_iterateUC: # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, OBLC_breakUC
		
		sub $s7, $s7, 32			# 32 => i += (8 * 4 bytes)
		
		b OBLC_upCols

OBLC_vPosDiags: # Verify that (up) positive diagonals is a direction to check
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0
		sub $s7, $s7, 56			# index = array[(x,y)] - 56 (14 * 4 bytes)
		
		add $a1, $a1, 1
		sub $a2, $a2, 1
		jal getCMTelement			# return array[Y - 1][X + 1]
		sub $a1, $a1, 1
		add $a2, $a2, 1
		
		beqz $v0, OBLC_breakPD			# if array[Y - 1][X + 1] == 0
		beq $v0, $s2, OBLC_breakPD		# if array[Y - 1][X + 1] == colorTurn
		
OBLC_posDiags:  lw $a0, ($s7)           		# load array[Y][X]
		
		# Cases to branch to depending on contents of the cell
		beqz $a0, OBLC_breakPD
		beq $a0, $s2, OBLC_truePD
		bne $a0, $s2, OBLC_iteratePD
		
OBLC_breakPD:   # Branch to exit (fail) if no other cases checked out or return true
		beqz $t2, OBLC_sandExit
		
		add $v0, $zero, $zero
		
		move $ra, $s5
		jr $ra
		
OBLC_truePD:    # Mark UPD if same color is found & break
		add $t7, $zero, 1
		sw $t7, isUPD
		
		add $t2, $t2, 1
		
		b OBLC_breakPD
		
OBLC_iteratePD: # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, OBLC_breakPD
		
		sub $s7, $s7, 28			# 28 => i -= (7 * 4 bytes)
		
		b OBLC_posDiags
		
OBLC_sandExit:	# Return false if nothing found
		add $v0, $zero, 1
		
		move $ra, $s5
		jr $ra
		
#---------------------------------------------------------------------#
# checkOBRcorner subroutine checks if the outer bottom right corner (7,7)
# is a valid move
#---------------------------------------------------------------------#

checkOBRcorner: lw $s2, colorTurn
	
		bne $a1, 7, notOBRC			# if $a1 != 7
		bne $a2, 7, notOBRC			# if $a2 != 7
		
OBRifDisjoint:  sub $a1, $a1, 1 			# decrement X by 1 to check left adjacent cell
		
		move $s4, $ra
		jal getCMTelement			# return array[Y][X - 1]
		
		add $t0, $zero, $v0			# $t0 = condition helper variable 
							# (if register is greater than zero, than TLC is not disjointed
		
		add $a1, $a1, 1				# restore X value
		sub $a2, $a2, 1				# decrement Y by 1 to check underlying adjacent cell
		
		jal getCMTelement			# return array[Y - 1][X]
		
		add $t0, $t0, $v0			# increment condition helper variable
		
		sub $a1, $a1, 1				# decrement X by 1 to check negative diagonal
		
		jal getCMTelement			# return array[Y - 1][X - 1]
		
		add $t0, $t0, $v0			# increment condition helper variable
		beq $t0, $zero, OBRCcaseFailed		# if $t0 == 0, then TLC is disjointed
		
		add $a1, $a1, 1				# restore X value
		add $a2, $a2, 1				# restore Y value
		add $t0, $zero, $zero			# restore condition helper variable
		
OBRifSandwhich: # check for sandwhiching
		jal OBRC_sandwhich
		beq $v0, 1, OBRCcaseFailed
		
		add $v0, $zero, $zero
		move $ra, $s4
		jr $ra
		
OBRCcaseFailed: add $v0, $zero, 1
		move $ra, $s4
		jr $ra
		
notOBRC:	jr $ra

#---------------------------------------------------------------------#

OBRC_sandwhich:	la $s0, board				# board
		lw $s1, dimSize				# row size 
		lw $s2, colorTurn			# color turn
		
		li $t0, 0				# cell counter
		li $t1, 6                               # cell counter limit
		li $t0, 0				# condition helper variable
		
		move $s5, $ra
		
OBRC_vRows:	# Verify that (left) rows is a direction to check
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0				
		sub $s7, $s7, 8				# i = index (array[(x,y)]) - 8 (2 * 4 bytes)	
		
		sub $a1, $a1, 1
		jal getCMTelement			# return array[Y][X - 1]
		add $a1, $a1, 1	
		
		beqz $v0, OBRC_vUpCols			# if array[Y][X - 1] == 0
		beq $v0, $s2, OBRC_vUpCols		# if array[Y][X - 1] == colorTurn
		
OBRC_rows:      lw $a0, ($s7)           		# load array[Y][X]
		
		# Cases to branch to depending on contents of the cell
		beqz $a0, OBRC_breakR
		beq $a0, $s2, OBRC_trueR
		bne $a0, $s2, OBRC_iterateR
		
OBRC_breakR:     # Branch to columns if disjointed
		add $t0, $zero, $zero
		
		b OBRC_vUpCols
		
OBRC_trueR:     # Mark LR if same color is found & break
		add $t7, $zero, 1
		sw $t7, isLR
		
		add $t2, $t2, 1
		
		b OBRC_breakR
		
OBRC_iterateR:  # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, OBRC_breakR
		
		sub $s7, $s7, 4
		
		b OBRC_rows
		
OBRC_vUpCols:	# Verify that up columns is a direction to check
		jal getCMTindex

		move $s7, $s0
		add $s7, $s7, $v0
		sub $s7, $s7, 64			# array[cur] = array[(x,y)] - 64 (16 * 4 bytes)
		
		sub $a2, $a2, 1
		jal getCMTelement			# return array[Y - 1][X]
		add $a2, $a2, 1
		
		beqz $v0, OBRC_vNegDiags			# if array[Y - 1][X] == 0
		beq $v0, $s2, OBRC_vNegDiags		# if array[Y - 1][X] == colorTurn
						
OBRC_upCols:   	lw $a0, ($s7)           		# load array[Y][X]
		
		# Cases to branch to depending on contents of the cell
		beqz $a0, OBRC_breakUC
		beq $a0, $s2, OBRC_trueUC
		bne $a0, $s2, OBRC_iterateUC
		
OBRC_breakUC:   # Branch to neg diagonals if disjointed
		add $t0, $zero, $zero
		
		b OBRC_vNegDiags
		
OBRC_trueUC:    # Mark UC if same color is found & break
		add $t7, $zero, 1
		sw $t7, isUC
		
		add $t2, $t2, 1
		
		b OBRC_breakUC

OBRC_iterateUC: # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, OBRC_breakUC
		
		sub $s7, $s7, 32			# 32 => i += (8 * 4 bytes)
		
		b OBRC_upCols
		
OBRC_vNegDiags: # Verify that (up) negative diagonals is a direction to check
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0
		sub $s7, $s7, 72			# index = array[(x,y)] - 72 (18 * 4 bytes)
		
		sub $a1, $a1, 1
		sub $a2, $a2, 1
		jal getCMTelement			# return array[Y - 1][X - 1]
		add $a1, $a1, 1
		add $a2, $a2, 1
		
		beqz $v0, OBRC_breakND			# if array[Y - 1][X - 1] == 0
		beq $v0, $s2, OBRC_breakND		# if array[Y - 1][X - 1] == colorTurn
		
OBRC_negDiags:  lw $a0, ($s7)           		# load array[Y][X]

		# Cases to branch to depending on contents of the cell
		beqz $a0, OBRC_breakND
		beq $a0, $s2, OBRC_trueND
		bne $a0, $s2, OBRC_iterateND
		
OBRC_breakND:   # Branch to exit (fail) if no other cases checked out or return true
		beqz $t2, OBRC_sandExit
		
		add $v0, $zero, $zero
		
		move $ra, $s5
		jr $ra
		
OBRC_trueND:    # Mark UND if same color is found & break
		add $t7, $zero, 1
		sw $t7, isUND
		
		add $t2, $t2, 1
		
		b OBRC_breakND

OBRC_iterateND: # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, OBRC_breakND
		
		sub $s7, $s7, 36			# 36 => i -= (9 * 4 bytes)
		
		b OBRC_negDiags
		
OBRC_sandExit:	# Return false if nothing found
		add $v0, $zero, 1
		
		move $ra, $s5
		jr $ra
		
#---------------------------------------------------------------------#
# checkOleftwall subroutine checks if a move along the outer left wall
# (X: [0], Y: [0, 7]) is a valid move
#---------------------------------------------------------------------#

checkOleftWall: lw $s2, colorTurn
	
		bne $a1, $zero, notOLW			# if $a1 != 0
		blez $a2, notOLW			# if $a2 <= 0
		bge $a2, 7, notOLW			# if $a2 >= 7
				
OLWifDisjoint:  sub $a2, $a2, 1				# decrement Y by 1 to check overhead adjacent cell

		move $s4, $ra
		jal getCMTelement			# return array[Y - 1][X]
		
		add $t0, $zero, $v0			# $t0 = condition helper variable 
							# (if register is greater than zero, than TLC is not disjointed
							
		add $a1, $a1, 1				# increment X by 1 to check right adjacent positive diagonal
		
		jal getCMTelement			# return array[Y - 1][X + 1]
		
		add $t0, $t0, $v0
		
		add $a2, $a2, 1				# restore Y value to check right adjacent cell
		
		jal getCMTelement			# return array[Y][X + 1]
		
		add $t0, $t0, $v0

		add $a2, $a2, 1 			# increment Y by 1 to check adjacent right adjacent cell
		
		jal getCMTelement			# return array[Y + 1][X + 1]
		
		add $t0, $t0, $v0			
		
		sub $a1, $a1, 1				# restore X value to check underlying adjacent cell
		
		jal getCMTelement			# return array[Y + 1][X]
		
		add $t0, $t0, $v0			# increment condition helper variable
		
		sub $a2, $a2, 1				# restore Y value
		
		beq $t0, $zero, OLWcaseFailed		# if $t0 == 0, then TLC is disjointed
		
		add $t0, $zero, $zero			# restore condition helper variable
		
OLWifSandwhich: # check for sandwhiching
		jal OLW_sandwhich
		beq $v0, 1, OLWcaseFailed
		
		add $v0, $zero, $zero
		move $ra, $s4
		jr $ra
		
OLWcaseFailed: 	add $v0, $zero, 1
		move $ra, $s4
		jr $ra

notOLW:		jr $ra

#---------------------------------------------------------------------#

OLW_sandwhich:  la $s0, board				# board
		lw $s1, dimSize				# row size 
		lw $s2, colorTurn			# color turn
		
		li $t0, 0				# cell counter
		li $t1, 6                               # cell counter limit
		li $t2, 0				# condition helper variable
		
		move $s5, $ra
		
OLW_vRows:	# Verify that (right) rows is a direction to check
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0				
		add $s7, $s7, 8				# i = index (array[(x,y)]) + 8 (2 * 4 bytes)	
		
		add $a1, $a1, 1	
		jal getCMTelement			# return array[Y][X + 1]
		sub $a1, $a1, 1
		
		beqz $v0, OLW_vUpCols			# if array[Y][X + 1] == 0
		beq $v0, $s2, OLW_vUpCols		# if array[Y][X + 1] == colorTurn
		
OLW_rows:      	lw $a0, ($s7)           		# load array[Y][X]
		
		# Cases to branch to depending on contents of the cell
		beqz $a0, OLW_breakR1
		beq $a0, $s2, OLW_trueR
		bne $a0, $s2, OLW_iterateR
		
OLW_breakR1:    # Branch to columns if disjointed
		ble $a2, 1, OLW_breakR2			# if i <= 1
		
		b OLW_vUpCols

OLW_breakR2:    # Branch to down columns if disjointed & i <= 1
		b OLW_vDownCols
		
OLW_trueR:     	# Mark RR if same color is found & break
		add $t7, $zero, 1
		sw $t7, isRR
		
		add $t2, $t2, 1
		
		b OLW_breakR1
		
OLW_iterateR:   # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, OLW_breakR1
		
		add $s7, $s7, 4
		
		b OLW_rows
		
OLW_vUpCols:   	# Verify that up columns is a direction to check
		add $t0, $zero, $zero			# i_o = 0
		sub $t1, $a2, 1				# i_f = Y - 1
		
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0
		sub $s7, $s7, 64			# array[cur] = array[(x,y)] - 64 (16 * 4 bytes)
		
		sub $a2, $a2, 1				#
		jal getCMTelement			# return array[Y - 1][X]
		add $a2, $a2, 1				#
		
		beqz $v0, OLW_vDownCols			# if array[Y - 1][X] == 0
		beq $v0, $s2, OLW_vDownCols		# if array[Y - 1][X] == colorTurn
						
OLW_upCols:   	lw $a0, ($s7)           		# load array[Y][X]
		
		# Cases to branch to depending on contents of the cell
		beqz $a0, OLW_breakUC1
		beq $a0, $s2, OLW_trueUC
		bne $a0, $s2, OLW_iterateUC
		
OLW_breakUC1:   # Branch to down columns if disjointed
		bge $a2, 6, OLW_breakUC2		# if i >= 6
		
		b OLW_vDownCols
		
OLW_breakUC2:	# Branch to pos diagonals if disjointed & i >= 6
		b OLW_vPosDiags
		
OLW_trueUC:     # Mark UC if same color is found & break
		add $t7, $zero, 1
		sw $t7, isUC
		
		add $t2, $t2, 1
		
		b OLW_breakUC1

OLW_iterateUC:  # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, OLW_breakUC1
		
		sub $s7, $s7, 32			# 32 => i -= (8 * 4 bytes)
		
		b OLW_upCols
		
OLW_vDownCols:  # Verify that down columns is a direction to check
		add $t0, $zero, $zero			# i_o = 0
		sub $t1, $s1, $a2			# i_f = (8 - Y)
		sub $t1, $t1, 2				# i_f = (8 - Y) - 2
		
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0
		add $s7, $s7, 64			# array[cur] = array[(x,y)] + 64 (16 * 4 bytes)

		add $a2, $a2, 1				#
		jal getCMTelement			# return array[Y + 1][X]
		sub $a2, $a2, 1				#
		
		beqz $v0, OLW_vPosDiags			# if array[Y + 1][X] == 0
		beq $v0, $s2, OLW_vPosDiags		# if array[Y + 1][X] == colorTurn
		
OLW_downCols:   lw $a0, ($s7)           		# load array[Y][X]
		
		# Cases to branch to depending on contents of the cell
		beqz $a0, OLW_breakDC1
		beq $a0, $s2, OLW_trueDC
		bne $a0, $s2, OLW_iterateDC
		
OLW_breakDC1:   # Branch to pos diagonals if disjointed
		ble $a2, 1, OLW_breakDC2		# if i <= 1
		
		b OLW_vPosDiags
		
OLW_breakDC2:   # Branch to neg diagonals if disjointed & i <= 1
		b OLW_vNegDiags
		
OLW_trueDC:     # Mark DC if same color is found & break
		add $t7, $zero, 1
		sw $t7, isDC
		
		add $t2, $t2, 1
		
		b OLW_breakDC1

OLW_iterateDC:  # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, OLW_breakDC1
		
		add $s7, $s7, 32			# 32 => i += (8 * 4 bytes)
		
		b OLW_downCols

OLW_vPosDiags:  # Verify that (up) positive diagonals is a direction to check
		add $t0, $zero, $zero			# i_o = 0
		sub $t1, $a2, 1				# i_f = Y - 1
		
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0
		sub $s7, $s7, 56			# array[cur] = array[(x,y)] - 56 (14 * 4 bytes)
		
		add $a1, $a1, 1				#
		sub $a2, $a2, 1				#
		jal getCMTelement			# return array[Y - 1][X + 1]
		sub $a1, $a1, 1				#
		add $a2, $a2, 1				#
		
		beqz $v0, OLW_vNegDiags			# if array[Y - 1][X + 1] == 0
		beq $v0, $s2, OLW_vNegDiags		# if array[Y - 1][X + 1] == colorTurn
		
OLW_posDiags:   lw $a0, ($s7)           		# load array[Y][X]

		# Cases to branch to depending on contents of the cell
		beqz $a0, OLW_breakPD1
		beq $a0, $s2, OLW_truePD
		bne $a0, $s2, OLW_iteratePD
		
OLW_breakPD1:   # Branch to neg diagonals if disjointed
		bge $a2, 6, OLW_breakPD2		# if i >= 6
		
		b OLW_vNegDiags
		
OLW_breakPD2:	# Break if disjointed & i >= 6
		b OLW_breakND
		
OLW_truePD:     # Mark UPD if same color is found & break
		add $t7, $zero, 1
		sw $t7, isUPD
		
		add $t2, $t2, 1
		
		b OLW_breakPD1

OLW_iteratePD:  # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, OLW_breakPD1
		
		sub $s7, $s7, 28			# 28 => i -= (7 * 4 bytes)
		
		b OLW_posDiags
		
OLW_vNegDiags:  # Verify that (down) negative diagonals is a direction to check
		add $t0, $zero, $zero			# i_o = 0
		sub $t1, $s1, $a2			# i_f = (8 - Y)
		sub $t1, $t1, 2				# i_f = (8 - Y) - 2
		
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0
		add $s7, $s7, 72			# index = array[(x,y)] + 72 (18 * 4 bytes)

		add $a1, $a1, 1				#
		add $a2, $a2, 1				#
		jal getCMTelement			# return array[Y + 1][X + 1]
		sub $a1, $a1, 1				#
		sub $a2, $a2, 1				#
		
		beqz $v0, OLW_breakND			# if array[Y + 1][X + 1] == 0
		beq $v0, $s2, OLW_breakND		# if array[Y + 1][X + 1] == colorTurn
				
OLW_negDiags:   lw $a0, ($s7)           		# load array[Y][X]
		
		# Cases to branch to depending on contents of the cell
		beqz $a0, OLW_breakND
		beq $a0, $s2, OLW_trueND
		bne $a0, $s2, OLW_iterateND
		
OLW_breakND:   	# Branch to exit (fail) if no other cases checked out or return true
		beqz $t2, OLW_sandExit
		
		add $v0, $zero, $zero
		
		move $ra, $s5
		jr $ra
		
OLW_trueND:     # Mark DND if same color is found & break
		add $t7, $zero, 1
		sw $t7, isDND
		
		add $t2, $t2, 1
		
		b OLW_breakND

OLW_iterateND:  # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, OLW_breakND
		
		add $s7, $s7, 36			# # 36 => i += (9 * 4 bytes)
		
		b OLW_negDiags
		
OLW_sandExit:	# Return false if nothing found
		add $v0, $zero, 1
		
		move $ra, $s5
		
		jr $ra

#---------------------------------------------------------------------#
# checkOrightwall subroutine checks if a move along the outer right wall
# (X: [7], Y: [1, 6]) is a valid move
#---------------------------------------------------------------------#

checkOrightWall:lw $s2, colorTurn
	
		bne $a1, 7, notORW			# if $a1 != 7
		blez $a2, notORW			# if $a2 <= 0
		bge $a2, 7, notORW			# if $a2 >= 7
				
ORWifDisjoint:  sub $a2, $a2, 1				# decrement Y by 1 to check overhead adjacent cell

		move $s4, $ra
		jal getCMTelement			# return array[Y - 1][X]
		
		add $t0, $zero, $v0			# $t0 = condition helper variable 
							# (if register is greater than zero, than TLC is not disjointed
							
		sub $a1, $a1, 1				# decrement X to check adjacent left neg diagonal
		
		jal getCMTelement			# return array[Y - 1][X - 1]
		
		add $t0, $t0, $v0
		
		add $a2, $a2, 1				# restore Y value
		
		jal getCMTelement			# return array[Y][X - 1]
		
		add $t0, $t0, $v0

		add $a2, $a2, 1 			# increment Y by 1 to check adjacent left pos diagonal
		
		jal getCMTelement			# return array[Y + 1][X - 1]
		
		add $t0, $t0, $v0			
		
		add $a1, $a1, 1				# restore X value
		
		jal getCMTelement			# return array[Y + 1][X]
		
		add $t0, $t0, $v0			# increment condition helper variable
		
		sub $a2, $a2, 1				# restore Y value
		
		beq $t0, $zero, ORWcaseFailed		# if $t0 == 0, then TLC is disjointed
		add $t0, $zero, $zero			# restore condition helper variable
		
ORWifSandwhich: # check for sandwhiching
		jal ORW_sandwhich
		beq $v0, 1, ORWcaseFailed
		
		add $v0, $zero, $zero
		move $ra, $s4
		jr $ra
		
ORWcaseFailed: 	add $v0, $zero, 1
		move $ra, $s4
		jr $ra

notORW:		jr $ra

#---------------------------------------------------------------------#

ORW_sandwhich:  la $s0, board				# board
		lw $s1, dimSize				# row size 
		lw $s2, colorTurn			# color turn
		
		li $t0, 0				# cell counter
		li $t1, 6                               # cell counter limit
		li $t2, 0				# condition helper variable
		
		move $s5, $ra
		
ORW_vRows:	# Verify that (left) rows is a direction to check
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0				
		sub $s7, $s7, 8				# i = index (array[(x,y)]) - 8 (2 * 4 bytes)

  		sub $a1, $a1, 1				#
		jal getCMTelement			# return array[Y][X - 1]
		add $a1, $a1, 1				#
		
		beqz $v0, ORW_vUpCols			# if array[Y][X - 1] == 0
		beq $v0, $s2, ORW_vUpCols		# if array[Y][X - 1] == colorTurn
					
ORW_rows:      	lw $a0, ($s7)           		# load array[Y][X]
		
		# Cases to branch to depending on contents of the cell
		beqz $a0, ORW_breakR1
		beq $a0, $s2, ORW_trueR
		bne $a0, $s2, ORW_iterateR
		
ORW_breakR1:    # Branch to up columns if disjointed
		ble $a2, 1, ORW_breakR2			# if i <= 1
		
		b ORW_vUpCols

ORW_breakR2:    # Branch to down columns if disjointed & i <= 1
		b ORW_vDownCols
		
ORW_trueR:     	# Mark LR if same color is found & break
		add $t7, $zero, 1
		sw $t7, isLR
		
		add $t2, $t2, 1
		
		b ORW_breakR1
		
ORW_iterateR:   # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, ORW_breakR1
		
		sub $s7, $s7, 4
		
		b ORW_rows
		
ORW_vUpCols:   	# Verify that up columns is a direction to check
		add $t0, $zero, $zero			# i_o = 0
		sub $t1, $a2, 1				# i_f = Y - 1
		
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0
		sub $s7, $s7, 64			# array[cur] = array[(x,y)] - 64 (16 * 4 bytes)

		sub $a2, $a2, 1				#
		jal getCMTelement			# return array[Y - 1][X]
		add $a2, $a2, 1				#
		
		beqz $v0, ORW_vDownCols			# if array[Y - 1][X] == 0
		beq $v0, $s2, ORW_vDownCols		# if array[Y - 1][X] == colorTurn
				
ORW_upCols:   	lw $a0, ($s7)           		# load array[Y][X]
		
		# Cases to branch to depending on contents of the cell
		beqz $a0, ORW_breakUC1
		beq $a0, $s2, ORW_trueUC
		bne $a0, $s2, ORW_iterateUC
		
ORW_breakUC1:   # Branch to down columns if disjointed
		bge $a2, 6, ORW_breakUC2		# if i >= 6
		
		b ORW_vDownCols
		
ORW_breakUC2:	# Branch to neg diagonals if disjointed & i >= 6
		b ORW_vNegDiags
		
ORW_trueUC:     # Mark UC if same color is found & break
		add $t7, $zero, 1
		sw $t7, isUC
		
		add $t2, $t2, 1
		
		b ORW_breakUC1

ORW_iterateUC:  # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, ORW_breakUC1
		
		sub $s7, $s7, 32			# 32 => i -= (8 * 4 bytes)
		
		b ORW_upCols
		
ORW_vDownCols:  # Verify that down columns is a direction to check
		add $t0, $zero, $zero			# i_o = 0
		sub $t1, $s1, $a2			# i_f = (8 - Y)
		sub $t1, $t1, 2				# i_f = (8 - Y) - 2
		
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0
		add $s7, $s7, 64			# array[cur] = array[(x,y)] + 64 (16 * 4 bytes)

		add $a2, $a2, 1				#
		jal getCMTelement			# return array[Y + 1][X]
		sub $a2, $a2, 1				#
		
		beqz $v0, ORW_vPosDiags			# if array[Y + 1][X] == 0
		beq $v0, $s2, ORW_vPosDiags		# if array[Y + 1][X] == colorTurn
		
ORW_downCols:   lw $a0, ($s7)           		# load array[Y][X]
		
		# Cases to branch to depending on contents of the cell
		beqz $a0, ORW_breakDC1
		beq $a0, $s2, ORW_trueDC
		bne $a0, $s2, ORW_iterateDC
		
ORW_breakDC1:   # Branch to pos diagonals if disjointed
		bge $a2, 6, ORW_breakDC2		# if i >= 6
		
		b ORW_vPosDiags
		
ORW_breakDC2:   # Branch to neg diagonals if disjointed & i >= 6
		b ORW_vNegDiags
		
ORW_trueDC:     # Mark DC if same color is found & break
		add $t7, $zero, 1
		sw $t7, isDC
		
		add $t2, $t2, 1
		
		b ORW_breakDC1

ORW_iterateDC:  # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, ORW_breakDC1
		
		add $s7, $s7, 32			# 32 => i += (8 * 4 bytes)
		
		b ORW_downCols
		
ORW_vPosDiags:  # Verify that (down) positive diagonals is a direction to check
		add $t0, $zero, $zero			# i_o = 0
		sub $t1, $s1, $a2			# i_f = (8 - Y)
		sub $t1, $t1, 2				# i_f = (8 - Y) - 2
		
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0
		add $s7, $s7, 56			# array[cur] = array[(x,y)] + 56 (14 * 4 bytes)

		sub $a1, $a1, 1				#
		add $a2, $a2, 1				#
		jal getCMTelement			# return array[Y + 1][X - 1]
		add $a1, $a1, 1				#
		sub $a2, $a2, 1				#
		
		beqz $v0, ORW_vNegDiags			# if array[Y + 1][X - 1] == 0
		beq $v0, $s2, ORW_vNegDiags		# if array[Y + 1][X - 1] == colorTurn
		
ORW_posDiags:   lw $a0, ($s7)           		# load array[Y][X]

		# Cases to branch to depending on contents of the cell
		beqz $a0, ORW_breakPD1
		beq $a0, $s2, ORW_truePD
		bne $a0, $s2, ORW_iteratePD
		
ORW_breakPD1:   # Branch to neg diagonals if disjointed
		ble $a2, 1, ORW_breakPD2		# if i <= 1
		
		b ORW_vNegDiags
		
ORW_breakPD2:	# Break if disjointed & i <= 1
		b ORW_breakND
		
ORW_truePD:     # Mark DPD if same color is found & break
		add $t7, $zero, 1
		sw $t7, isDPD
		
		add $t2, $t2, 1
		
		b ORW_breakPD1

ORW_iteratePD:  # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, ORW_breakPD1
		
		add $s7, $s7, 28			# 28 => i += (7 * 4 bytes)
		
		b ORW_posDiags
		
ORW_vNegDiags:  # Verify that (up) negative diagonals is a direction to check
		add $t0, $zero, $zero			# i_o = 0
		sub $t1, $a2, 1				# i_f = Y - 1
		
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0
		sub $s7, $s7, 72			# array[cur] = array[(x,y)] - 72 (18 * 4 bytes)
		
		sub $a1, $a1, 1				#
		sub $a2, $a2, 1				#
		jal getCMTelement			# return array[Y - 1][X - 1]
		add $a1, $a1, 1				#
		add $a2, $a2, 1				#
		
		beqz $v0, ORW_breakND			# if array[Y - 1][X - 1] == 0
		beq $v0, $s2, ORW_breakND		# if array[Y - 1][X - 1] == colorTurn
		
ORW_negDiags:   lw $a0, ($s7)           		# load array[Y][X]
		
		# Cases to branch to depending on contents of the cell
		beqz $a0, ORW_breakND
		beq $a0, $s2, ORW_trueND
		bne $a0, $s2, ORW_iterateND
		
ORW_breakND:   	# Branch to exit (fail) if no other cases checked out or return true
		beqz $t2, ORW_sandExit
		
		add $v0, $zero, $zero
		
		move $ra, $s5
		jr $ra
		
ORW_trueND:     # Mark UND if same color is found & break
		add $t7, $zero, 1
		sw $t7, isUND
		
		add $t2, $t2, 1
		
		b ORW_breakND

ORW_iterateND:  # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, ORW_breakND
		
		sub $s7, $s7, 36			# # 36 => i -= (9 * 4 bytes)
		
		b ORW_negDiags
		
ORW_sandExit:	# Return false if nothing found
		add $v0, $zero, 1
		
		move $ra, $s5
		jr $ra

#---------------------------------------------------------------------#
# checkOceiling subroutine checks if a move along the outer ceiling 
# (X: [1, 6], Y: [0]) is a valid move
#---------------------------------------------------------------------#

checkOceiling:	lw $s2, colorTurn
	
		blez $a1, notOC				# if $a1 <= 0
		bge $a2, 7, notOC			# if $a1 >= 7
		bnez $a2, notOC				# if $a2 != 0
				
OCifDisjoint:   sub $a1, $a1, 1				# decrement X by 1 to check left adjacent cell

		move $s4, $ra
		jal getCMTelement			# return array[Y][X - 1]
		
		add $t0, $zero, $v0			# $t0 = condition helper variable 
							# (if register is greater than zero, than TLC is not disjointed
							
		add $a2, $a2, 1				# increment Y to check adjacent left pos diagonal
		
		jal getCMTelement			# return array[Y + 1][X - 1]
		
		add $t0, $t0, $v0
		
		add $a1, $a1, 1				# restore X value to check underlying adjacent cell
		
		jal getCMTelement			# return array[Y + 1][X]
		
		add $t0, $t0, $v0

		add $a1, $a1, 1 			# increment X by 1 to check adjacent right neg diagonal
		
		jal getCMTelement			# return array[Y + 1][X + 1]
		
		add $t0, $t0, $v0			
		
		sub $a2, $a2, 1				# restore Y value to check right adjacent cell
		
		jal getCMTelement			# return array[Y][X + 1]
		
		add $t0, $t0, $v0			# increment condition helper variable
		
		sub $a1, $a1, 1				# restore X value
		
		beq $t0, $zero, OCcaseFailed		# if $t0 == 0, then TLC is disjointed
		add $t0, $zero, $zero			# restore condition helper variable
		
OCifSandwhich:  # check for sandwhiching
		jal OC_sandwhich
		beq $v0, 1, OCcaseFailed
		
		add $v0, $zero, $zero
		move $ra, $s4
		jr $ra
		
OCcaseFailed: 	add $v0, $zero, 1
		move $ra, $s4
		jr $ra

notOC:		jr $ra

#---------------------------------------------------------------------#

OC_sandwhich:   la $s0, board				# board
		lw $s1, dimSize				# row size 
		lw $s2, colorTurn			# color turn
		
		li $t0, 0				# cell counter
		li $t1, 6                               # cell counter limit
		li $t2, 0				# condition helper variable
		
		move $s5, $ra
		
OC_vDownCols:	# Verify that down columns is a direction to check
		jal getCMTindex

		move $s7, $s0
		add $s7, $s7, $v0				
		add $s7, $s7, 64			# i = index (array[(x,y)]) + 64 (16 * 4 bytes)
		
		add $a2, $a2, 1				#
		jal getCMTelement			# return array[Y + 1][X]
		sub $a2, $a2, 1				#
		
		beqz $v0, OC_vLeftRows			# if array[Y + 1][X] == 0
		beq $v0, $s2, OC_vLeftRows		# if array[Y + 1][X] == colorTurn

OC_downCols:    lw $a0, ($s7)           		# load array[Y][X]
		
		beq $a0, $s2, OC_trueDC

		# Cases to branch to depending on contents of the cell
		beqz $a0, OC_breakDC1
		beq $a0, $s2, OC_trueDC
		bne $a0, $s2, OC_iterateDC
		
OC_breakDC1:    # Branch to left rows if disjointed
		ble $a1, 1, OC_breakDC2			# if i <= 1
	
		b OC_vLeftRows
		
OC_breakDC2:    # branch to right rows if disjointed & i <= 1
		b OC_vRightRows
		
OC_trueDC:      # Mark DC if same color is found & break
		add $t7, $zero, 1
		sw $t7, isDC
		
		add $t2, $t2, 1
		
		b OC_breakDC1

OC_iterateDC:   # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, OC_breakDC1
		
		add $s7, $s7, 32			# 32 => i += (8 * 4 bytes)
		
		b OC_downCols
		
OC_vLeftRows:   # Verify that left rows is a direction to check
		add $t0, $zero, $zero			# i_o = 0
		sub $t1, $a1, 1				# i_f = Y - 1
		
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0
		sub $s7, $s7, 8				# array[cur] = array[(x,y)] - 8 (2 * 4 bytes)
		
		sub $a1, $a1, 1				#
		jal getCMTelement			# return array[Y][X - 1]
		add $a1, $a1, 1				#
		
		beqz $v0, OC_vRightRows			# if array[Y][X - 1] == 0
		beq $v0, $s2, OC_vRightRows		# if array[Y][X - 1] == colorTurn
					
OC_leftRows:    lw $a0, ($s7)           		# load array[Y][X]

		# Cases to branch to depending on contents of the cell
		beqz $a0, OC_breakLR1
		beq $a0, $s2, OC_trueLR
		bne $a0, $s2, OC_iterateLR
		
OC_breakLR1:    # Branch to right rows if disjointed
		bge $a1, 6, OC_breakLR2			# if i >= 6
		
		b OC_vRightRows

OC_breakLR2:    # Branch to pos diagonals if disjointed & i >= 6
		b OC_vPosDiags
		
OC_trueLR:     	# Mark LR if same color is found & break
		add $t7, $zero, 1
		sw $t7, isLR
		
		add $t2, $t2, 1
		
		b OC_breakLR1
		
OC_iterateLR:   # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, OC_breakLR1
		
		sub $s7, $s7, 4
		
		b OC_leftRows
		
OC_vRightRows:  # Verify that right rows is a direction to check
		add $t0, $zero, $zero			# i_o = 0
		sub $t1, $s1, $a1			# i_f = (8 - X)
		sub $t1, $t1, 2				# i_f = (8 - X) - 2
		
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0
		add $s7, $s7, 8				# index = array[(x,y)] + 8 (2 * 4 bytes)
		
		add $a1, $a1, 1				#
		jal getCMTelement			# return array[Y][X + 1]
		sub $a1, $a1, 1				#
		
		beqz $v0, OC_vPosDiags			# if array[Y][X + 1] == 0
		beq $v0, $s2, OC_vPosDiags		# if array[Y][X + 1] == colorTurn
					
OC_rightRows:   lw $a0, ($s7)           		# load array[Y][X]

		# Cases to branch to depending on contents of the cell
		beqz $a0, OC_breakRR1
		beq $a0, $s2, OC_trueRR
		bne $a0, $s2, OC_iterateRR
		
OC_breakRR1:    # Branch to pos diagonals if disjointed
		ble $a1, 1, OC_breakRR2			# if i <= 1
		
		b OC_vPosDiags

OC_breakRR2:    # Branch to neg diagonals if disjointed & i <= 1
		b OC_vNegDiags
		
OC_trueRR:     	# Mark RR if same color is found & break
		add $t7, $zero, 1
		sw $t7, isRR
		
		add $t2, $t2, 1
		
		b OC_breakRR1
		
OC_iterateRR:   # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, OC_breakRR1
		
		add $s7, $s7, 4
		
		b OC_rightRows
				
OC_vPosDiags:   # Verify that (down) positive diagonals is a direction to check
		add $t0, $zero, $zero			# i_o = 0
		sub $t1, $a1, 1				# i_f = X - 1
		
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0
		add $s7, $s7, 56			# array[cur] = array[(x,y)] + 56 (14 * 4 bytes)

		sub $a1, $a1, 1				#
		add $a2, $a2, 1				#
		jal getCMTelement			# return array[Y + 1][X - 1]
		add $a1, $a1, 1				#
		sub $a2, $a2, 1				#
		
		beqz $v0, OC_vNegDiags			# if array[Y + 1][X - 1] == 0
		beq $v0, $s2, OC_vNegDiags              # if array[Y + 1][X - 1] == colorTurn
		
OC_posDiags:    lw $a0, ($s7)           		# load array[Y][X]

		# Cases to branch to depending on contents of the cell
		beqz $a0, OC_breakPD1
		beq $a0, $s2, OC_truePD
		bne $a0, $s2, OC_iteratePD
		
OC_breakPD1:    # Branch to neg diagonals if disjointed
		bge $a1, 6, OC_breakPD2			# if i >= 6

		b OC_vNegDiags
		
OC_breakPD2:	# Break if disjointed & i >= 6		
		b OC_breakND
		
OC_truePD:      # Mark DPD if same color is found & break
		add $t7, $zero, 1
		sw $t7, isDPD
		
		add $t2, $t2, 1
		
		b OC_breakPD1

OC_iteratePD:  # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, OC_breakPD1
		
		add $s7, $s7, 28			# 28 => i += (7 * 4 bytes)
		
		b OC_posDiags
		
OC_vNegDiags:   # Verify that (down) negative diagonals is a direction to check
		add $t0, $zero, $zero			# i_o = 0
		sub $t1, $s1, $a1			# i_f = (8 - X)
		sub $t1, $t1, 2				# i_f = (8 - X) - 2
		
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0
		add $s7, $s7, 72			# array[cur] = array[(x,y)] + 72 (18 * 4 bytes)
		
		add $a1, $a1, 1				#
		add $a2, $a2, 1				#
		jal getCMTelement			# return array[Y + 1][X + 1]
		sub $a1, $a1, 1				#
		sub $a2, $a2, 1				#
		
		beqz $v0, OC_breakND			# if array[Y + 1][X + 1] == 0
		beq $v0, $s2, OC_breakND		# if array[Y + 1][X + 1] == colorTurn
		
OC_negDiags:    lw $a0, ($s7)           		# load array[Y][X]

		# Cases to branch to depending on contents of the cell
		beqz $a0, OC_breakND
		beq $a0, $s2, OC_trueND
		bne $a0, $s2, OC_iterateND
		
OC_breakND:   	# Branch to exit (fail) if no other cases checked out or return true	
		beqz $t2, OC_sandExit
		
		add $v0, $zero, $zero
		
		move $ra, $s5
		jr $ra
		
OC_trueND:      # Mark DND if same color is found & break
		add $t7, $zero, 1
		sw $t7, isDND
		
		add $t2, $t2, 1
		
		b OC_breakND

OC_iterateND:   # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, OC_breakND
		
		add $s7, $s7, 36			# 36 => i += (9 * 4 bytes)
		
		b OC_negDiags
		
OC_sandExit:	# Return false if nothing found
		add $v0, $zero, 1
		
		move $ra, $s5
		jr $ra
		
#---------------------------------------------------------------------#
# checkOfloor subroutine checks if a move along the outer floor 
# (X: [1, 6], Y: [7]) is a valid move
#---------------------------------------------------------------------#
		
checkOfloor:	lw $s2, colorTurn
	
		blez  $a1, notOF			# if $a1 <= 0
		bge $a2, 7, notOF			# if $a1 >= 7
		bne $a2, 7, notOF			# if $a2 != 7
				
OFifDisjoint:   sub $a1, $a1, 1				# decrement X by 1 to check left adjacent cell

		move $s4, $ra
		jal getCMTelement			# return array[Y][X - 1]
		
		add $t0, $zero, $v0			# $t0 = condition helper variable 
							# (if register is greater than zero, than TLC is not disjointed
							
		sub $a2, $a2, 1				# decrement Y to check adjacent left neg diagonal
		
		jal getCMTelement			# return array[Y - 1][X - 1]
		
		add $t0, $t0, $v0
		
		add $a1, $a1, 1				# restore X value to check overhead adjacent cell
		
		jal getCMTelement			# return array[Y - 1][X]
		
		add $t0, $t0, $v0

		add $a1, $a1, 1 			# increment X by 1 to check adjacent right pos diagonal
		
		jal getCMTelement			# return array[Y - 1][X + 1]
		
		add $t0, $t0, $v0			
		
		add $a2, $a2, 1				# restore Y value to check right adjacent cell
		
		jal getCMTelement			# return array[Y][X + 1]
		
		add $t0, $t0, $v0			# increment condition helper variable
		
		sub $a1, $a1, 1				# restore X value
		
		beq $t0, $zero, OFcaseFailed		# if $t0 == 0, then TLC is disjointed
		add $t0, $zero, $zero			# restore condition helper variable
		
OFifSandwhich:  # check for sandwhiching
		jal OF_sandwhich
		beq $v0, 1, OFcaseFailed
		
		add $v0, $zero, $zero
		move $ra, $s4
		jr $ra
		
OFcaseFailed: 	add $v0, $zero, 1
		move $ra, $s4
		jr $ra

notOF:		jr $ra

#---------------------------------------------------------------------#

OF_sandwhich:   la $s0, board				# board
		lw $s1, dimSize				# row size 
		lw $s2, colorTurn			# color turn
		
		li $t0, 0				# cell counter
		li $t1, 6                               # cell counter limit
		li $t2, 0				# condition helper variable
		
		move $s5, $ra
		
OF_vUpCols:	# Verify that up columns is a direction to check
		jal getCMTindex

		move $s7, $s0
		
		add $s7, $s7, $v0				
		sub $s7, $s7, 64			# i = index (array[(x,y)]) + 64 (16 * 4 bytes)
		
		sub $a2, $a2, 1	
		jal getCMTelement			# return array[Y - 1][X]
		add $a2, $a2, 1
		
		beqz $v0, OF_vLeftRows

OF_upCols:    	lw $a0, ($s7)           		# load array[Y][X]
		
		beq $a0, $s2, OF_trueUC

		# Cases to branch to depending on contents of the cell
		beqz $a0, OF_breakUC1
		beq $a0, $s2, OF_trueUC
		bne $a0, $s2, OF_iterateUC
		
OF_breakUC1:    ble $a1, 1, OF_breakUC2			# if i <= 1
	
		b OF_vLeftRows
		
OF_breakUC2:    # branch to neg diagonals if disjointed & i <= 1
		b OF_vRightRows
		
OF_trueUC:      # Mark UC if same color is found & break
		add $t7, $zero, 1
		sw $t7, isUC
		
		add $t2, $t2, 1
		
		b OF_breakUC1

OF_iterateUC:   # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, OF_breakUC1
		
		sub $s7, $s7, 32			# 32 => i += (8 * 4 bytes)
		
		b OF_upCols
		
OF_vLeftRows:   # Verify that left rows is a direction to check
		add $t0, $zero, $zero			# i_o = 0
		sub $t1, $a1, 1				# i_f = Y - 1
		
		jal getCMTindex
		
		move $s7, $s0
		
		add $s7, $s7, $v0
		sub $s7, $s7, 8				# array[cur] = array[(x,y)] - 8 (2 * 4 bytes)
		
		sub $a1, $a1, 1	
		jal getCMTelement			# return array[Y][X - 1]
		add $a1, $a1, 1
		
		beqz $v0, OF_vRightRows
					
OF_leftRows:    lw $a0, ($s7)           		# load array[Y][X]

		# Cases to branch to depending on contents of the cell
		beqz $a0, OF_breakLR1
		beq $a0, $s2, OF_trueLR
		bne $a0, $s2, OF_iterateLR
		
OF_breakLR1:    # Branch to right rows if disjointed
		bge $a1, 6, OF_breakLR2			# if i >= 6
		
		b OF_vRightRows

OF_breakLR2:    # Branch to positive columns if disjointed & i >= 6
		b OF_vPosDiags
		
OF_trueLR:     	# Mark LR if same color is found & break
		add $t7, $zero, 1
		sw $t7, isLR
		
		add $t2, $t2, 1
		
		b OF_breakLR1
		
OF_iterateLR:   # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, OF_breakLR1
		
		sub $s7, $s7, 4
		
		b OF_leftRows
		
OF_vRightRows:  # Verify that right rows is a direction to check
		add $t0, $zero, $zero			# i_o = 0
		sub $t1, $s1, $a1			# i_f = (8 - X)
		sub $t1, $t1, 2				# i_f = (8 - X) - 2
		
		jal getCMTindex
		
		move $s7, $s0
		
		add $s7, $s7, $v0
		add $s7, $s7, 8				# index = array[(x,y)] + 8 (2 * 4 bytes)
		
		add $a1, $a1, 1	
		jal getCMTelement			# return array[Y][X + 1]
		sub $a1, $a1, 1
		
		beqz $v0, OF_vPosDiags
					
OF_rightRows:   lw $a0, ($s7)           		# load array[Y][X]

		# Cases to branch to depending on contents of the cell
		beqz $a0, OF_breakRR1
		beq $a0, $s2, OF_trueRR
		bne $a0, $s2, OF_iterateRR
		
OF_breakRR1:    # Branch to positive diagonals if disjointed
		ble $a1, 1, OF_breakRR2			# if i <= 1
		
		b OF_vPosDiags

OF_breakRR2:    # Branch to negative diagonals if disjointed &  i <= 1
		b OF_vNegDiags
		
OF_trueRR:     	# Mark RR if same color is found & break
		add $t7, $zero, 1
		sw $t7, isRR
		
		add $t2, $t2, 1
		
		b OF_breakRR1
		
OF_iterateRR:   # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, OF_breakRR1
		
		add $s7, $s7, 4
		
		b OF_rightRows
				
OF_vPosDiags:   # Verify that (up) positive diagonals is a direction to check
		add $t0, $zero, $zero			# i_o = 0
		sub $t1, $s1, $a1			# i_f = (8 - X)
		sub $t1, $t1, 2				# i_f = (8 - X) - 2
		
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0
		sub $s7, $s7, 56			# array[cur] = array[(x,y)] - 56 (14 * 4 bytes)

		add $a1, $a1, 1	
		sub $a2, $a2, 1
		jal getCMTelement			# return array[Y - 1][X + 1]
		sub $a1, $a1, 1
		add $a2, $a2, 1
		
		beqz $v0, OF_vNegDiags			# if array[Y - 1][X + 1] == 0
		beq $v0, $s2, OF_vNegDiags		# if array[Y - 1][X + 1] == colorTurn
		
OF_posDiags:    lw $a0, ($s7)           		# load array[Y][X]

		# Cases to branch to depending on contents of the cell
		beqz $a0, OF_breakPD1
		beq $a0, $s2, OF_truePD
		bne $a0, $s2, OF_iteratePD
		
OF_breakPD1:    # Branch to negative diagonals if disjointed
		bge $a1, 6, OF_breakPD2			# if i >= 6

		b OF_vNegDiags
		
OF_breakPD2:	# Break if disjointed & i >= 6		
		b OF_breakND
		
OF_truePD:      # Mark UPD if same color is found & break
		add $t7, $zero, 1
		sw $t7, isUPD
		
		add $t2, $t2, 1
		
		b OF_breakPD1

OF_iteratePD:  # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, OF_breakPD1
		
		sub $s7, $s7, 28			# # 36 => i -= (7 * 4 bytes)
		
		b OC_posDiags
		
OF_vNegDiags:   # Verify that (up) negative diagonals is a direction to check
		add $t0, $zero, $zero			# i_o = 0
		sub $t1, $a1, 1				# i_f = X - 1
		
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0
		sub $s7, $s7, 72			# array[cur] = array[(x,y)] - 72 (18 * 4 bytes)
		
		sub $a1, $a1, 1				#
		sub $a2, $a2, 1				#
		jal getCMTelement			# return array[Y - 1][X - 1]
		add $a1, $a1, 1				#
		add $a2, $a2, 1				#
		
		beqz $v0, OF_breakND			# if array[Y - 1][X - 1] == 0
		beq $v0, $s2, OF_breakND		# if array[Y - 1][X - 1] == colorTurn
		
OF_negDiags:    lw $a0, ($s7)           		# load array[Y][X]

		# Cases to branch to depending on contents of the cell
		beqz $a0, OF_breakND
		beq $a0, $s2, OF_trueND
		bne $a0, $s2, OF_iterateND
		
OF_breakND:   	# Branch to exit (fail) if no other cases checked out or return true	
		beqz $t2, OF_sandExit
		
		add $v0, $zero, $zero
		
		move $ra, $s5
		jr $ra
		
OF_trueND:      # Mark UND if same color is found & break
		add $t7, $zero, 1
		sw $t7, isUND
		
		add $t2, $t2, 1
		
		b OF_breakND

OF_iterateND:   # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, OF_breakND
		
		add $s7, $s7, 36			# # 36 => i += (9 * 4 bytes)
		
		b OF_negDiags
		
OF_sandExit:	# Return false if nothing found
		add $v0, $zero, 1
		
		move $ra, $s5
		jr $ra
		
#---------------------------------------------------------------------#
# checkITLcorner subroutine checks if the inner top left corner (1,1)
# is a valid move
#---------------------------------------------------------------------#

checkITLcorner: lw $s2, colorTurn
	
		bne $a1, 1, notITLC			# if $a1 != 1
		bne $a2, 1, notITLC			# if $a2 != 1
		
ITLCifDisjoint: add $a1, $a1, 1 			# increment X by 1 to check right adjacent cell
		
		move $s4, $ra
		jal getCMTelement
		
		add $t0, $zero, $v0			# $t0 = condition helper variable 
							# (if register is greater than zero, than TLC is not disjointed
		
		sub $a1, $a1, 1				# restore X value
		add $a2, $a2, 1				# increment Y by 1 to check right underlying adjacent cell
		
		jal getCMTelement
		
		add $t0, $t0, $v0			# increment condition helper variable
		
		add $a1, $a1, 1				# increment X by 1 to check decline diagonal
		
		jal getCMTelement
		
		add $t0, $t0, $v0			# increment condition helper variable
		beq $t0, $zero, ITLCcaseFailed		# if $t0 == 0, then TLC is disjointed
		
		sub $a1, $a1, 1				# restore X value
		sub $a2, $a2, 1				# restore Y value
		add $t0, $zero, $zero			# restore condition helper variable
		
ITLCifSandwhich:# check for sandwhiching
		jal ITLC_sandwhich
		beq $v0, 1, ITLCcaseFailed
		
		add $v0, $zero, $zero
		move $ra, $s4
		jr $ra
		
ITLCcaseFailed: add $v0, $zero, 1
		move $ra, $s4
		jr $ra

notITLC:	jr $ra

#---------------------------------------------------------------------#

ITLC_sandwhich:	la $s0, board				# board
		lw $s1, dimSize				# row size 
		lw $s2, colorTurn			# color turn
		
		li $t0, 0				# cell counter
		li $t1, 4                               # cell counter limit
		li $t2, 0				# condition helper variable
		
		move $s5, $ra
		
ITLC_vRows:	# Verify that (right) rows is a direction to check
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0				
		add $s7, $s7, 8				# i = index (array[(x,y)]) + 8 (2 * 4 bytes)	
		
		add $a1, $a1, 1
		jal getCMTelement			# if array[Y][X + 1]
		sub $a1, $a1, 1
		
		beqz $v0, ITLC_vDownCols			# if array[Y][X + 1] == 0
		beq $v0 $s2, ITLC_vDownCols		# if array[Y][X + 1] == colorTurn
				
ITLC_rows:      lw $a0, ($s7)           		# load array[Y][X]
		
		# Cases to branch to depending on contents of the cell
		beqz $a0, ITLC_breakR
		beq $a0, $s2, ITLC_trueR
		bne $a0, $s2, ITLC_iterateR
		
ITLC_breakR:    # Branch to columns if disjointed
		add $t0, $zero, $zero
		
		b ITLC_vDownCols
		
ITLC_trueR:     # Mark RR if same color is found & break
		add $t7, $zero, 1
		sw $t7, isRR
		
		add $t2, $t2, 1
		
		b ITLC_breakR
		
ITLC_iterateR:  # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, ITLC_breakR
		
		add $s7, $s7, 4
		
		b ITLC_rows
		
ITLC_vDownCols: # Verify that down columns is a direction to check
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0
		add $s7, $s7, 64			# array[cur] = array[(x,y)] +  64 (16 * 4 bytes)
		
		add $a2, $a2, 1
		jal getCMTelement			# return array[Y + 1][X]
		sub $a2, $a2, 1
		
		beqz $v0, ITLC_vNegDiags		# if array[Y + 1][X] == 0
		beq $v0, $s2, ITLC_vNegDiags		# if array[Y + 1][X] == colorTurn
		
ITLC_downCols:  lw $a0, ($s7)           		# load array[Y][X]
		
		# Cases to branch to depending on contents of the cell
		beqz $a0, ITLC_breakDC
		beq $a0, $s2, ITLC_trueDC
		bne $a0, $s2, ITLC_iterateDC
		
ITLC_breakDC:   # Branch to neg diagonals if disjointed
		add $t0, $zero, $zero
		
		b ITLC_vNegDiags
		
ITLC_trueDC:    # Mark DC if same color is found & break
		add $t7, $zero, 1
		sw $t7, isDC
		
		add $t2, $t2, 1
		
		b ITLC_breakDC

ITLC_iterateDC: # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, ITLC_breakDC
		
		add $s7, $s7, 32			# 32 => i += (8 * 4 bytes)
		
		b ITLC_downCols
		
ITLC_vNegDiags:	# Verify that (down) negative diagonals is a direction to check
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0
		add $s7, $s7, 72			# index = array[(x,y)] + 72 (18 * 4 bytes)
		
		add $a1, $a1, 1
		add $a2, $a2, 1
		jal getCMTelement			# if array[Y + 1][X + 1]
		sub $a1, $a1, 1
		sub $a2, $a2, 1
		
		beqz $v0, ITLC_breakND			# if array[Y + 1][X + 1] == 0 
		beq $v0, $s2 ITLC_breakND		# if array[Y + 1][X + 1] == colorTurn
		
ITLC_negDiags:  lw $a0, ($s7)           		# load array[Y][X]
		
		# Cases to branch to depending on contents of the cell
		beqz $a0, ITLC_breakND
		beq $a0, $s2, ITLC_trueND
		bne $a0, $s2, ITLC_iterateND
		
ITLC_breakND:   # Branch to exit (fail) if no other cases checked out or return true
		beqz $t2, ITLC_sandExit
		
		add $v0, $zero, $zero
		
		move $ra, $s5
		jr $ra
		
ITLC_trueND:    # Mark DND if same color is found & break
		add $t7, $zero, 1
		sw $t7, isDND
		
		add $t2, $t2, 1
		
		b ITLC_breakND
		
ITLC_iterateND: # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, ITLC_breakND
		
		add $s7, $s7, 36			# # 36 => i += (9 * 4 bytes)
		
		b ITLC_negDiags
		
ITLC_sandExit:	# Return false if nothing found
		add $v0, $zero, 1
		
		move $ra, $s5
		
		jr $ra
		
#---------------------------------------------------------------------#
# checkITRcorner subroutine checks if the inner top right corner (6,1)
# is a valid move
#---------------------------------------------------------------------#

checkITRcorner: lw $s2, colorTurn
	
		bne $a1, 6, notITRC			# if $a1 != 6
		bne $a2, 1, notITRC			# if $a2 != 1
		
ITRCifDisjoint: sub $a1, $a1, 1 			# decrement X by 1 to check left adjacent cell
		
		move $s4, $ra
		jal getCMTelement			# get array[Y][X - 1]
		
		add $t0, $zero, $v0			# $t0 = condition helper variable 
							# (if register is greater than zero, than TLC is not disjointed
		
		add $a1, $a1, 1				# restore X value
		add $a2, $a2, 1				# increment Y by 1 to check right underlying adjacent cell
		
		jal getCMTelement			# get array[Y + 1][X]
		
		add $t0, $t0, $v0			# increment condition helper variable
		
		sub $a1, $a1, 1				# decrement X by 1 to check decline diagonal
		
		jal getCMTelement			# get array[X - 1][Y + 1]
		
		add $t0, $t0, $v0			# increment condition helper variable
		beq $t0, $zero, ITRCcaseFailed		# if $t0 == 0, then TLC is disjointed
		
		add $a1, $a1, 1				# restore X value
		sub $a2, $a2, 1				# restore Y value
		add $t0, $zero, $zero			# restore condition helper variable
		
ITRifSandwhich: # check for sandwhiching
		jal ITRC_sandwhich
		beq $v0, 1, ITRCcaseFailed
		
		add $v0, $zero, $zero
		move $ra, $s4
		jr $ra
		
ITRCcaseFailed: add $v0, $zero, 1
		move $ra, $s4
		jr $ra
		
notITRC:	jr $ra

#---------------------------------------------------------------------#

ITRC_sandwhich:	la $s0, board				# board
		lw $s1, dimSize				# row size 
		lw $s2, colorTurn			# color turn
		
		li $t0, 0				# cell counter
		li $t1, 4                               # cell counter limit
		li $t2, 0				# condition helper variable
		
		move $s5, $ra
		
ITRC_vRows:	# Verify that (left) rows is a direction to check
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0				
		sub $s7, $s7, 8				# i = index (array[(x,y)]) - 8 (2 * 4 bytes)	
		
		sub $a1, $a1, 1
		jal getCMTelement			# return array[Y][X - 1]
		add $a1, $a1, 1	
		
		beqz $v0, ITRC_vDownCols		# if array[Y][X - 1] == 0
		beq $v0, $s2, ITRC_vDownCols		# if array[Y][X - 1] == colorTurn
						
ITRC_rows:      lw $a0, ($s7)           		# load array[Y][X]

		# Cases to branch to depending on contents of the cell
		beqz $a0, ITRC_breakR
		beq $a0, $s2, ITRC_trueR
		bne $a0, $s2, ITRC_iterateR
		
ITRC_breakR:    # Branch to columns if disjointed
		add $t0, $zero, $zero
		
		b ITRC_vDownCols
		
ITRC_trueR:     # Mark LR if same color is found & break
		add $t7, $zero, 1
		sw $t7, isLR
		
		add $t2, $t2, 1
		
		b ITRC_breakR
		
ITRC_iterateR:  # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, ITRC_breakR
		
		sub $s7, $s7, 4
		
		b ITRC_rows
		
ITRC_vDownCols: # Verify that down columns is a direction to check
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0
		add $s7, $s7, 64			# array[cur] = array[(x,y)] +  64 (16 * 4 bytes)
		
		add $a2, $a2, 1
		jal getCMTelement			# return array[Y + 1][X]
		sub $a2, $a2, 1
		
		beqz $v0, ITRC_vPosDiags
		beq $v0, $s2, ITRC_vPosDiags
						
ITRC_downCols:  lw $a0, ($s7)           		# load array[Y][X]

		# Cases to branch to depending on contents of the cell
		beqz $a0, ITRC_breakDC
		beq $a0, $s2, ITRC_trueDC
		bne $a0, $s2, ITRC_iterateDC
		
ITRC_breakDC:   # Branch to pos diagonals if disjointed
		add $t0, $zero, $zero
		
		b ITRC_vPosDiags
		
ITRC_trueDC:    # Mark DC if same color is found & break
		add $t7, $zero, 1
		sw $t7, isDC
		
		add $t2, $t2, 1
		
		b ITRC_breakDC

ITRC_iterateDC: # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, ITRC_breakDC
		
		add $s7, $s7, 32			# 32 => i += (8 * 4 bytes)
		
		b ITRC_downCols
		
ITRC_vPosDiags: # Verify that (down) positive diagonals is a direction to check
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0
		add $s7, $s7, 56			# index = array[(x,y)] + 56 (14 * 4 bytes)
		
		sub $a1, $a1, 1
		add $a2, $a2, 1
		jal getCMTelement			# return array[Y + 1][X - 1]
		add $a1, $a1, 1
		sub $a2, $a2, 1
		
		beqz $v0, ITRC_breakPD			# if array[Y + 1][X - 1] == 0
		beq $v0, $s2, ITRC_breakPD		# if array[Y + 1][X - 1] == colorTurn
		
ITRC_posDiags:  lw $a0, ($s7)           		# load array[Y][X]

		# Cases to branch to depending on contents of the cell
		beqz $a0, ITRC_breakPD
		beq $a0, $s2, ITRC_truePD
		bne $a0, $s2, ITRC_iteratePD
		
ITRC_breakPD:   # Branch to exit (fail) if no other cases checked out or return true
		beqz $t2, ITRC_sandExit
		
		add $v0, $zero, $zero
		
		move $ra, $s5
		jr $ra
		
ITRC_truePD:    # Mark DPD if same color is found & break
		add $t7, $zero, 1
		sw $t7, isDPD
		
		add $t2, $t2, 1
		
		b ITRC_breakPD

ITRC_iteratePD: # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, ITRC_breakPD
		
		add $s7, $s7, 28			# # 36 => i += (7 * 4 bytes)
		
		b ITRC_posDiags
		
ITRC_sandExit:	# Return false if nothing found
		add $v0, $zero, 1
		
		move $ra, $s5
		jr $ra
		
#---------------------------------------------------------------------#
# checkIBLcorner subroutine checks if the inner bottom left corner (1,6)
# is a valid move
#---------------------------------------------------------------------#

checkIBLcorner: lw $s2, colorTurn
	
		bne $a1, 1, notIBLC			# if $a1 != 1
		bne $a2, 6, notIBLC			# if $a2 != 6
		
IBLifDisjoint:  add $a1, $a1, 1 			# increment X by 1 to check right adjacent cell
		
		move $s4, $ra
		jal getCMTelement			# return array[Y][X + 1]
		
		add $t0, $zero, $v0			# $t0 = condition helper variable 
							# (if register is greater than zero, than TLC is not disjointed
		
		sub $a1, $a1, 1				# restore X value
		sub $a2, $a2, 1				# decrement Y by 1 to check right underlying adjacent cell
		
		jal getCMTelement			# return array[Y - 1][X]
		
		add $t0, $t0, $v0			# increment condition helper variable
		
		add $a1, $a1, 1				# increment X by 1 to check decline diagonal
		
		jal getCMTelement			# return array[Y - 1][X + 1]
		
		add $t0, $t0, $v0			# increment condition helper variable
		beq $t0, $zero, IBLCcaseFailed		# if $t0 == 0, then TLC is disjointed
		
		sub $a1, $a1, 1				# restore X value
		add $a2, $a2, 1				# restore Y value
		add $t0, $zero, $zero			# restore condition helper variable
		
IBLifSandwhich: # check for sandwhiching
		jal IBLC_sandwhich
		beq $v0, 1, IBLCcaseFailed
		
		add $v0, $zero, $zero
		move $ra, $s4
		jr $ra
		
IBLCcaseFailed: add $v0, $zero, 1
		move $ra, $s4
		jr $ra

notIBLC:	jr $ra

#---------------------------------------------------------------------#

IBLC_sandwhich:	la $s0, board				# board
		lw $s1, dimSize				# row size 
		lw $s2, colorTurn			# color turn
		
		li $t0, 0				# cell counter
		li $t1, 4                               # cell counter limit
		li $t2, 0				# condition helper variable
		
		move $s5, $ra
		
IBLC_vRows:	# Verify that (right) rows is a direction to check
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0				
		add $s7, $s7, 8				# i = index (array[(x,y)]) + 8 (2 * 4 bytes)	
		
		add $a1, $a1, 1
		jal getCMTelement			# return array[Y][X + 1]
		sub $a1, $a1, 1
		
		beqz $v0, IBLC_vUpCols			# if array[Y][X + 1] == 0
		beq $v0, $s2, IBLC_vUpCols		# if array[Y][X + 1] == colorTurn		
		
IBLC_rows:      lw $a0, ($s7)           		# load array[Y][X]
		
		# Cases to branch to depending on contents of the cell
		beqz $a0, IBLC_breakR
		beq $a0, $s2, IBLC_trueR
		bne $a0, $s2, IBLC_iterateR
		
IBLC_breakR:    # Branch to columns if disjointed
		add $t0, $zero, $zero
		
		b IBLC_vUpCols
		
IBLC_trueR:     # Mark RR if same color is found & break
		add $t7, $zero, 1
		sw $t7, isRR
	
		add $t2, $t2, 1
		
		b IBLC_breakR
		
IBLC_iterateR:  # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, IBLC_breakR
		
		add $s7, $s7, 4
		
		b IBLC_rows
		
IBLC_vUpCols:   # Verify that up columns is a direction to check
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0
		sub $s7, $s7, 64			# array[cur] = array[(x,y)] +  64 (16 * 4 bytes)
		
		sub $a2, $a2, 1
		jal getCMTelement			# return array[Y - 1][X]
		add $a2, $a2, 1
		
		beqz $v0, IBLC_vPosDiags			# if array[Y - 1][X] == 0
		beq $v0, $s2, IBLC_vPosDiags		# if array[Y - 1][X] == colorTurn
						
IBLC_upCols:   	lw $a0, ($s7)           		# load array[Y][X]
		
		# Cases to branch to depending on contents of the cell
		beqz $a0, IBLC_breakUC
		beq $a0, $s2, IBLC_trueUC
		bne $a0, $s2, IBLC_iterateUC
		
IBLC_breakUC:   # Branch to pos diagonals if disjointed
		add $t0, $zero, $zero
		
		b IBLC_vPosDiags
		
IBLC_trueUC:    # Mark UC if same color is found & break
		add $t7, $zero, 1
		sw $t7, isUC
		
		add $t2, $t2, 1
		
		b IBLC_breakUC

IBLC_iterateUC: # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, IBLC_breakUC
		
		sub $s7, $s7, 32			# 32 => i += (8 * 4 bytes)
		
		b IBLC_upCols

IBLC_vPosDiags: # Verify that (up) positive diagonals is a direction to check
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0
		sub $s7, $s7, 56			# index = array[(x,y)] - 56 (14 * 4 bytes)
		
		add $a1, $a1, 1
		sub $a2, $a2, 1
		jal getCMTelement			# return array[Y - 1][X + 1]
		sub $a1, $a1, 1
		add $a2, $a2, 1
		
		beqz $v0, IBLC_breakPD			# if array[Y - 1][X + 1] == 0
		beq $v0, $s2, IBLC_breakPD		# if array[Y - 1][X + 1] == colorTurn
		
IBLC_posDiags:  lw $a0, ($s7)           		# load array[Y][X]
		
		# Cases to branch to depending on contents of the cell
		beqz $a0, IBLC_breakPD
		beq $a0, $s2, IBLC_truePD
		bne $a0, $s2, IBLC_iteratePD
		
IBLC_breakPD:   # Branch to exit (fail) if no other cases checked out or return true
		beqz $t2, IBLC_sandExit
		
		add $v0, $zero, $zero
		
		move $ra, $s5
		jr $ra
		
IBLC_truePD:    # Mark UPD if same color is found & break
		add $t7, $zero, 1
		sw $t7, isUPD
		
		add $t2, $t2, 1
		
		b IBLC_breakPD

IBLC_iteratePD: # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, IBLC_breakPD
		
		sub $s7, $s7, 28			# 28 => i -= (7 * 4 bytes)
		
		b IBLC_posDiags
		
IBLC_sandExit:	# Return false if nothing found
		add $v0, $zero, 1
		
		move $ra, $s5
		jr $ra
		
#---------------------------------------------------------------------#
# checkIBRcorner subroutine checks if the inner bottom right corner (6,6)
# is a valid move
#---------------------------------------------------------------------#

checkIBRcorner: lw $s2, colorTurn
	
		bne $a1, 6, notIBRC			# if $a1 != 6
		bne $a2, 6, notIBRC			# if $a2 != 6
		
IBRifDisjoint:  sub $a1, $a1, 1 			# decrement X by 1 to check left adjacent cell
		
		move $s4, $ra
		jal getCMTelement			# return array[Y][X - 1]
		
		add $t0, $zero, $v0			# $t0 = condition helper variable 
							# (if register is greater than zero, than TLC is not disjointed
		
		add $a1, $a1, 1				# restore X value
		sub $a2, $a2, 1				# decrement Y by 1 to check right underlying adjacent cell
		
		jal getCMTelement			# return array[Y - 1][X]
		
		add $t0, $t0, $v0			# increment condition helper variable
		
		sub $a1, $a1, 1				# decrement X by 1 to check decline diagonal
		
		jal getCMTelement			# return array[Y - 1][X - 1]
		
		add $t0, $t0, $v0			# increment condition helper variable
		beq $t0, $zero, IBRCcaseFailed		# if $t0 == 0, then TLC is disjointed
		
		add $a1, $a1, 1				# restore X value
		add $a2, $a2, 1				# restore Y value
		add $t0, $zero, $zero			# restore condition helper variable
		
IBRifSandwhich: # check for sandwhiching
		jal IBRC_sandwhich
		beq $v0, 1, IBRCcaseFailed
		
		add $v0, $zero, $zero
		move $ra, $s4
		jr $ra
		
IBRCcaseFailed: add $v0, $zero, 1
		move $ra, $s4
		jr $ra
		
notIBRC:	jr $ra

#---------------------------------------------------------------------#

IBRC_sandwhich:	la $s0, board				# board
		lw $s1, dimSize				# row size 
		lw $s2, colorTurn			# color turn
		
		li $t0, 0				# cell counter
		li $t1, 4                               # cell counter limit
		li $t2, 0				# condition helper variable
		
		move $s5, $ra
		
IBRC_vRows:	# Verify that (left) rows is a direction to check
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0				
		sub $s7, $s7, 8				# i = index (array[(x,y)]) - 8 (2 * 4 bytes)	
		
		sub $a1, $a1, 1
		jal getCMTelement			# return array[Y][X - 1]
		add $a1, $a1, 1	
		
		beqz $v0, IBRC_vUpCols			# if array[Y][X - 1] == 0
		beq $v0, $s2, IBRC_vUpCols		# if array[Y][X - 1] == colorTurn
		
IBRC_rows:      lw $a0, ($s7)           		# load array[Y][X]
		
		# Cases to branch to depending on contents of the cell
		beqz $a0, IBRC_breakR
		beq $a0, $s2, IBRC_trueR
		bne $a0, $s2, IBRC_iterateR
		
IBRC_breakR:     # Branch to columns if disjointed
		add $t0, $zero, $zero
		
		b IBRC_vUpCols
		
IBRC_trueR:     # Mark LR if same color is found & break
		add $t7, $zero, 1
		sw $t7, isLR
		
		add $t2, $t2, $1
		
		b IBRC_breakR
		
IBRC_iterateR:  # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, IBRC_breakR
		
		sub $s7, $s7, 4
		
		b IBRC_rows
		
IBRC_vUpCols:	# Verify that up columns is a direction to check
		jal getCMTindex

		move $s7, $s0
		add $s7, $s7, $v0
		sub $s7, $s7, 64			# array[cur] = array[(x,y)] - 64 (16 * 4 bytes)
		
		sub $a2, $a2, 1
		jal getCMTelement			# return array[Y - 1][X]
		add $a2, $a2, 1
		
		beqz $v0, IBRC_vNegDiags		# if array[Y - 1][X] == 0
		beq $v0, $s2, IBRC_vNegDiags		# if array[Y - 1][X] == colorTurn
						
IBRC_upCols:   	lw $a0, ($s7)           		# load array[Y][X]
		
		# Cases to branch to depending on contents of the cell
		beqz $a0, IBRC_breakUC
		beq $a0, $s2, IBRC_trueUC
		bne $a0, $s2, IBRC_iterateUC
		
IBRC_breakUC:   # Branch to neg diagonals if disjointed
		add $t0, $zero, $zero
		
		b IBRC_vNegDiags
		
IBRC_trueUC:    # Mark UC if same color is found & break
		add $t7, $zero, 1
		sw $t7, isUC
		
		add $t2, $t2, $1
		
		b IBRC_breakUC

IBRC_iterateUC: # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, IBRC_breakUC
		
		sub $s7, $s7, 32			# 32 => i += (8 * 4 bytes)
		
		b IBRC_upCols
		
IBRC_vNegDiags: # Verify that (up) negative diagonals is a direction to check
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0
		sub $s7, $s7, 72			# index = array[(x,y)] - 72 (18 * 4 bytes)
		
		sub $a1, $a1, 1
		sub $a2, $a2, 1
		jal getCMTelement			# return array[Y - 1][X - 1]
		add $a1, $a1, 1
		add $a2, $a2, 1
		
		beqz $v0, IBRC_breakND			# if array[Y - 1][X - 1] == 0
		beq $v0, $s2, IBRC_breakND		# if array[Y - 1][X - 1] == colorTurn
		
IBRC_negDiags:  lw $a0, ($s7)           		# load array[Y][X]

		# Cases to branch to depending on contents of the cell
		beqz $a0, IBRC_breakND
		beq $a0, $s2, IBRC_trueND
		bne $a0, $s2, IBRC_iterateND
		
IBRC_breakND:   # Branch to exit (fail) if no other cases checked out or return true
		beqz $t2, IBRC_sandExit
		
		add $v0, $zero, $zero
		
		move $ra, $s5
		jr $ra
		
IBRC_trueND:    # Mark UND if same color is found & break
		add $t7, $zero, 1
		sw $t7, isUND
		
		add $t2, $t2, $1
		
		b IBRC_breakND

IBRC_iterateND: # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, IBRC_breakND
		
		sub $s7, $s7, 36			# 36 => i -= (9 * 4 bytes)
		
		b IBRC_negDiags
		
IBRC_sandExit:	# Return false if nothing found
		add $v0, $zero, 1
		
		move $ra, $s5
		jr $ra
		
#---------------------------------------------------------------------#
# checkIleftwall subroutine checks if a move along the inner left wall
# (X: [1], Y: [2, 5]) is a valid move
#---------------------------------------------------------------------#

checkIleftWall: lw $s2, colorTurn
	
		bne $a1, 1, notILW			# if $a1 != 1
		ble $a2, 1, notILW			# if $a2 <= 1
		bge $a2, 6, notILW			# if $a2 >= 6
				
ILWifDisjoint:  sub $a2, $a2, 1				# decrement Y by 1 to check overhead adjacent cell

		move $s4, $ra
		jal getCMTelement			# return array[Y - 1][X]
		
		add $t0, $zero, $v0			# $t0 = condition helper variable 
							# (if register is greater than zero, than TLC is not disjointed
							
		add $a1, $a1, 1				# increment X by 1 to check right adjacent pos diagonal
		
		jal getCMTelement			# return array[Y - 1][X + 1]
		
		add $t0, $t0, $v0
		
		add $a2, $a2, 1				# restore Y value to check right adjacent cell
		
		jal getCMTelement			# return array[Y][X + 1]
		
		add $t0, $t0, $v0

		add $a2, $a2, 1 			# increment Y by 1 to check adjacent right adjacent cell
		
		jal getCMTelement			# return array[Y + 1][X + 1]
		
		add $t0, $t0, $v0			
		
		sub $a1, $a1, 1				# restore X value to check underlying adjacent cell
		
		jal getCMTelement			# return array[Y + 1][X]
		
		add $t0, $t0, $v0			# increment condition helper variable
		
		sub $a2, $a2, 1				# restore Y value
		
		beq $t0, $zero, ILWcaseFailed		# if $t0 == 0, then TLC is disjointed
		
		add $t0, $zero, $zero			# restore condition helper variable
		
ILWifSandwhich: # check for sandwhiching
		jal ILW_sandwhich
		beq $v0, 1, ILWcaseFailed
		
		add $v0, $zero, $zero
		move $ra, $s4
		jr $ra
		
ILWcaseFailed: 	add $v0, $zero, 1
		move $ra, $s4
		jr $ra

notILW:		jr $ra

#---------------------------------------------------------------------#

ILW_sandwhich:  la $s0, board				# board
		lw $s1, dimSize				# row size 
		lw $s2, colorTurn			# color turn
		
		li $t0, 0				# cell counter
		li $t1, 4                               # cell counter limit
		li $t2, 0				# condition helper variable
		
		move $s5, $ra
		
ILW_vRows:	# Verify that (right) rows is a direction to check
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0				
		add $s7, $s7, 8				# i = index (array[(x,y)]) + 8 (2 * 4 bytes)	
		
		add $a1, $a1, 1	
		jal getCMTelement			# return array[Y][X + 1]
		sub $a1, $a1, 1
		
		beqz $v0, ILW_vUpCols			# if array[Y][X + 1] == 0
		beq $v0, $s2, ILW_vUpCols		# if array[Y][X + 1] == colorTurn
		
ILW_rows:      	lw $a0, ($s7)           		# load array[Y][X]
		
		# Cases to branch to depending on contents of the cell
		beqz $a0, ILW_breakR1
		beq $a0, $s2, ILW_trueR
		bne $a0, $s2, ILW_iterateR
		
ILW_breakR1:    # Branch to columns if disjointed
		ble $a2, 1, ILW_breakR2			# if i <= 1
		
		b ILW_vUpCols

ILW_breakR2:    # Branch to down columns if disjointed & i <= 1
		b ILW_vDownCols
		
ILW_trueR:     	# Mark RR if same color is found & break
		add $t7, $zero, 1
		sw $t7, isRR
		
		add $t2, $t2, 1
		
		b ILW_breakR1
		
ILW_iterateR:   # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, ILW_breakR1
		
		add $s7, $s7, 4
		
		b ILW_rows
		
ILW_vUpCols:   	# Verify that up columns is a direction to check
		add $t0, $zero, $zero			# i_o = 0
		sub $t1, $a2, 2				# i_f = Y - 2
		
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0
		sub $s7, $s7, 64			# array[cur] = array[(x,y)] - 64 (16 * 4 bytes)
		
		sub $a2, $a2, 1				#
		jal getCMTelement			# return array[Y - 1][X]
		add $a2, $a2, 1				#
		
		beqz $v0, ILW_vDownCols			# if array[Y - 1][X] == 0
		beq $v0, $s2, ILW_vDownCols		# if array[Y - 1][X] == colorTurn
						
ILW_upCols:   	lw $a0, ($s7)           		# load array[Y][X]
		
		# Cases to branch to depending on contents of the cell
		beqz $a0, ILW_breakUC1
		beq $a0, $s2, ILW_trueUC
		bne $a0, $s2, ILW_iterateUC
		
ILW_breakUC1:   # Branch to down columns if disjointed
		bge $a2, 6, ILW_breakUC2		# if i >= 6
		
		b ILW_vDownCols
		
ILW_breakUC2:	# Branch to pos diagonals if disjointed & i >= 6
		b ILW_vPosDiags
		
ILW_trueUC:     # Mark UC if same color is found & break
		add $t7, $zero, 1
		sw $t7, isUC
		
		add $t2, $t2, 1
		
		b IF_breakUC1

ILW_iterateUC:  # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, ILW_breakUC1
		
		sub $s7, $s7, 32			# 32 => i -= (8 * 4 bytes)
		
		b ILW_upCols
		
ILW_vDownCols:  # Verify that down columns is a direction to check
		add $t0, $zero, $zero			# i_o = 0
		sub $t1, $s1, $a2			# i_f = (8 - Y)
		sub $t1, $t1, 3				# i_f = (8 - Y) - 3
		
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0
		add $s7, $s7, 64			# array[cur] = array[(x,y)] + 64 (16 * 4 bytes)

		add $a2, $a2, 1				#
		jal getCMTelement			# return array[Y + 1][X]
		sub $a2, $a2, 1				#
		
		beqz $v0, ILW_vPosDiags			# if array[Y + 1][X] == 0
		beq $v0, $s2, ILW_vPosDiags		# if array[Y + 1][X] == colorTurn
		
ILW_downCols:   lw $a0, ($s7)           		# load array[Y][X]
		
		# Cases to branch to depending on contents of the cell
		beqz $a0, ILW_breakDC1
		beq $a0, $s2, ILW_trueDC
		bne $a0, $s2, ILW_iterateDC
		
ILW_breakDC1:   # Branch to pos diagonals if disjointed
		ble $a2, 1, ILW_breakDC2		# if i <= 1
		
		b ILW_vPosDiags
		
ILW_breakDC2:   # branch to neg diagonals if disjointed & i <= 1
		b ILW_vNegDiags
		
ILW_trueDC:     # Mark DC if same color is found & break
		add $t7, $zero, 1
		sw $t7, isDC
		
		add $t2, $t2, 1
		
		b ILW_breakDC1

ILW_iterateDC:  # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, ILW_breakDC1
		
		add $s7, $s7, 32			# 32 => i += (8 * 4 bytes)
		
		b ILW_downCols

ILW_vPosDiags:  # Verify that (up) positive diagonals is a direction to check
		add $t0, $zero, $zero			# i_o = 0
		sub $t1, $a2, 2				# i_f = Y - 2
		
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0
		sub $s7, $s7, 56			# array[cur] = array[(x,y)] - 56 (14 * 4 bytes)
		
		add $a1, $a1, 1				#
		sub $a2, $a2, 1				#
		jal getCMTelement			# return array[Y - 1][X + 1]
		sub $a1, $a1, 1				#
		add $a2, $a2, 1				#
		
		beqz $v0, ILW_vNegDiags			# if array[Y - 1][X + 1] == 0
		beq $v0, $s2, ILW_vNegDiags		# if array[Y - 1][X + 1] == colorTurn
		
ILW_posDiags:   lw $a0, ($s7)           		# load array[Y][X]

		# Cases to branch to depending on contents of the cell
		beqz $a0, ILW_breakPD1
		beq $a0, $s2, ILW_truePD
		bne $a0, $s2, ILW_iteratePD
		
ILW_breakPD1:   # Branch to neg diagonals if disjointed
		bge $a2, 6, ILW_breakPD2		# if i >= 6
		
		b ILW_vNegDiags
		
ILW_breakPD2:	# Branch to OLW exit if disjointed & i >= 6
		b ILW_breakND
		
ILW_truePD:     # Mark UPD if same color is found & break
		add $t7, $zero, 1
		sw $t7, isUPD
		
		add $t2, $t2, 1
		
		b IF_breakPD1

ILW_iteratePD:  # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, ILW_breakPD1
		
		sub $s7, $s7, 28			# 28 => i -= (7 * 4 bytes)
		
		b ILW_posDiags
		
ILW_vNegDiags:  # Verify that (down) negative diagonals is a direction to check
		add $t0, $zero, $zero			# i_o = 0
		sub $t1, $s1, $a2			# i_f = (8 - Y)
		sub $t1, $t1, 3				# i_f = (8 - Y) - 3
		
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0
		add $s7, $s7, 72			# index = array[(x,y)] + 72 (18 * 4 bytes)

		add $a1, $a1, 1				#
		add $a2, $a2, 1				#
		jal getCMTelement			# return array[Y + 1][X + 1]
		sub $a1, $a1, 1				#
		sub $a2, $a2, 1				#
		
		beqz $v0, ILW_breakND			# if array[Y + 1][X + 1] == 0
		beq $v0, $s2, ILW_breakND		# if array[Y + 1][X + 1] == colorTurn
				
ILW_negDiags:   lw $a0, ($s7)           		# load array[Y][X]
		
		# Cases to branch to depending on contents of the cell
		beqz $a0, ILW_breakND
		beq $a0, $s2, ILW_trueND
		bne $a0, $s2, ILW_iterateND
		
ILW_breakND:   	# Branch to exit (fail) if no other cases checked out or return true
		beqz $t2, ILW_sandExit
		
		add $v0, $zero, $zero
		
		move $ra, $s5
		jr $ra
		
ILW_trueND:     # Mark DND if same color is found & break
		add $t7, $zero, 1
		sw $t7, isDND
		
		add $t2, $t2, 1
		
		b IF_breakND
	
ILW_iterateND:  # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, ILW_breakND
		
		add $s7, $s7, 36			# # 36 => i += (9 * 4 bytes)
		
		b ILW_negDiags
		
ILW_sandExit:	# Return false if nothing found
		add $v0, $zero, 1
		
		move $ra, $s5
		
		jr $ra

#---------------------------------------------------------------------#
# checkIrightwall subroutine checks if a move along the inner right wall
# (X: [6], Y: [2, 5]) is a valid move
#---------------------------------------------------------------------#

checkIrightWall:lw $s2, colorTurn
	
		bne $a1, 6, notIRW			# if $a1 != 6
		ble $a2, 1, notIRW			# if $a2 <= 1
		bge $a2, 6, notIRW			# if $a2 >= 6
				
IRWifDisjoint:  sub $a2, $a2, 1				# decrement Y by 1 to check overhead adjacent cell

		move $s4, $ra
		jal getCMTelement			# return array[Y - 1][X]
		
		add $t0, $zero, $v0			# $t0 = condition helper variable 
							# (if register is greater than zero, than TLC is not disjointed
							
		sub $a1, $a1, 1				# decrement X to check adjacent left neg diagonal
		
		jal getCMTelement			# return array[Y - 1][X - 1]
		
		add $t0, $t0, $v0
		
		add $a2, $a2, 1				# restore Y value
		
		jal getCMTelement			# return array[Y][X - 1]
		
		add $t0, $t0, $v0

		add $a2, $a2, 1 			# increment Y by 1 to check adjacent left pos diagonal
		
		jal getCMTelement			# return array[Y + 1][X - 1]
		
		add $t0, $t0, $v0			
		
		add $a1, $a1, 1				# restore X value
		
		jal getCMTelement			# return array[Y + 1][X]
		
		add $t0, $t0, $v0			# increment condition helper variable
		
		sub $a2, $a2, 1				# restore Y value
		
		beq $t0, $zero, IRWcaseFailed		# if $t0 == 0, then TLC is disjointed
		add $t0, $zero, $zero			# restore condition helper variable
		
IRWifSandwhich: # check for sandwhiching
		jal IRW_sandwhich
		beq $v0, 1, IRWcaseFailed
		
		add $v0, $zero, $zero
		move $ra, $s4
		jr $ra
		
IRWcaseFailed: 	add $v0, $zero, 1
		move $ra, $s4
		jr $ra

notIRW:		jr $ra

#---------------------------------------------------------------------#

IRW_sandwhich:  la $s0, board				# board
		lw $s1, dimSize				# row size 
		lw $s2, colorTurn			# color turn
		
		li $t0, 0				# cell counter
		li $t1, 4                               # cell counter limit
		li $t2, 0				# condition helper variable
		
		move $s5, $ra
		
IRW_vRows:	# Verify that (left) rows is a direction to check
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0				
		sub $s7, $s7, 8				# i = index (array[(x,y)]) - 8 (2 * 4 bytes)

  		sub $a1, $a1, 1				#
		jal getCMTelement			# return array[Y][X - 1]
		add $a1, $a1, 1				#
		
		beqz $v0, IRW_vUpCols			# if array[Y][X - 1] == 0
		beq $v0, $s2, IRW_vUpCols		# if array[Y][X - 1] == colorTurn
					
IRW_rows:      	lw $a0, ($s7)           		# load array[Y][X]
		
		# Cases to branch to depending on contents of the cell
		beqz $a0, IRW_breakR1
		beq $a0, $s2, IRW_trueR
		bne $a0, $s2, IRW_iterateR
		
IRW_breakR1:    # Branch to up columns if disjointed
		ble $a2, 1, IRW_breakR2			# if i <= 1
		
		b IRW_vUpCols

IRW_breakR2:    # Branch to down columns if disjointed & i <= 1
		b IRW_vDownCols
		
IRW_trueR:     	# Mark LR if same color is found & break
		add $t7, $zero, 1
		sw $t7, isLR
		
		add $t2, $t2, 1
		
		b IRW_breakR1
		
IRW_iterateR:   # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, IRW_breakR1
		
		sub $s7, $s7, 4
		
		b IRW_rows
		
IRW_vUpCols:   	# Verify that up columns is a direction to check
		add $t0, $zero, $zero			# i_o = 0
		sub $t1, $a2, 2				# i_f = Y - 2
		
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0
		sub $s7, $s7, 64			# array[cur] = array[(x,y)] - 64 (16 * 4 bytes)

		sub $a2, $a2, 1				#
		jal getCMTelement			# return array[Y - 1][X]
		add $a2, $a2, 1				#
		
		beqz $v0, IRW_vDownCols			# if array[Y - 1][X] == 0
		beq $v0, $s2, IRW_vDownCols		# if array[Y - 1][X] == colorTurn
				
IRW_upCols:   	lw $a0, ($s7)           		# load array[Y][X]
		
		# Cases to branch to depending on contents of the cell
		beqz $a0, IRW_breakUC1
		beq $a0, $s2, IRW_trueUC
		bne $a0, $s2, IRW_iterateUC
		
IRW_breakUC1:   # Branch to down columns if disjointed
		bge $a2, 6, IRW_breakUC2		# if i >= 6
		
		b IRW_vDownCols
		
IRW_breakUC2:	# Branch to neg diagonals if disjointed & i >= 6
		b IRW_vNegDiags
		
IRW_trueUC:     # Mark UC if same color is found & break
		add $t7, $zero, 1
		sw $t7, isUC
		
		add $t2, $t2, 1
		
		b IRW_breakUC1

IRW_iterateUC:  # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, IRW_breakUC1
		
		sub $s7, $s7, 32			# 32 => i -= (8 * 4 bytes)
		
		b IRW_upCols
		
IRW_vDownCols:  # Verify that down columns is a direction to check
		add $t0, $zero, $zero			# i_o = 0
		sub $t1, $s1, $a2			# i_f = (8 - Y)
		sub $t1, $t1, 3				# i_f = (8 - Y) - 3
		
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0
		add $s7, $s7, 64			# array[cur] = array[(x,y)] + 64 (16 * 4 bytes)

		add $a2, $a2, 1				#
		jal getCMTelement			# return array[Y + 1][X]
		sub $a2, $a2, 1				#
		
		beqz $v0, IRW_vPosDiags			# if array[Y + 1][X] == 0
		beq $v0, $s2, IRW_vPosDiags		# if array[Y + 1][X] == colorTurn
		
IRW_downCols:   lw $a0, ($s7)           		# load array[Y][X]
		
		# Cases to branch to depending on contents of the cell
		beqz $a0, IRW_breakDC1
		beq $a0, $s2, IRW_trueDC
		bne $a0, $s2, IRW_iterateDC
		
IRW_breakDC1:   # Branch to pos diagonals if disjointed
		bge $a2, 6, IRW_breakDC2		# if i >= 6
		
		b IRW_vPosDiags
		
IRW_breakDC2:   # Branch to neg diagonals if disjointed & i >= 6
		b IRW_vNegDiags
		
IRW_trueDC:     # Mark DC if same color is found & break
		add $t7, $zero, 1
		sw $t7, isDC
		
		add $t2, $t2, 1
		
		b IRW_breakDC1

IRW_iterateDC:  # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, IRW_breakDC1
		
		add $s7, $s7, 32			# 32 => i += (8 * 4 bytes)
		
		b IRW_downCols
		
IRW_vPosDiags:  # Verify that (down) positive diagonals is a direction to check
		add $t0, $zero, $zero			# i_o = 0
		sub $t1, $s1, $a2			# i_f = (8 - Y)
		sub $t1, $t1, 3				# i_f = (8 - Y) - 3
		
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0
		add $s7, $s7, 56			# array[cur] = array[(x,y)] + 56 (14 * 4 bytes)

		sub $a1, $a1, 1				#
		add $a2, $a2, 1				#
		jal getCMTelement			# return array[Y + 1][X - 1]
		add $a1, $a1, 1				#
		sub $a2, $a2, 1				#
		
		beqz $v0, IRW_vNegDiags			# if array[Y + 1][X - 1] == 0
		beq $v0, $s2, IRW_vNegDiags		# if array[Y + 1][X - 1] == colorTurn
		
IRW_posDiags:   lw $a0, ($s7)           		# load array[Y][X]

		# Cases to branch to depending on contents of the cell
		beqz $a0, IRW_breakPD1
		beq $a0, $s2, IRW_truePD
		bne $a0, $s2, IRW_iteratePD
		
IRW_breakPD1:   # Branch to neg diagonals if disjointed
		ble $a2, 1, IRW_breakPD2		# if i <= 1
		
		b IRW_vNegDiags
		
IRW_breakPD2:	# Branch to ORW exit if disjointed & i <= 1
		b IRW_breakND
		
IRW_truePD:     # Mark DPD if same color is found & break
		add $t7, $zero, 1
		sw $t7, isDPD
		
		add $t2, $t2, 1
		
		b IRW_breakPD1

IRW_iteratePD:  # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, IRW_breakPD1
		
		add $s7, $s7, 28			# 28 => i += (7 * 4 bytes)
		
		b IRW_posDiags
		
IRW_vNegDiags:  # Verify that (up) negative diagonals is a direction to check
		add $t0, $zero, $zero			# i_o = 0
		sub $t1, $a2, 2				# i_f = Y - 2
		
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0
		sub $s7, $s7, 72			# array[cur] = array[(x,y)] - 72 (18 * 4 bytes)
		
		sub $a1, $a1, 1				#
		sub $a2, $a2, 1				#
		jal getCMTelement			# return array[Y - 1][X - 1]
		add $a1, $a1, 1				#
		add $a2, $a2, 1				#
		
		beqz $v0, IRW_breakND			# if array[Y - 1][X - 1] == 0
		beq $v0, $s2, IRW_breakND		# if array[Y - 1][X - 1] == colorTurn
		
IRW_negDiags:   lw $a0, ($s7)           		# load array[Y][X]
		
		# Cases to branch to depending on contents of the cell
		beqz $a0, IRW_breakND
		beq $a0, $s2, IRW_trueND
		bne $a0, $s2, IRW_iterateND
		
IRW_breakND:   	# Branch to exit (fail) if no other cases checked out or return true
		beqz $t2, IRW_sandExit
		
		add $v0, $zero, $zero
		
		move $ra, $s5
		jr $ra
		
IRW_trueND:     # Mark UND if same color is found & break
		add $t7, $zero, 1
		sw $t7, isUND
		
		add $t2, $t2, 1
		
		b IRW_breakND
		
IRW_iterateND:  # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, IRW_breakND
		
		sub $s7, $s7, 36			# 36 => i -= (9 * 4 bytes)
		
		b IRW_negDiags
		
IRW_sandExit:	# Return false if nothing found
		add $v0, $zero, 1
		
		move $ra, $s5
		
		jr $ra
		
#---------------------------------------------------------------------#
# checkIceiling subroutine checks if a move along the inner ceiling 
# (X: [2, 5], Y: [1) is a valid move
#---------------------------------------------------------------------#
		
checkIceiling:	lw $s2, colorTurn
	
		ble $a1, 1, notIC			# if $a1 <= 1
		bge $a1, 6, notIC			# if $a1 >= 6
		bne $a2, 1, notIC			# if $a2 != 1
				
ICifDisjoint:   sub $a1, $a1, 1				# decrement X by 1 to check left adjacent cell

		move $s4, $ra
		jal getCMTelement			# return array[Y][X - 1]
		
		add $t0, $zero, $v0			# $t0 = condition helper variable 
							# (if register is greater than zero, than TLC is not disjointed
							
		add $a2, $a2, 1				# increment Y to check adjacent left pos diagonal
		
		jal getCMTelement			# return array[Y + 1][X - 1]
		
		add $t0, $t0, $v0
		
		add $a1, $a1, 1				# restore X value to check underlying adjacent cell
		
		jal getCMTelement			# return array[Y + 1][X]
		
		add $t0, $t0, $v0

		add $a1, $a1, 1 			# increment X by 1 to check adjacent right neg diagonal
		
		jal getCMTelement			# return array[Y + 1][X + 1]
		
		add $t0, $t0, $v0			
		
		sub $a2, $a2, 1				# restore Y value to check right adjacent cell
		
		jal getCMTelement			# return array[Y][X + 1]
		
		add $t0, $t0, $v0			# increment condition helper variable
		
		sub $a1, $a1, 1				# restore X value
		
		beq $t0, $zero, ICcaseFailed		# if $t0 == 0, then TLC is disjointed
		add $t0, $zero, $zero			# restore condition helper variable
		
ICifSandwhich:  # check for sandwhiching
		jal IC_sandwhich
		beq $v0, 1, ICcaseFailed
		
		add $v0, $zero, $zero
		move $ra, $s4
		jr $ra
		
ICcaseFailed: 	add $v0, $zero, 1
		move $ra, $s4
		jr $ra

notIC:		jr $ra

#---------------------------------------------------------------------#

IC_sandwhich:   la $s0, board				# board
		lw $s1, dimSize				# row size 
		lw $s2, colorTurn			# color turn
		
		li $t0, 0				# cell counter
		li $t1, 4                               # cell counter limit
		li $t2, 0				# condition helper variable
		
		move $s5, $ra
		
IC_vDownCols:	# Verify that down columns is a direction to check
		jal getCMTindex

		move $s7, $s0
		add $s7, $s7, $v0				
		add $s7, $s7, 64			# i = index (array[(x,y)]) + 64 (16 * 4 bytes)
		
		add $a2, $a2, 1				#
		jal getCMTelement			# return array[Y + 1][X]
		sub $a2, $a2, 1				#
		
		beqz $v0, IC_vLeftRows			# if array[Y + 1][X] == 0
		beq $v0, $s2, IC_vLeftRows		# if array[Y + 1][X] == colorTurn

IC_downCols:    lw $a0, ($s7)           		# load array[Y][X]
		
		beq $a0, $s2, IC_trueDC

		# Cases to branch to depending on contents of the cell
		beqz $a0, IC_breakDC1
		beq $a0, $s2, IC_trueDC
		bne $a0, $s2, IC_iterateDC
		
IC_breakDC1:    # Branch to left rows if disjointed
		ble $a1, 1, IC_breakDC2			# if i <= 1
	
		b IC_vLeftRows
		
IC_breakDC2:    # Branch to right rows if disjointed & i <= 1
		b IC_vRightRows
		
IC_trueDC:      # Mark DC if same color is found & break
		add $t7, $zero, 1
		sw $t7, isDC
		
		add $t2, $t2, 1
		
		b IC_breakDC1

IC_iterateDC:   # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, IC_breakDC1
		
		add $s7, $s7, 32			# 32 => i += (8 * 4 bytes)
		
		b IC_downCols
		
IC_vLeftRows:   # Verify that left rows is a direction to check
		add $t0, $zero, $zero			# i_o = 0
		sub $t1, $a1, 2				# i_f = Y - 2
		
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0
		sub $s7, $s7, 8				# array[cur] = array[(x,y)] - 8 (2 * 4 bytes)
		
		sub $a1, $a1, 1				#
		jal getCMTelement			# return array[Y][X - 1]
		add $a1, $a1, 1				#
		
		beqz $v0, IC_vRightRows			# if array[Y][X - 1] == 0
		beq $v0, $s2, IC_vRightRows		# if array[Y][X - 1] == colorTurn
					
IC_leftRows:    lw $a0, ($s7)           		# load array[Y][X]

		# Cases to branch to depending on contents of the cell
		beqz $a0, IC_breakLR1
		beq $a0, $s2, IC_trueLR
		bne $a0, $s2, IC_iterateLR
		
IC_breakLR1:    # Branch to right rows if disjointed
		bge $a1, 6, IC_breakLR2			# if i >= 6
		
		b IC_vRightRows

IC_breakLR2:    # Branch to positive diagonals if disjointed & i >= 6
		b IC_vPosDiags
		
IC_trueLR:     	# Mark LR if same color is found & break
		add $t7, $zero, 1
		sw $t7, isLR
		
		add $t2, $t2, 1
		
		b IC_breakLR1
		
IC_iterateLR:   # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, IC_breakLR1
		
		sub $s7, $s7, 4
		
		b IC_leftRows
		
IC_vRightRows:  # Verify that right rows is a direction to check
		add $t0, $zero, $zero			# i_o = 0
		sub $t1, $s1, $a1			# i_f = (8 - X)
		sub $t1, $t1, 3				# i_f = (8 - X) - 3
		
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0
		add $s7, $s7, 8				# index = array[(x,y)] + 8 (2 * 4 bytes)
		
		add $a1, $a1, 1				#
		jal getCMTelement			# return array[Y][X + 1]
		sub $a1, $a1, 1				#
		
		beqz $v0, IC_vPosDiags			# if array[Y][X + 1] == 0
		beq $v0, $s2, IC_vPosDiags		# if array[Y][X + 1] == colorTurn
					
IC_rightRows:   lw $a0, ($s7)           		# load array[Y][X]

		# Cases to branch to depending on contents of the cell
		beqz $a0, IC_breakRR1
		beq $a0, $s2, IC_trueRR
		bne $a0, $s2, IC_iterateRR
		
IC_breakRR1:    # Branch to pos diagonals if disjointed
		ble $a1, 1, IC_breakRR2			# if i <= 1
		
		b IC_vPosDiags

IC_breakRR2:    # Branch to neg diagonals if disjointed & i <= 1
		b IC_vNegDiags
		
IC_trueRR:     	# Mark RR if same color is found & break
		add $t7, $zero, 1
		sw $t7, isRR
		
		add $t2, $t2, 1
		
		b IC_breakRR1
		
IC_iterateRR:   # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, IC_breakRR1
		
		add $s7, $s7, 4
		
		b IC_rightRows
				
IC_vPosDiags:   # Verify that (down) positive diagonals is a direction to check
		add $t0, $zero, $zero			# i_o = 0
		sub $t1, $a1, 2				# i_f = X - 2
		
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0
		add $s7, $s7, 56			# array[cur] = array[(x,y)] + 56 (14 * 4 bytes)

		sub $a1, $a1, 1				#
		add $a2, $a2, 1				#
		jal getCMTelement			# return array[Y + 1][X - 1]
		add $a1, $a1, 1				#
		sub $a2, $a2, 1				#
		
		beqz $v0, IC_vNegDiags			# if array[Y + 1][X - 1] == 0
		beq $v0, $s2, IC_vNegDiags              # if array[Y + 1][X - 1] == colorTurn
		
IC_posDiags:    lw $a0, ($s7)           		# load array[Y][X]

		# Cases to branch to depending on contents of the cell
		beqz $a0, IC_breakPD1
		beq $a0, $s2, IC_truePD
		bne $a0, $s2, IC_iteratePD
		
IC_breakPD1:    # Branch to neg diagonals if disjointed
		bge $a1, 6, IC_breakPD2			# if i >= 6

		b IC_vNegDiags
		
IC_breakPD2:	# Branch to IC exit if disjointed & i >= 6		
		b IC_breakND
		
IC_truePD:      # Mark DPD if same color is found & break
		add $t7, $zero, 1
		sw $t7, isDPD
		
		add $t2, $t2, 1
		
		b IC_breakPD1

IC_iteratePD:  # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, IC_breakPD1
		
		add $s7, $s7, 28			# 28 => i += (7 * 4 bytes)
		
		b IC_posDiags
		
IC_vNegDiags:   # Verify that (down) negative diagonals is a direction to check
		add $t0, $zero, $zero			# i_o = 0
		sub $t1, $s1, $a1			# i_f = (8 - X)
		sub $t1, $t1, 3				# i_f = (8 - X) - 3
		
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0
		add $s7, $s7, 72			# array[cur] = array[(x,y)] + 72 (18 * 4 bytes)
		
		add $a1, $a1, 1				#
		add $a2, $a2, 1				#
		jal getCMTelement			# return array[Y + 1][X + 1]
		sub $a1, $a1, 1				#
		sub $a2, $a2, 1				#
		
		beqz $v0, IC_breakND			# if array[Y + 1][X + 1] == 0
		beq $v0, $s2, IC_breakND		# if array[Y + 1][X + 1] == colorTurn
		
IC_negDiags:    lw $a0, ($s7)           		# load array[Y][X]

		# Cases to branch to depending on contents of the cell
		beqz $a0, IC_breakND
		beq $a0, $s2, IC_trueND
		bne $a0, $s2, IC_iterateND
		
IC_breakND:   	# Branch to exit (fail) if no other cases checked out or return true
		beqz $t0, IC_sandExit	
		
		add $v0, $zero, $zero
		
		move $ra, $s5
		jr $ra
		
IC_trueND:      # Mark DND if same color is found & break
		add $t7, $zero, 1
		sw $t7, isDND
		
		add $t2, $t2, 1
		
		b IC_breakND

IC_iterateND:   # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, IC_breakND
		
		add $s7, $s7, 36			# 36 => i += (9 * 4 bytes)
		
		b IC_negDiags
		
IC_sandExit:	# Return false if nothing found
		add $v0, $zero, 1
		
		move $ra, $s5
		jr $ra
		
#---------------------------------------------------------------------#
# checkIfloor subroutine checks if a move along the outer floor 
# (X: [2, 5], Y: [6]) is a valid move
#---------------------------------------------------------------------#

checkIfloor:	lw $s2, colorTurn
	
		ble $a1, 1, notIF			# if $a1 <= 1
		bge $a1, 6, notIF			# if $a1 >= 6
		bne $a2, 6, notIF			# if $a2 != 6
				
IFifDisjoint:   sub $a1, $a1, 1				# decrement X by 1 to check left adjacent cell

		move $s4, $ra
		jal getCMTelement			# return array[Y][X - 1]
		
		add $t0, $zero, $v0			# $t0 = condition helper variable 
							# (if register is greater than zero, than TLC is not disjointed
							
		sub $a2, $a2, 1				# decrement Y to check adjacent left neg diagonal
		
		jal getCMTelement			# return array[Y - 1][X - 1]
		
		add $t0, $t0, $v0
		
		add $a1, $a1, 1				# restore X value to check overhead adjacent cell
		
		jal getCMTelement			# return array[Y - 1][X]
		
		add $t0, $t0, $v0

		add $a1, $a1, 1 			# increment X by 1 to check adjacent right pos diagonal
		
		jal getCMTelement			# return array[Y - 1][X + 1]
		
		add $t0, $t0, $v0			
		
		add $a2, $a2, 1				# restore Y value to check right adjacent cell
		
		jal getCMTelement			# return array[Y][X + 1]
		
		add $t0, $t0, $v0			# increment condition helper variable
		
		sub $a1, $a1, 1				# restore X value
		
		beq $t0, $zero, IFcaseFailed		# if $t0 == 0, then TLC is disjointed
		add $t0, $zero, $zero			# restore condition helper variable
		
IFifSandwhich:  # check for sandwhiching
		jal IF_sandwhich
		beq $v0, 1, IFcaseFailed
		
		add $v0, $zero, $zero
		move $ra, $s4
		jr $ra
		
IFcaseFailed: 	add $v0, $zero, 1
		move $ra, $s4
		jr $ra

notIF:		jr $ra

#---------------------------------------------------------------------#

IF_sandwhich:   la $s0, board				# board
		lw $s1, dimSize				# row size 
		lw $s2, colorTurn			# color turn
		
		li $t0, 0				# cell counter
		li $t1, 4                               # cell counter limit
		li $t2, 0				# condition helper variable
		
		move $s5, $ra
		
IF_vUpCols:	# Verify that up columns is a direction to check
		jal getCMTindex

		move $s7, $s0
		add $s7, $s7, $v0				
		sub $s7, $s7, 64			# i = index (array[(x,y)]) + 64 (16 * 4 bytes)
		
		sub $a2, $a2, 1	
		jal getCMTelement			# return array[Y - 1][X]
		add $a2, $a2, 1
		
		beqz $v0, IF_vLeftRows

IF_upCols:      lw $a0, ($s7)           		# load array[Y][X]
		
		beq $a0, $s2, IF_trueUC

		# Cases to branch to depending on contents of the cell
		beqz $a0, IF_breakUC1
		beq $a0, $s2, IF_trueUC
		bne $a0, $s2, IF_iterateUC
		
IF_breakUC1:    ble $a1, 1, IF_breakUC2			# if i <= 1
	
		b IF_vLeftRows
		
IF_breakUC2:    # Branch to neg diagonals if disjointed & i <= 1
		b IF_vRightRows
		
IF_trueUC:      # Mark UC if same color is found & break
		add $t7, $zero, 1
		sw $t7, isUC
		
		add $t2, $t2, 1
		
		b IF_breakUC1
		
IF_iterateUC:   # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, IF_breakUC1
		
		sub $s7, $s7, 32			# 32 => i -= (8 * 4 bytes)
		
		b IF_upCols
		
IF_vLeftRows:   # Verify that left rows is a direction to check
		add $t0, $zero, $zero			# i_o = 0
		sub $t1, $a1, 2				# i_f = Y - 2
		
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0
		sub $s7, $s7, 8				# array[cur] = array[(x,y)] - 8 (2 * 4 bytes)
		
		sub $a1, $a1, 1	
		jal getCMTelement			# return array[Y][X - 1]
		add $a1, $a1, 1
		beqz $v0, IF_vRightRows
					
IF_leftRows:    lw $a0, ($s7)           		# load array[Y][X]

		# Cases to branch to depending on contents of the cell
		beqz $a0, IF_breakLR1
		beq $a0, $s2, IF_trueLR
		bne $a0, $s2, IF_iterateLR
		
IF_breakLR1:    # Branch to right rows if disjointed
		bge $a1, 6, IF_breakLR2			# if i >= 6
		
		b IF_vRightRows

IF_breakLR2:    # Branch to positive diagonals if disjointed & i >= 6
		b IF_vPosDiags
		
IF_trueLR:     	# Mark LR if same color is found & break
		add $t7, $zero, 1
		sw $t7, isLR
		
		add $t2, $t2, 1
		
		b IF_breakLR1
		
IF_iterateLR:   # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, IF_breakLR1
		
		sub $s7, $s7, 4
		
		b IF_leftRows
		
IF_vRightRows:  # Verify that right rows is a direction to check
		add $t0, $zero, $zero			# i_o = 0
		sub $t1, $s1, $a1			# i_f = (8 - X)
		sub $t1, $t1, 3				# i_f = (8 - X) - 3
		
		jal getCMTindex
		
		move $s7, $s0
		
		add $s7, $s7, $v0
		add $s7, $s7, 8				# index = array[(x,y)] + 8 (2 * 4 bytes)
		
		add $a1, $a1, 1	
		jal getCMTelement			# return array[Y][X + 1]
		sub $a1, $a1, 1
		
		beqz $v0, IF_vPosDiags
					
IF_rightRows:   lw $a0, ($s7)           		# load array[Y][X]

		# Cases to branch to depending on contents of the cell
		beqz $a0, IF_breakRR1
		beq $a0, $s2, IF_trueRR
		bne $a0, $s2, IF_iterateRR
		
IF_breakRR1:    # Branch to positive columns if disjointed
		ble $a1, 1, IF_breakRR2			# if i <= 1
		
		b IF_vPosDiags

IF_breakRR2:    # Branch to negative diagonals if disjointed & i >= 6
		b IF_vNegDiags
		
IF_trueRR:     	# Mark RR if same color is found & break
		add $t7, $zero, 1
		sw $t7, isRR
		
		add $t2, $t2, 1
		
		b IF_breakRR1
		
IF_iterateRR:   # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, IF_breakRR1
		
		add $s7, $s7, 4
		
		b IF_rightRows
				
IF_vPosDiags:   # Verify that (up) positive diagonals is a direction to check
		add $t0, $zero, $zero			# i_o = 0
		sub $t1, $s1, $a1			# i_f = (8 - X)
		sub $t1, $t1, 3				# i_f = (8 - X) - 3
		
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0
		sub $s7, $s7, 56			# array[cur] = array[(x,y)] - 56 (14 * 4 bytes)

		add $a1, $a1, 1	
		sub $a2, $a2, 1
		jal getCMTelement			# return array[Y - 1][X + 1]
		sub $a1, $a1, 1
		add $a2, $a2, 1
		
		beqz $v0, IF_vNegDiags			# if array[Y - 1][X + 1] == 0
		beq $v0, $s2, IF_vNegDiags		# if array[Y - 1][X + 1] == colorTurn
		
IF_posDiags:    lw $a0, ($s7)           		# load array[Y][X]

		# Cases to branch to depending on contents of the cell
		beqz $a0, IF_breakPD1
		beq $a0, $s2, IF_truePD
		bne $a0, $s2, IF_iteratePD
		
IF_breakPD1:    # Branch to negative diagonals if disjointed
		bge $a1, 6, IF_breakPD2			# if i >= 6

		b IF_vNegDiags
		
IF_breakPD2:	# Branch to pos columns if disjointed & i >= 6		
		b IF_breakND
		
IF_truePD:      # Mark UPD if same color is found & break
		add $t7, $zero, 1
		sw $t7, isUPD
		
		add $t2, $t2, 1
		
		b IF_breakPD1

IF_iteratePD:  # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, IF_breakPD1
		
		sub $s7, $s7, 28			# # 36 => i -= (7 * 4 bytes)
		
		b IC_posDiags
		
IF_vNegDiags:   # Verify that (up) negative diagonals is a direction to check
		add $t0, $zero, $zero			# i_o = 0
		sub $t1, $a1, 2				# i_f = X - 2
		
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0
		sub $s7, $s7, 72			# array[cur] = array[(x,y)] - 72 (18 * 4 bytes)
		
		sub $a1, $a1, 1				#
		sub $a2, $a2, 1				#
		jal getCMTelement			# return array[Y - 1][X - 1]
		add $a1, $a1, 1				#
		add $a2, $a2, 1				#
		
		beqz $v0, IF_breakND			# if array[Y - 1][X - 1] == 0
		beq $v0, $s2, IF_breakND		# if array[Y - 1][X - 1] == colorTurn
		
IF_negDiags:    lw $a0, ($s7)           		# load array[Y][X]

		# Cases to branch to depending on contents of the cell
		beqz $a0, IF_breakND
		beq $a0, $s2, IF_trueND
		bne $a0, $s2, IF_iterateND
		
IF_breakND:   	# Branch to exit (fail) if no other cases checked out or return true
		beqz $t2, IF_sandExit
		
		add $v0, $zero, $zero
		
		move $ra, $s5
		jr $ra
		
IF_trueND:      # Mark UND if same color is found & break
		add $t7, $zero, 1
		sw $t7, isUND
		
		add $t2, $t2, 1
		
		b IF_breakND

IF_iterateND:   # Iterate next cell if opposing color found
		add $t0, $t0, 1
		
		beq $t0, $t1, IF_breakND
		
		add $s7, $s7, 36			# # 36 => i += (9 * 4 bytes)
		
		b IF_negDiags
		
IF_sandExit:	# Return false if nothing found
		add $v0, $zero, 1
		
		move $ra, $s5
		jr $ra
		
#---------------------------------------------------------------------#
# checkInnerMat subroutine checks if a move within the inner matrix 
# (X: [2, 5], Y: [2, 5]) is a valid move
#---------------------------------------------------------------------#

checkInnerMat:  lw $s2, colorTurn
	
		ble $a1, 1, notIM			# if $a1 <= 1
		bge $a1, 6, notIM			# if $a1 >= 6
		ble $a2, 1, notIM			# if $a1 <= 1
		bge $a2, 6, notIM			# if $a2 >= 6
				
IMifDisjoint:   sub $a1, $a1, 1				# decrement X by 1 to check left adjacent cell

		move $s4, $ra
		jal getCMTelement			# return array[Y][X - 1]
		
		add $t0, $zero, $v0			# $t0 = condition helper variable 
							# (if register is greater than zero, than TLC is not disjointed
							
		sub $a2, $a2, 1				# decrement Y to check adjacent left neg diagonal
		
		jal getCMTelement			# return array[Y - 1][X - 1]
		
		add $t0, $t0, $v0			# increment condition helper variable
		
		add $a1, $a1, 1				# restore X value to check overhead adjacent cell
		
		jal getCMTelement			# return array[Y - 1][X]
		
		add $t0, $t0, $v0			# increment condition helper variable

		add $a1, $a1, 1 			# increment X by 1 to check adjacent right pos diagonal
		
		jal getCMTelement			# return array[Y - 1][X + 1]
		
		add $t0, $t0, $v0			# increment condition helper variable
		
		add $a2, $a2, 1				# restore Y value to check right adjacent cell
		
		jal getCMTelement			# return array[Y][X + 1]
		
		add $t0, $t0, $v0			# increment condition helper variable
		
		add $a2, $a2, 1				# increment Y value to check adjacent right neg diagonal
		
		jal getCMTelement			# return array[Y + 1][X + 1]
		
		add $t0, $t0, $v0			# increment condition helper variable
		
		sub $a1, $a1, 1				# decrement X value to check adjacent underlying cell
		
		jal getCMTelement			# return array[Y + 1][X]
		
		add $t0, $t0, $v0			# increment condition helper variable
		
		sub $a1, $a1, 1				# decrement X value to check adjacent left pos diagonal
		
		jal getCMTelement			# return array[Y + 1][X - 1]
		
		add $t0, $t0, $v0			# increment condition helper variable
		
		add $a1, $a1, 1				# restore X value
		sub $a2, $a2, 1				# restore Y value
		
		beq $t0, $zero, IMcaseFailed		# if $t0 == 0, then TLC is disjointed
		add $t0, $zero, $zero			# restore condition helper variable
		
IMifSandwhich:  # check for sandwhiching
		jal IM_sandwhich
		beq $v0, 1, IMcaseFailed
		
		add $v0, $zero, $zero
		move $ra, $s4
		jr $ra
		
IMcaseFailed: 	add $v0, $zero, 1
		move $ra, $s4
		jr $ra

notIM:		jr $ra

#---------------------------------------------------------------------#

IM_sandwhich:   la $s0, board				# board
		lw $s1, dimSize				# row size 
		lw $s2, colorTurn			# color turn
		
		li $t0, 0				# condition helper variable for the cases
							# (if the final sum is zero, then none of the cases
							#  were true and this subroutine will return false)
		
		move $s5, $ra
		
IM_vLeftRows:	# Verify that left rows is a direction to check
		jal getCMTindex

		move $s7, $s0
		add $s7, $s7, $v0				
		sub $s7, $s7, 8				# i = index (array[(x,y)]) - 8 (2 * 4 bytes)
		
		sub $a1, $a1, 1	
		jal getCMTelement			# return array[Y][X - 1]
		add $a1, $a1, 1
		
		beqz $v0, IM_vRightRows			# if array[Y][X - 1] == 0
		beq $v0, $s2, IM_vRightRows		# if array[Y][X - 1] == colorTurn

IM_leftRows:	lw $a0, ($s7)           		# load array[Y][X]

		# Cases to branch to depending on contents of the cell
		bne $a0, $s2, IM_vRightRows	
		beq $a0, $s2, IM_trueLR
		
IM_trueLR:	# Mark LR if same color is found & branch
		add $t7, $zero, 1
		sw $t7, isLR
		
		add $t0, $t0, 1
		
		b IM_vRightRows
				
IM_vRightRows:	# Verify that right rows is a direction to check
		jal getCMTindex

		move $s7, $s0
		add $s7, $s7, $v0				
		add $s7, $s7, 8				# i = index (array[(x,y)]) + 8 (2 * 4 bytes)
		
		add $a1, $a1, 1	
		jal getCMTelement			# return array[Y][X + 1]
		sub $a1, $a1, 1
		
		beqz $v0, IM_vUpCols			# if array[Y][X - 1] == 0
		beq $v0, $s2, IM_vUpCols		# if array[Y][X - 1] == colorTurn

IM_rightRows:   lw $a0, ($s7)           		# load array[Y][X]

		# Cases to branch to depending on contents of the cell
		bne $a0, $s2, IM_vUpCols
		beq $a0, $s2, IM_trueRR
		
IM_trueRR:	# Mark RR if same color is found & branch
		add $t7, $zero, 1
		sw $t7, isRR
		
		add $t0, $t0, 1
		
		b IM_vUpCols
		
IM_vUpCols:	# Verify that up columns is a direction to check
		jal getCMTindex

		move $s7, $s0
		add $s7, $s7, $v0				
		sub $s7, $s7, 64			# i = index (array[(x,y)]) - 64 (16 * 4 bytes)
		
		sub $a2, $a2, 1	
		jal getCMTelement			# return array[Y - 1][X]
		add $a2, $a2, 1
		
		beqz $v0, IM_vDownCols			# if array[Y][X - 1] == 0
		beq $v0, $s2, IM_vDownCols		# if array[Y][X - 1] == colorTurn

IM_upCols:   	lw $a0, ($s7)           		# load array[Y][X]

		# Cases to branch to depending on contents of the cell
		bne $a0, $s2, IM_vDownCols
		beq $a0, $s2, IM_trueUC
		
IM_trueUC:	# Mark UC if same color is found & branch
		add $t7, $zero, 1
		sw $t7, isUC
		
		add $t0, $t0, 1
		
		b IM_vDownCols
		
IM_vDownCols:	# Verify that down columns is a direction to check
		jal getCMTindex

		move $s7, $s0
		add $s7, $s7, $v0				
		add $s7, $s7, 64			# i = index (array[(x,y)]) + 64 (16 * 4 bytes)
		
		add $a2, $a2, 1	
		jal getCMTelement			# return array[Y + 1][X]
		sub $a2, $a2, 1
		
		beqz $v0, IM_vUPosDiags			# if array[Y][X - 1] == 0
		beq $v0, $s2, IM_vUPosDiags		# if array[Y][X - 1] == colorTurn

IM_downCols:   	lw $a0, ($s7)           		# load array[Y][X]

		# Cases to branch to depending on contents of the cell
		bne $a0, $s2, IM_vUPosDiags
		beq $a0, $s2, IM_trueDC
		
IM_trueDC:	# Mark DC if same color is found & branch
		add $t7, $zero, 1
		sw $t7, isDC
		
		add $t0, $t0, 1
		
		b IM_vUPosDiags
		
IM_vUPosDiags:	# Verify that up positive diagonals is a direction to check
		jal getCMTindex

		move $s7, $s0
		add $s7, $s7, $v0				
		sub $s7, $s7, 56			# i = index (array[(x,y)]) - 56 (14 * 4 bytes)
		
		add $a1, $a1, 1	
		sub $a2, $a2, 1	
		jal getCMTelement			# return array[Y - 1][X + 1]
		sub $a1, $a1, 1
		add $a2, $a2, 1
		
		beqz $v0, IM_vDPosDiags			# if array[Y - 1][X - 1] == 0

IM_UPosDiags:   lw $a0, ($s7)           		# load array[Y][X]

		# Cases to branch to depending on contents of the cell
		bne $a0, $s2, IM_vDPosDiags
		beq $a0, $s2, IM_trueUPD
		
IM_trueUPD:	# Mark UPD if same color is found & branch
		add $t7, $zero, 1
		sw $t7, isUPD
		
		add $t0, $t0, 1
		
		b IM_vDPosDiags
		
IM_vDPosDiags:	# Verify that down posistive diagonals is a direction to check
		jal getCMTindex

		move $s7, $s0
		add $s7, $s7, $v0				
		add $s7, $s7, 56			# i = index (array[(x,y)]) + 56 (14 * 4 bytes)
		
		sub $a1, $a1, 1	
		add $a2, $a2, 1	
		jal getCMTelement			# return array[Y + 1][X - 1]
		add $a1, $a1, 1
		sub $a2, $a2, 1
		
		beqz $v0, IM_vUNegDiags			# if array[Y + 1][X + 1] == 0

IM_DPosDiags:   lw $a0, ($s7)           		# load array[Y][X]

		# Cases to branch to depending on contents of the cell
		bne $a0, $s2, IM_vUNegDiags
		beq $a0, $s2, IM_trueDPD
		
IM_trueDPD:	# Mark DPD if same color is found & branch
		add $t7, $zero, 1
		sw $t7, isDPD
		
		add $t0, $t0, 1
		
		b IM_vUNegDiags
		
IM_vUNegDiags:	# Verify that up negative diagonals is a direction to check
		jal getCMTindex

		move $s7, $s0
		add $s7, $s7, $v0				
		sub $s7, $s7, 72			# i = index (array[(x,y)]) - 72 (18 * 4 bytes)
		
		sub $a1, $a1, 1	
		sub $a2, $a2, 1	
		jal getCMTelement			# return array[Y - 1][X - 1]
		add $a1, $a1, 1
		add $a2, $a2, 1
		
		beqz $v0, IM_vDNegDiags			# if array[Y - 1][X - 1] == 0

IM_UNegDiags:   lw $a0, ($s7)           		# load array[Y][X]

		# Cases to branch to depending on contents of the cell
		bne $a0, $s2, IM_vDNegDiags
		beq $a0, $s2, IM_trueUND
		
IM_trueUND:	# Mark UND if same color is found & branch
		add $t7, $zero, 1
		sw $t7, isUND
		
		add $t0, $t0, 1
		
		b IM_vDNegDiags
		
IM_vDNegDiags:	# Verify that down negative diagonals is a direction to check
		jal getCMTindex

		move $s7, $s0
		add $s7, $s7, $v0				
		add $s7, $s7, 72			# i = index (array[(x,y)]) + 72 (18 * 4 bytes)
		
		add $a1, $a1, 1	
		add $a2, $a2, 1	
		jal getCMTelement			# return array[Y + 1][X + 1]
		sub $a1, $a1, 1
		sub $a2, $a2, 1
		
		beqz $v0, IM_finalCheck			# if array[Y + 1][X + 1] == 0

IM_DNegDiags:   lw $a0, ($s7)           		# load array[Y][X]

		# Cases to branch to depending on contents of the cell
		bne $a0, $s2, IM_finalCheck
		beq $a0, $s2, IM_trueDND
		
IM_trueDND:	# Mark DND if same color is found & branch
		add $t7, $zero, 1
		sw $t7, isDND
		
		add $t0, $t0, 1
		
		b IM_finalCheck

IM_finalCheck:	# Branch to exit (fail) if no other cases checked out or return true
		beqz $t0, IM_sandExit			# if $t0 == 0
		
		add $v0, $zero, $zero
		
		move $ra, $s5
		jr $ra
		
IM_sandExit:	# Return false if nothing found
		add $v0, $zero, 1

		move $ra, $s5
		jr $ra
		
#---------------------------------------------------------------------#
# adjustRowL subroutine flips the colors of the opposing player in the 
# row left direction
#---------------------------------------------------------------------#

adjustRowL:	la $s0, board				# board
		lw $s2, colorTurn			# color turn
		
		move $s5, $ra
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0
		sub $s7, $s7, 4				# array[cur] = array[(x,y)] - 4 (1 * 4 bytes)
				
ARLloop:	lw $a0, ($s7)           		# load array[Y][X]
		
		# Cases to branch to depending on contents of the cell
		bne $a0, $s2, ARLflipColors	
		beq $a0, $s2, ARLexit
		
ARLflipColors:  jal getCMTelement
		
		add $v0, $zero, $s2
		sw $v0, ($s7)				# flip the opponent's disc
		
		b ARLnextCell
				
ARLnextCell:  	subi $s7, $s7, 4			# Decrement array pointer (next index) 
		
		b ARLloop
		
ARLexit:	move $ra, $s5
		jr $ra
		
#---------------------------------------------------------------------#
# adjustRowR subroutine flips the colors of the opposing player in the 
# row right direction
#---------------------------------------------------------------------#

adjustRowR:	la $s0, board				# board
		lw $s2, colorTurn			# color turn
		
		move $s5, $ra
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0
		add $s7, $s7, 4				# array[cur] = array[(x,y)] + 4 (1 * 4 bytes)
				
ARRloop:	lw $a0, ($s7)           		# load array[Y][X]

		# Cases to branch to depending on contents of the cell
		bne $a0, $s2, ARRflipColors
		beq $a0, $s2, ARRexit
		
ARRflipColors:  jal getCMTelement
		
		add $v0, $zero, $s2
		sw $v0, ($s7)				# flip the opponent's disc
		
		b ARRnextCell
				
ARRnextCell:  	addi $s7, $s7, 4			# Increment array pointer (next index)
		
		b ARRloop
		
ARRexit:	move $ra, $s5
		jr $ra
		
#---------------------------------------------------------------------#
# adjustColumnU subroutine flips the colors of the opposing player in the 
# up column direction
#---------------------------------------------------------------------#

adjustColumnU:	la $s0, board				# board
		lw $s2, colorTurn			# color turn
		
		move $s5, $ra
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0
		sub $s7, $s7, 32			# array[cur] = array[(x,y)] - 32 (8 * 4 bytes)
				
ACUloop:	lw $a0, ($s7)           		# load array[Y][X]
		
		# Cases to branch to depending on contents of the cell
		bne $a0, $s2, ACUflipColors	
		beq $a0, $s2, ACUexit
		
ACUflipColors:  jal getCMTelement
		
		add $v0, $zero, $s2
		sw $v0, ($s7)				# flip the opponent's disc
		
		b ACUnextCell
				
ACUnextCell:  	subi $s7, $s7, 32			# Decrement array pointer (next index)
		
		b ACUloop
		
ACUexit:	move $ra, $s5
		jr $ra
		
#---------------------------------------------------------------------#
# adjustColumnD subroutine flips the colors of the opposing player in the 
# down column direction
#---------------------------------------------------------------------#

adjustColumnD:	la $s0, board				# board
		lw $s2, colorTurn			# color turn
		
		move $s5, $ra
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0
		add $s7, $s7, 32			# array[cur] = array[(x,y)] + 32 (8 * 4 bytes)
				
ACDloop:	lw $a0, ($s7)           		# load array[Y][X]
		
		# Cases to branch to depending on contents of the cell
		bne $a0, $s2, ACDflipColors	
		beq $a0, $s2, ACDexit
		
ACDflipColors:  jal getCMTelement
		
		add $v0, $zero, $s2
		sw $v0, ($s7)				# flip the opponent's disc
		
		b ACDnextCell
				
ACDnextCell:  	addi $s7, $s7, 32			# Increment array pointer (next index)
		
		b ACDloop
		
ACDexit:	move $ra, $s5
		jr $ra
		
#---------------------------------------------------------------------#
# adjustPosDiagU subroutine flips the colors of the opposing player in the 
# up positive diagonal direction
#---------------------------------------------------------------------#

adjustPosDiagU:	la $s0, board				# board
		lw $s2, colorTurn			# color turn
		
		move $s5, $ra
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0
		sub $s7, $s7, 28			# array[cur] = array[(x,y)] - 28 (7 * 4 bytes)
				
APDUloop:	lw $a0, ($s7)           		# load array[Y][X]

		# Cases to branch to depending on contents of the cell
		bne $a0, $s2, APDUflipColors	
		beq $a0, $s2, APDUexit
		
APDUflipColors: jal getCMTelement
		
		add $v0, $zero, $s2
		sw $v0, ($s7)				# flip the opponent's disc
		
		b APDUnextCell
				
APDUnextCell:  	sub $s7, $s7, 28			# Decrement array pointer (next index)
		
		b APDUloop
		
APDUexit:	move $ra, $s5
		jr $ra
		
#---------------------------------------------------------------------#
# adjustPosDiagD subroutine flips the colors of the opposing player in the 
# down positive diagonal direction
#---------------------------------------------------------------------#

adjustPosDiagD:	la $s0, board				# board
		lw $s2, colorTurn			# color turn
		
		move $s5, $ra
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0
		add $s7, $s7, 28			# array[cur] = array[(x,y)] + 28 (7 * 4 bytes)
				
APDDloop:	lw $a0, ($s7)           		# load array[Y][X]
		
		# Cases to branch to depending on contents of the cell
		bne $a0, $s2, APDDflipColors	
		beq $a0, $s2, APDDexit
		
APDDflipColors: jal getCMTelement
		
		add $v0, $zero, $s2
		sw $v0, ($s7)				# flip the opponent's disc
		
		b APDDnextCell
				
APDDnextCell:  	addi $s7, $s7, 28			# Increment array pointer (next index)
		
		b APDDloop
		
APDDexit:	move $ra, $s5
		jr $ra
		
#---------------------------------------------------------------------#
# adjustNegDiagU subroutine flips the colors of the opposing player in the 
# up negative diagonal direction
#---------------------------------------------------------------------#

adjustNegDiagU:	la $s0, board				# board
		lw $s2, colorTurn			# color turn
		
		move $s5, $ra
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0
		sub $s7, $s7, 36			# array[cur] = array[(x,y)] - 36 (9 * 4 bytes)
				
ANDUloop:	lw $a0, ($s7)           		# load array[Y][X]
		
		# Cases to branch to depending on contents of the cell
		bne $a0, $s2, ANDUflipColors	
		beq $a0, $s2, ANDUexit
		
ANDUflipColors: jal getCMTelement
		
		add $v0, $zero, $s2
		sw $v0, ($s7)				# flip the opponent's disc
		
		b ANDUnextCell
				
ANDUnextCell:  	subi $s7, $s7, 36			# Decrement array pointer (next index)
		
		b ANDUloop
		
ANDUexit:	move $ra, $s4
		jr $ra
		
#---------------------------------------------------------------------#
# adjustNegDiagD subroutine flips the colors of the opposing player in the 
# up negative diagonal direction
#---------------------------------------------------------------------#

adjustNegDiagD:	la $s0, board				# board
		lw $s2, colorTurn			# color turn
		
		move $s5, $ra
		jal getCMTindex
		
		move $s7, $s0
		add $s7, $s7, $v0
		add $s7, $s7, 36			# array[cur] = array[(x,y)] + 36 (7 * 4 bytes)
				
ANDDloop:	lw $a0, ($s7)           		# load array[Y][X]
		
		# Cases to branch to depending on contents of the cell
		bne $a0, $s2, ANDDflipColors	
		beq $a0, $s2, ANDDexit
		
ANDDflipColors: jal getCMTelement
		
		add $v0, $zero, $s2
		sw $v0, ($s7)				# flip the opponent's disc
		
		b ANDDnextCell
				
ANDDnextCell:  	addi $s7, $s7, 36			# Increment array pointer (next index)
		
		b ANDDloop
		
ANDDexit:	move $ra, $s5
		jr $ra
		
#---------------------------------------------------------------------#
# updateScores subroutine updates the players' scores after each move
#---------------------------------------------------------------------#

updateScores:   la $s0, board				# board
		lw $s1, dimSize				# row size 
			
		li $t0, 0				# cell counter
		li $t1, 0				# row counter
		
		lw $t2, p1Score		
		lw $t3, p2Score
		
		add $t2, $zero, $zero
		add $t3, $zero, $zero
		
USloop:      	lw $a0, ($s0)           		# load array[Y][X]
		
		# Cases to branch to depending on contents of the cell
		beq $a0, 0, USempty	
		beq $a0, 1, USwhite
		beq $a0, 2, USblack
		
USempty:     	# Branch to next cell if 0 (empty cell)
		
		b USnextCell
		
USwhite:     	# Increment player 1 score if 1 (white disc)
		add $t2, $t2, 1
		
		b USnextCell
		
USblack:     	# Increment player 2 score if 2 (black disc)
		add $t3, $t3, 1
		
		b USnextCell
	
USnextCell:     addi $t0, $t0, 1			# Increment cell counter

		beq $t0, 64, USexit			# If i == 64
		
		addi $s0, $s0, 4			# Increment array pointer (next index)
		
		b USloop
		
USexit:		sw $t2, p1Score
		sw $t3, p2Score
		
		jr $ra

#---------------------------------------------------------------------#
# printBoard subroutine prints the board after each move
#---------------------------------------------------------------------#

printBoard:	la $s0, board				# board
		lw $s1, dimSize				# row size 
			
		li $t0, 0				# cell counter
		li $t1, 0				# row counter
		
		
printLoop:      beq $t0, $s1, printNextRow
		beq $t1, $s1, printExit
				
		lw $a0, ($s0)           		# load array[Y][X]
		
		# Cases to branch to depending on contents of the cell
		beq $a0, 0, printEmpty	
		beq $a0, 1, printWhite
		beq $a0, 2, printBlack
		
printEmpty:     # Print "- " if 0 (empty cell)
		la $a0, empty
		li $v0, 4
		syscall
		
		b printNextCell
		
printWhite:     # Print "o " if 1 (white disc)
		la $a0, white
		li $v0, 4
		syscall
		
		b printNextCell
		
printBlack:     # Print "x " if 1 (black disc)
		la $a0, black
		li $v0, 4
		syscall
		
		b printNextCell
		
printNextCell:  addi $t0, $t0, 1			# Increment cell counter
		addi $s0, $s0, 4			# Increment array pointer (next index)
		
		b printLoop

printNextRow:   # Print new line to next row
		la $a0, newLine		
		li $v0, 4
		syscall
		
		addi $t1, $t1, 1			# Increment row counter
		add $t0, $zero, $zero			# Reset cell counter
		
		b printLoop
		
printExit:	jr $ra
		
#---------------------------------------------------------------------#
# exit subroutine terminates the program upon the user's request
#---------------------------------------------------------------------#

exit:           # Exit program
		li $v0, 10
		syscall
		
#---------------------------------------------------------------------#
#---------------------------------------------------------------------#

	
		
