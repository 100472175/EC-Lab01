study_energy:
	li a1, 97
    li t6, 122
rec_study_energy:
	rdcycle a6
    jal t2 string_compare
    rdcycle a7
    jal t3 report

     
     
next_character:
	beq a1, t6, exit
    addi a1 a1 1
    j rec_study_energy

report:
    sub t2 a7 a6
    #print letter
    mv a0 a1
    li a7 11
    ecall
    #print double dots
    li a0 58
    li a7 11
    ecall
    #print cycles
    mv a0 t2
    li a7 1
    ecall
    #next line
    li a0, 10
    li a7, 11
    ecall
    
    jr t3


exit:
	jr ra


string_compare:
    mv x14 a1
    lb x15 0(a2) #Load characters in the adresses for both strings
    
	beq x15,zero,error #check that string 1's first character is zero, meaning it is empty, if it is, warn error and go to "error" tag
    beq x14,zero,error #check that string 2's first character is zero, meaning it is empty, if it is, warn error and go to "error" tag
    
    beq x15,x14,loop #If the first character is equal, loop for the next
    
    j wrong


loop:
	
    ## addi a2,a2,1
    
    addi x14,x14,1 
    
    lb x15,0(a2)
    
	add x6,x14,x15 #Add the charactesr values for both strings
    beq x6,zero,correct #If sum of characters values is 0, then it means that both string1 and string2's cahracters currently checked are zero, meaning end of the string for both of them
    
	beq x15,x14,loop #If character values are the same, go to the next loop iteration
    j wrong #If charcter valeus are NOT the same, then string comparison returns 0
    
correct:
	## li a3,1 #Set value of return for x7 as 1
    # li a2, password
	jr t2 #Return

    
wrong:
	## li a3,0  #Set value of return for x7 as 0
    # li a2, password    
	jr t2 #Return 

error:
	## li a3,-1  #Set value of return for x7 as -1
    # li a2, password
	jr t2 #Return 




