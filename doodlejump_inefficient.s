
# Demo for painting
#
# Bitmap Display Configuration::
# - Unit width in pixels: 8					     
# - Unit height in pixels: 8
# - Display width in pixels: 256
# - Display height in pixels: 256
# - Base Address for Display: 0x10008000 ($gp)
#
.data
	displayAddress:	.word	0x10008000
.text
	lw $t0, displayAddress	# $t0 stores the base address for display
	li $t1, 0xfffaf5	# $t1 stores the white colour code
	li $t4, 0x8ec27e	# $t2 stores the green colour code
	li $t3, 0x3a90f2	# $t3 blue the red colour code
	
	sw $t1, 0($t0)	 # paint the first (top-left) unit red. 

	
	LOOPINIT:
		li $t7, 1
		li $t2, 0
		li $t5, 0
	WHILE: # painitng the whole screen white
		sw $t1, ($t0)
		addi $t2, $t2, 4
		add $t0, $t0, 4
		
		beq $t2, 4092, THEN
		
		j WHILE
	THEN:
		sw $t1, ($t0)
		addi $t2, $t2, 4
		#once everything is white we jump to the first platform
		j FIRST_PLATFORM
	
	
	WHILE2:
		sw $t1, ($t0)
		addi $t2, $t2, 4
		add $t0, $t0, 4
		
		beq $t2, 4092, THEN2
		
		j WHILE2
	THEN2:
		sw $t1, ($t0)
		addi $t2, $t2, 4
		
		li $t2, 0
		
		J IF
		
	
	
	
	
	
	FIRST_PLATFORM:
		lw $t0, displayAddress
		li $t2, 0
		addi $a1, $zero, 32 
		addi $v0, $zero, 42
		syscall
		move $t6, $a0
		mul $a0, $a0, 4
		add $a0, $a0, 3968
		add $k1, $a0, 0 #Storing 
		add $k0, $a0, 0 #Storing the starting location
		add $k0, $k0, -384
		
		
	IF:	
		lw $t0, displayAddress
		add $t0, $t0, $k1
		bgt $t6, 15, WHILE_LEFT
		ble $t6, 15, WHILE_RIGHT
		
		
		
	WHILE_RIGHT:	
		sw $t4, ($t0)
		
		add $t2, $t2, 1
		add $t0, $t0, 4
		
		beq $t2, 9, SECOND_PLATFORM
		
		
		j WHILE_RIGHT
		
	WHILE_LEFT:
		sw $t4, ($t0)
		
		add $t2, $t2, 1
		add $t0, $t0, -4
		
		beq $t2, 9, SECOND_PLATFORM
		
		
		j WHILE_LEFT
	
	SECOND_PLATFORM: 
		lw $t0, displayAddress
		li $t2, 0

		beq $s1, 0, GET_RAND2
		j IF2
		
	GET_RAND2:
		addi $a1, $zero, 32 
		addi $v0, $zero, 42
		syscall
		move $s1, $a0
		mul $a0, $a0, 4
		add $a0, $a0, 2688
		add $s0, $a0, 0 #Storing 
		
		
	IF2:	
		lw $t0, displayAddress
		add $t0, $t0, $s0
		bgt $s1, 15, WHILE_LEFT2
		ble $s1, 15, WHILE_RIGHT2
		
		
		
	WHILE_RIGHT2:	
		sw $t4, ($t0)
		
		add $t2, $t2, 1
		add $t0, $t0, 4
		
		beq $t2, 9, THIRD_PLATFORM
		
		
		j WHILE_RIGHT2
		
	WHILE_LEFT2:
		sw $t4, ($t0)
		
		add $t2, $t2, 1
		add $t0, $t0, -4
		
		beq $t2, 9, THIRD_PLATFORM
		
		
		j WHILE_LEFT2
	
	THIRD_PLATFORM: 
		lw $t0, displayAddress
		li $t2, 0

		beq $s4, 0, GET_RAND3
		j IF3
		
	GET_RAND3:
		addi $a1, $zero, 32 
		addi $v0, $zero, 42
		syscall
		move $s4, $a0
		mul $a0, $a0, 4
		add $a0, $a0, 1664
		add $s3, $a0, 0 #Storing 
		
		
	IF3:	
		lw $t0, displayAddress
		add $t0, $t0, $s3
		bgt $s4, 15, WHILE_LEFT3
		ble $s4, 15, WHILE_RIGHT3
		
		
		
	WHILE_RIGHT3:	
		sw $t4, ($t0)
		
		add $t2, $t2, 1
		add $t0, $t0, 4
		
		beq $t2, 9, DOODLE_PAINT
		
		
		j WHILE_RIGHT3
		
	WHILE_LEFT3:
		sw $t4, ($t0)
		
		add $t2, $t2, 1
		add $t0, $t0, -4
		
		beq $t2, 9, DOODLE_PAINT
		
		
		j WHILE_LEFT3
		
	DOODLE_PAINT:
		
		lw $t0, displayAddress
		add $t0, $t0, $k0
		
		sw $t3, ($t0) #4
		
		add $t0, $t0, 252
		sw $t3, ($t0) #1
		
		add $t0, $t0, -128
		sw $t3, ($t0) #2
		
		add $t0, $t0, 4
		sw $t3, ($t0) #3
		
		add $t0, $t0, 4
		sw $t3, ($t0) #5
		
		add $t0, $t0, 128
		sw $t3, ($t0) #6
		
		lw $t0, displayAddress
		add $t9, $k0, 384
		add $s7, $t9, $t0
		lw $t8, 0($s7)
		
		li $v0 32
		li $a0 55
		syscall
		
		beq $t4, $t8, JUMP
		
		beq $t7, 1, JUMP
		beq $t7, 0, DOWN
		
		

		
	JUMP:	
		
		add $t5, $t5, 1
		li $t7, 1
		
		
		#Paint doodle new location
		lw $t0, displayAddress
		add $k0, $k0, -128
		add $t0, $t0, $k0
		
		beq $t5, 15, DOWN
		
		li $t2, 0
		lw $t0, displayAddress
		j WHILE2
		
	
	DOWN:
		lw $t0, displayAddress
		li $t5, 0
		li $t7, 0
		
		
		#Paint doodle new location
		lw $t0, displayAddress
		add $k0, $k0, 128
		add $t0, $t0, $k0
		
		li $t2, 0
		lw $t0, displayAddress
		j WHILE2
		
	DONE3:
	
		
		
		
		
		
		
		
		
	
	
Exit:
	li $v0, 10 # terminate the program gracefully
	syscall
