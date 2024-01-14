.data
prompt_old_new: .asciiz "Is the music old or new? (Enter '0' for old, '1' for new): "
prompt_slow_fast: .asciiz "Is the music slow or fast? (Enter '0' for slow, '1' for fast): "
prompt_hip_hop_folk: .asciiz "Is the music hip hop or folk? (Enter '0' for hip hop, '1' for folk): "
prompt_english_spanish: .asciiz "Is the music in English or Spanish? (Enter '0' for English, '1' for Spanish): "
result: .asciiz "You should add the following genre to your playlist: "

english_genre: .asciiz "English"
spanish_genre: .asciiz "Spanish"
.text
.globl main

main:
    # Prompt fpr the user for input
    li $v0, 4
    la $a0, prompt_old_new
    syscall
    li $v0, 5
    syscall
    move $t0, $v0

    li $v0, 4
    la $a0, prompt_slow_fast
    syscall
    li $v0, 5
    syscall
    move $t1, $v0

    li $v0, 4
    la $a0, prompt_hip_hop_folk
    syscall
    li $v0, 5
    syscall
    move $t2, $v0

    li $v0, 4
    la $a0, prompt_english_spanish
    syscall
    li $v0, 5
    syscall
    move $t3,$v0

    # Determining the genre based on input
    beq $t0, 0, check_new
    li $t4, 1
    j check_slow

check_new:
    beq $t1, 0, check_slow
    li $t4, 2
    j check_hip_hop

check_slow:
    beq $t2, 0, check_hip_hop
    li $t4, 3
    j check_language

check_hip_hop:
    beq $t3, 0, check_language
    li $t4, 4
    j print_result

check_language:
    beq $t3, 0, print_english
    li $t4, 5

print_result:
    li $v0, 4
    la $a0, result
    syscall
    li $v0, 1
    move $a0, $t4
    syscall

    # Exit the program
    li $v0, 10
    syscall

print_english:
    # Print English genre
    li $v0, 4
    la $a0, result
    syscall
    li $v0, 4
    la $a0, english_genre
    syscall
    j exit

exit:
    # Exit the program
    li $v0, 10
    syscall


