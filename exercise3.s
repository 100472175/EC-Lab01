attack:
	lb s6 0(a1)
    beq s6, zero, exit
	li a3, 97 # Character being tested, starts with "a" # Initial of ascii, if you put a 33 and on the next a 168, we can test all the characters
    li t6, 122 # End character = "z"
    li s4, 1 # Something to compare with 1
    li s5, 0 # Something to compare with 0, because we need the character 0, not the "zero" we are using when typing zero
    li x19, 0 # Number of cycles per letter
    li t5, 0 # First letter is always stored, 0 when it has not been stored
    
rec_study_energy:
	rdcycle a6
    jal t2 string_compare
    rdcycle a7
    jal t3 report

     
     
next_character_generated:
	beq a3 t6 next_global_char
    addi a3 a3 1
    j rec_study_energy


report:
	sub t2 a7 a6
	beq t5 s5 store_char   
    bgt t2, x19 store_char
    blt t2, x19 mem_save
    jr t3
    
store_char:
    mv x18 a3 # Stores the letter
	mv x19 t2 # Stores the number of cycles
    beq t5 s4 mem_save
    li t5 1
	jr t3

mem_save:
	sb x18, 0(a2)
    addi a2, a2, 1 # Go to the next memory position to store the next character
    
next_global_char:
	addi a1 a1 1
    lb s6 0(a1)
    beq s6 zero exit
    j attack
    
exit:
	jr ra

string_compare:
    mv x14 a3

    lb x15 0(a1) #Load characters in the adresses for both strings
    
	beq x15,zero,error #check that string 1's first character is zero, meaning it is empty, if it is, warn error and go to "error" tag
    beq x14,zero,error #check that string 2's first character is zero, meaning it is empty, if it is, warn error and go to "error" tag
    
    beq x15,x14,loop #If the first character is equal, loop for the next
    
    j wrong


loop:
    # addi a1,a1,1
    addi x14,x14,1 
    lb x15,0(a1)
    
	add x6,x14,x15 #Add the charactesr values for both strings
    beq x6,zero,correct #If sum of characters values is 0, then it means that both string1 and string2's cahracters currently checked are zero, meaning end of the string for both of them
    
	beq x15,x14,loop #If character values are the same, go to the next loop iteration
    j wrong #If charcter valeus are NOT the same, then string comparison returns 0
    
correct:
    # li a1, password
	jr t2 #Return

wrong:
    # li a1, password    
	jr t2 #Return 

error:
    # li a1, password
	jr t2 #Return 