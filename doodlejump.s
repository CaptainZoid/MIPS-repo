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
	li $t1, 0xfffaf5	# $t1 stores the blue colour code
	li $t4, 0x8ec27e	# $t2 stores the green colour code
	li $t3, 0xff0000	# $t3 stores the red colour code
	
	sw $t1, 0($t0)	 # paint the first (top-left) unit red. 

	
	LOOPINIT:
		li $t2, 0
	WHILE:
		sw $t1, ($t0)
		addi $t2, $t2, 4
		add $t0, $t0, 4
		
		beq $t2, 4092, THEN
		
		j WHILE
	THEN:
		sw $t1, ($t0)
		addi $t2, $t2, 4
		
		j DONE
	DONE:
	
	
	
	
	
	LOOP2:
		lw $t0, displayAddress
		li $t2, 0
		addi $a1, $zero, 32 
		addi $v0, $zero, 42
		syscall
		move $t3, $a0
		mul $a0, $a0, 4
		add $a0, $a0, 3968
		add $t0, $t0, $a0
		
	IF:
		bgt $t3, 15, WHILE_LEFT
		ble $t3, 15, WHILE_RIGHT
		
	WHILE_RIGHT:	
		sw $t4, ($t0)
		
		add $t2, $t2, 1
		add $t0, $t0, 4
		
		beq $t2, 9, THEN2
		
		
		j WHILE_RIGHT
	WHILE_LEFT:
		sw $t4, ($t0)
		
		add $t2, $t2, 1
		add $t0, $t0, -4
		
		beq $t2, 9, THEN2
		
		
		j WHILE_LEFT
		
	THEN2:
		j DONE2
	DONE2:
		
		
	
	
Exit:
	li $v0, 10 # terminate the program gracefully
	syscall
