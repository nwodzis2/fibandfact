#reference - https://gist.github.com/libertylocked/068b118354539a8be992
.data
prompt1: .asciiz "Enter the sequence index\n" #storing an output message to be called
prompt2: .asciiz "The Fibonacci value is:\n" #storing an output message to be called
message: .asciiz "The Fibonacci value is:\n0" #storing an output message to be called

.text

# Print prompt1
li $v0, 4 #syscall 4
la $a0, prompt1 #store promt into $a0
syscall #system call

# Read integer
li $v0, 5 #syscall 5
syscall #system call

beq $v0, 0, equalToZero #branch if fib is zero to avoid excessive calulation, fib will be 0

# Call fibonacci
move $a0, $v0 # $a0 = $v0, 
jal fibonacci #jump to fibinochi function
move $a1, $v0 # save return value to a1

# Print prompt2
li $v0, 4 #syscall 4
la $a0, prompt2 #store prompt2 into $a0
syscall #system call

# Print result
li $v0, 1 #syscall 1- read int
move $a0, $a1 #$a0 = $a1
syscall #system call

# Exit/ return 0
li $v0, 10 
syscall



## Function int fibonacci (int n)
fibonacci:
# Prologue
addi $sp, $sp, -12 #adjust stack
sw $ra, 8($sp) #save $ra in stack
sw $s0, 4($sp) #save $s0 in stack
sw $s1, 0($sp) #save $s1 in stack
move $s0, $a0 #$s0 = $a0
li $v0, 1 # return value for terminal condition
ble $s0, 0x2, fibonacciExit # check terminal condition, jump to fibonacciexit
addi $a0, $s0, -1 # set args for recursive call to f(n-1)
jal fibonacci #restart fibinacci
move $s1, $v0 # store result of f(n-1) to s1
addi $a0, $s0, -2 # set args for recursive call to f(n-2)
jal fibonacci #restart fibinochi
add $v0, $s1, $v0 # add result of f(n-1) to it
fibonacciExit:
# Epilogue
lw $ra, 8($sp) #restore $ra 
lw $s0, 4($sp) #restore $s0
lw $s1, 0($sp) #restore $s1
addi $sp, $sp, 12 #adjust stack
jr $ra #jump to return address
## End of function fibonacci

equalToZero:
li $v0, 4 #syscall 4
la $a0, message #load message to $a0
syscall #system call
