USING: ascii command-line formatting io.encodings.utf8 io.files 
kernel math math.parser namespaces prettyprint sequences 
sequences.merged simple-tokenizer splitting strings ;
IN: day6

: debug ( n -- n ) [ . ] keep ;
: 2debug ( n n -- n n ) [ . . ] 2keep ;

: read-file ( -- n ) command-line get first utf8 file-lines ;

: get-gaps ( n -- n )
    [ tokenize ] map flip
    [ [ length ] map maximum ] map 
    0 [ 1 + + ] accumulate* 
    but-last [ [ 1 - ] map ] keep 2merge ;

: split-on-gaps ( n -- n ) 
    [ get-gaps ] keep
    [ over split-indices [ " " = ] reject ] map nip ;

: operator-array ( n -- n ) last [ [ blank? ] trim ] map ;

: number-array ( n -- n ) but-last flip [ [ [ blank? ] trim string>number ] map ] map ;
: cephalopod-number-array ( n -- n ) but-last flip [ flip [ >string [ blank? ] trim string>number ] map ] map ; 

read-file split-on-gaps [ number-array ] keep operator-array [ "+" = [ sum ] [ product ] if ] 2map sum
"Day 6 Part 1: %d\n" printf

read-file split-on-gaps [ cephalopod-number-array ] keep operator-array [ "+" = [ sum ] [ product ] if ] 2map sum
"Day 6 Part 2: %d\n" printf
