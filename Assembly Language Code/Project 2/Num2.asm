
.data
song_durations:   .word 150, 270, 180, 210, 130   # Song durations in seconds
is_short_song:    .word 0, 0, 0, 0, 0           # Flags for short/long songs (initialized to 0)
short_playlist:   .word 0, 0, 0, 0, 0           # Short song playlist (initialized to 0)
long_playlist:    .word 0, 0, 0, 0, 0           # Long song playlist (initialized to 0)

.text
main:
    la $t0, song_durations      # Load the address of song_durations array
    la $t1, is_short_song       # "" is_short_song array , short song is under 2 minutes
    la $t6, short_playlist      # "" short_playlist  array
    la $t7, long_playlist       # "" long_playlist array

    li $t2, 5                   # Number of songs inn the array
    li $t3, 120                 # threshold for short/long song 

    loop:
        lw $t4, 0($t0)          # Load the song duration 
        lw $t5, 0($t1)          # Load the is_short_song flag

        # Check if the song is under 2 minutes
        bge $t4, $t3, is_long

        # If the song is short, set the flag to 1 and add it to short song playlist
        li $t5, 1
        sw $t4, 0($t6)          # Add short song to short playlist
        addi $t6, $t6, 4

        j next_song

        is_long:
            # If song is long, set the flag to 0 and add it to the long song playlist
            li $t5, 0
            sw $t4, 0($t7)      # Add long song to long playlist
            addi $t7, $t7, 4

        next_song:
            # Move to next song in the arrays
            addi $t0, $t0, 4
            addi $t1, $t1, 4

        # Check 
        subi $t2, $t2, 1
        bnez $t2, loop

    # Exit the program
    li $v0, 10
    syscall
