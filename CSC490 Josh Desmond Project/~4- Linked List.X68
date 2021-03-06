*-----------------------------------------------------------
* Title      : Making a linked list of "objects"
* Written by : Josh Desmond
* Date       : 5/22/14
* Description: This program will have the full implementation
* of a linked list data structure. The "object" will be
* a multiple field structure defined at the start of the
* program through the OFFSET directive. The linked list
* will include a pointer, and have a method that
* will iterate through the list.
* 
* 
*
*
*-----------------------------------------------------------

* The "object" structure, with four seperate fields
        OFFSET  0
word1   ds.l    1
word2   ds.w    1
word3   ds.w    1
word4   ds.w    1
long1   ds.l    1
olength equ     *
        org     *
        
        
* The NODE Structure
        OFFSET  0
node    ds.b    olength
next    ds.w    1
nlength equ     *
        org     *

	    org     $1000
START  
        ; Setting up the Linked List
        move.l  #$2000,a6
        move.l  a6,first
        move.l  a6,last
        move.l  a6,curr
        
        ;Creating the first nodes
        bsr     newNode
        bsr     newNode
        bsr     newNode
        bsr     newNode
        
        move.l  decreaseWord,a4
        bsr     iterateList
        
        move.b  #9,d0
        trap    #15
*-----------------------------------------------------------
* newNode
* creates a node based on the four values pushed into the
* stack, and then adds it to the list.
*
* #8 = w1, #10 = w2, #12 = w3, #14 = w4


newNode
        
        move.l  last,a6
        
        move.w  #$ABCD,word1(a6)
        move.w  #$EFFF,word2(a6)
        move.w  #$DCBA,word3(a6)
        move.w  #$AAAA,word4(a6)
        
        move.w  a6,d0
        add.w   #nlength,d0
        move.w  d0,olength(a6)
        adda.w  #nlength,a6
        move.l  a6,last
        ;move.w  nlength(a6),a6
        
        
        
        rts

iterateList
        *Iterates from curr to last, running the method stored
        *in decreaseWord for each iteration.
        
        move.l  curr,a6
        
dowhile_1 
        * Iteration Code goes here *
        *==========================*
        bsr     decreaseWord
        
        
        *==========================*
        ; If the next address is null, then you're done, so
        ; goto while_2 and escape the loop.
        cmp.w   #$FFFF, next(a6)
        beq     dowhile_2
        ; Increments a6 to the next value and reloops the while
        move.w  next(a6),a6
        bra     dowhile_1
dowhile_2
        
        rts
        
decreaseWord
        * Subtracts one from the first word of the object at a6
        subq    #2,word1(a6)
        rts

*-----------------------------------------------------------
* Variable storage and strings
* ds (define storage) is used to reserve memory for variables
* dc (define constant) is used to place data in memory

first   ds.l    1
last    ds.l    1
curr    ds.l    1

;method  ds.l    2

val1    equ    9111
val2    equ    5555
val3    equ    161616
val4    equ    128128

    END    START


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
