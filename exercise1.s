string_compare:
    lb a4,0(a1) #Load characters in the addresses for both strings
    lb a5,0(a2)
    
	beq a5,zero,error #check that string 1's first character is zero, meaning it is empty, if it is, warn error and go to "error" tag
    beq a4,zero,error #check that string 2's first character is zero, meaning it is empty, if it is, warn error and go to "error" tag
    
    beq a5,a4,loop #If the first character is equal, loop for the next
    
    j wrong


loop:
	addi a1,a1,1 #Move to next address value for both string 1 and string 2
    addi a2,a2,1
    
    lb a4,0(a1) #Load new characters from string1's and string 2's next characters
    lb a5,0(a2)
    
	add t1,a4,a5 #Add the character values for both strings
    beq t1,zero,correct #If sum of characters values is 0, then it means that both string1 and string2's characters currently bring checked are zero, meaning end of the string for both of them
    
	beq a5,a4,loop #If character values are the same, go to the next loop iteration
    j wrong #If character values are NOT the same, then string comparison returns 0
    
correct:
	li a3,1 #Set value of return for x7 as 1
	jr ra #Return 
    
wrong:
	li a3,0  #Set value of return for x7 as 0
	jr ra #Return 

error:
	li a3,-1  #Set value of return for x7 as -1
	jr ra #Return 
