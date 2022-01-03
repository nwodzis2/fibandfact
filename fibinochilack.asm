#this is just the function for fibinchi I made
fibinochi:
addi $sp, $sp, -12
sw $ra, 8($sp)
sw $s0, 4($sp)
sw $s1, 0($sp)
addi $s0, $a0, 0
ble $s0, 1 ,Exit
addi $a0, $s0, -1
jal fibinochi
addi $s1, $v0, 0
addi $a0, $s0, -2
jal fibonacci
add $v0, $s1, $v0
Exit:
lw $ra, 8($sp)
lw $s0, 4($sp)
lw $s1, 0($sp)
addi $sp, $sp, 12
jr $ra