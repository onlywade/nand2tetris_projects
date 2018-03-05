// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Put your code here.

// r2 = 0  (product)
// r3 = 0  (loop counter)
//
// while r3 <= r1:
//   r2 = r2 + r0
//   r3 = r3 + 1


    // product
    @R2
    M=0

    // loop counter
    @R3
    M=0

(LOOP)

    // Jump to end if loop counter minus operand b is <= 0
    @R3
    D=M
    @R1
    D=D-M
    @END
    D;JGE

    // Add operand 1 to product
    @R0
    D=M
    @R2
    M=D+M

    // increment loop counter and jump to beginning of loop
    @R3
    M=M+1
    @LOOP
    0;JMP

(END)

    @END
    0;JMP

