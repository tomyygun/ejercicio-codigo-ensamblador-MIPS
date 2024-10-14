	.data

dir:	.asciiz	"Ingrese el primer lado: \n"
dir1:	.asciiz	"Ingrese el segundo lado: \n "
dir2:	.asciiz	"Ingrese el tercer lado: \n"

lado1:	.word	0
lado2:	.word	0
lado3:	.word	0

res:	.word	0
semip:	.word	0

	.text

main:	li	$v0, 4	#ingrese lado
	la	$a0, dir
	syscall
	
	li	$v0, 5 #leer entero
	syscall
	
	sw $v0, lado1 #guardo entero
	
	#lado 2
	li	$v0, 4	#ingrese lado 2
	la	$a0, dir1
	syscall
	
	li	$v0, 5 #leer entero
	syscall
	
	sw $v0, lado2 #guardo entero
	
	#lado 3
	li	$v0, 4	#ingrese lado 3
	la	$a0, dir2
	syscall
	
	li	$v0, 5 #leer entero
	syscall
	
	sw $v0, lado3 #guardo entero
	
	addi	$sp, $sp, -4
	sw 	$ra, 0($sp)
	lw	$a0, lado1
	lw	$a1, lado2
	lw	$a2, lado3
	jal	areasq
	sw	$v0, res
	
	lw $ra, 0 ($sp)
	addi	$sp, $sp, 4
	
	li	$v0, 10
	syscall
	
	
	
areasq:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal	semipp
	sw	$v0, semip($0)
	lw $t0, semip
	sub	$t2, $t0,$a0	#s-a
	sub	$t3, $t0,$a1	#s-b
	sub	$t4, $t0,$a2	#s-c
	mul	$t5, $t0, $t2	# s * s-a
	mul	$t6, $t5, $t3	# s * s-a * s-b
	mul	$t7, $t6, $t4	# s * s-a * s-b * s-c
	add	$v0, $t7, $0
	lw	$ra, 0($sp)
	addi	$sp, $sp, 4
	jr	$ra
	
semipp:	
	addi $sp, $sp, -4
	sw $s0, 0 ($sp)
	
	add $t0, $a0, $a1	#t0 = lado 1 + lado 2
	add $t0, $t0, $a2	#t0 = (lado 1 + lado 2 ) + lado 3 
	addi $t1, $0, 2		#t1 = 2
	div $t0, $t1		#t0 / 2
	mflo	$s0		#resultado de la division
	add	$v0, $s0, $0	#lo muevo a v0
	lw $s0, 0($sp)		#restablezco
	addi $sp, $sp, 4	#vuelvo la pila
	jr $ra
	
	 
