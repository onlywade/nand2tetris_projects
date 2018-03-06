// This file is part of www.nand2tetris.org // and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.

// while true:
//   key = readkey()
//   if key == 1:
//     drawloop()
//   else:
//     eraseloop()
//
// def drawloop():
//   for x in 16384..24575:
//     memory[x]=-1
//     key = readkey()
//     if not key:
//     eraseloop()
//
// def eraseloop():
//   for x in 16384..24575:
//     memory[x]=0
//     key = readkey()
//     if key:
//     drawloop()


    // last pixel constant
    @24575
    D=A
    @z
    M=D

(READLOOP)

    @KBD
    D=M
    @DRAW
    M;JGT

    @ERASE
    0;JMP

    @READLOOP
    0;JMP

(DRAW)

    // pixel counter
    @16384
    D=A
    @x
    M=D

(DRAWLOOP)

    // abort if no key pressed
    @KBD
    D=M
    @ERASE
    D;JEQ

    // D <- last pixel - minus counter
    @x
    D=M
    @z
    D=M-D

    // quit if reached last pixel
    @END
    D;JEQ

    // draw 16 black pixels
    @x
    D=M
    A=D
    M=-1

    // increment pxel counter
    D=A+1
    @x
    M=D

    @DRAWLOOP
    0;JMP

(ERASE)

    // pixel counter
    @16384
    D=A
    @x
    M=D

(ERASELOOP)

    // abort if key pressed
    @KBD
    D=M
    @DRAW
    D;JGT

    // D <- last pixel - minus counter
    @x
    D=M
    @z
    D=M-D

    // quit if reached last pixel
    @END
    D;JEQ

    @x
    D=M
    A=D
    M=0

    D=A+1
    @x
    M=D
    @ERASELOOP
    0;JMP
