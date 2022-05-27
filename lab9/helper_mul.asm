#
# Calculate sum from A to B. No initialized data memory needed here.
#
# Author: 
#  Luka Malisa <malisal@student.ethz.ch>

.text

main:
        addi  $t0, $0, 0        # $t0 = A
        addi  $t1, $0, 200      # $t1 = B
        addi $t2, $t0, -1 # A-1
        multu $t0, $t2    # A (A-1)
        mflo $t0          # mult result in t0
        srl $t0, $t0, 1   # divide by two
        
        addi $t2, $t1, 1  # B+1
        multu $t1, $t2    # B (B+1)
        mflo $t1          # mult result in t1
        srl $t1, $t1, 1   # divide by two
        
        sub $t2, $t1, $t0 # end result is the difference
        
 end:       
        j end             # loop t2 is the result 
