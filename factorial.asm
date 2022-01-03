#reference- https://gist.github.com/Peng-YM/be70d28079833bd701b05a5ce7772ff1
.data
    prompt: .asciiz "Input an integer:\n" #storing an output message to be called
    result: .asciiz "Fact(x) = " #storing an output message to be called
.text
    # show prompt
    li        $v0, 4 #syscall 4
    la        $a0, prompt #load prompt into $a0
    syscall #system call,
    # read x
    li        $v0, 5 #syscall 5
    syscall #system call
    # function call
    move      $a0, $v0 # $a0 = $v0, $a0 will be the input
    jal      factorial       # jump factorial and save position to $ra
    move      $t0, $v0        # $t0 = $v0
    # show prompt
    li        $v0, 4 #syscall 4
    la        $a0, result #save result prompt into $a0
    syscall #system call
    # print the result
    li        $v0, 1        # system call #1 - print int
    move      $a0, $t0        # $a0 = $t0
    syscall                # system call
    # return 0
    li        $v0, 10        # $v0 = 10
    syscall #system call


.text
factorial:
    # base case -- still in parent's stack segment
    # adjust stack pointer to store return address and argument
    addi    $sp, $sp, -8 
    # save $s0 and $ra
    sw      $s0, 4($sp) #save $s0 in stack
    sw      $ra, 0($sp) #save $ra in stack
    bne     $a0, 0, else #perform else, if $a0 is not zero
    addi    $v0, $zero, 1    # return 1
    j fact_return #jump to fact_return

else:
    # backup $a0
    move    $s0, $a0 #$s0 = $a0
    addi    $a0, $a0, -1 # x -= 1
    jal     factorial #call factorial until condition does not hold
    # when we get here, we already have Fact(x-1) store in $v0
    multu   $s0, $v0 # return x*Fact(x-1), this will execute on final
    mflo    $v0 #store into LO
fact_return:
    lw      $s0, 4($sp) #restore $s0
    lw      $ra, 0($sp) #restore $ra
    addi    $sp, $sp, 8 #adjust the stack
    jr      $ra #return to main
