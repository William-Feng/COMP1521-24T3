        .text
main:
        # Registers:
        # $t0 = x
        # $t1 = y
        # $t2 = sum

main__prologue:
        begin
        push    $ra                     # Save the value of the current return address
        push    $s0                     # We need the value of x after the function
        
main__body:
        li      $s0, 10                 # int x = 10;
        li      $t1, 5                  # int y = 5;
        
        # The arguments are loaded into the $a registers
        # The return value of a function is in $v0
        
        # Steps to invoke a function:
        # 1. Load the arguments into the $a registers
        # 2. Call `jal function_name` to execute the function
        # 3. Restore the return value from $v0 (if necessary)
        
        move    $a0, $s0                # Load x (for the function call)
        move    $a1, $t1                # Load y (for the function call)
        
        jal     add_nums                # Execute the add_nums function
        move    $t2, $v0                # Move the returned value into `sum`
        
        move    $a0, $t2                # printf("%d", sum);
        li      $v0, 1
        syscall
        
        li      $a0, '\n'               # printf("%c", '\n');
        li      $v0, 11
        syscall
        
        move    $a0, $s0                # printf("%d", x);
        li      $v0, 1
        syscall
        
        li      $a0, '\n'               # printf("%c", '\n');
        li      $v0, 11
        syscall
        
main__epilogue:
        pop     $s0                     # Pop the 'pushed' value in the reverse order
        pop     $ra                     
        end

        li      $v0, 0                  # return 0;
        jr      $ra
        
        
add_nums:
        add     $t0, $a0, $a1           # int random = x + y;
        move    $v0, $t0                # $v0 is the value that we return
        jr      $ra
