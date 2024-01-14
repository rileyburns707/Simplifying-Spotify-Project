.data
    songMood:   .word  0      # 0 for happy, 1 for sad
    isPublic:   .word  0      # 0 for private, 1 for public
    playlist:   .word  0      # Initialize the playlist (0 for private, 1 for public)

.text
    # load songMood and isPublic values into registers
    lw $t0, songMood     # $t0 = songMood
    lw $t1, isPublic     # $t1 = isPublic

    # Check the mood 
    beq $t0, $zero, happy_song   # happy_song iff songMood = 0
    bne $t0, $zero, sad_song     # sad_song if songMood != 0

happy_song:
    # Check if its a happy song and decide on playlist
    beq $t1, $zero, add_to_private_playlist  # private playlist if isPublic = 0
    bne $t1, $zero, add_to_public_playlist   #Public playlisst if isPublic != 0

sad_song:
    # Check if its a sad song and decide on playlist
    beq $t1, $zero, add_to_private_playlist  # Branch to private playlist if isPublic = 0
    bne $t1, $zero, add_to_public_playlist   # Branch to public playlist if isPublic != 0

add_to_private_playlist:
    # adds song to private playlist
    # update the "playlist" variable to 0 for private

    li $t2, 0       # Set $t2 to private playlist
    sw $t2, playlist

    # Exit the program
    li $v0, 10       # Load the exit system call code
    syscall

add_to_public_playlist:
    # adds song to public playlist
    # update the "playlist" variable to 1 for public

    li $t2, 1       # Set $t2 to public playlist
    sw $t2, playlist

    # Exit the program
    li $v0, 10       # exit system call code
    syscall
