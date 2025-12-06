USING: command-line formatting io.encodings.utf8 io.files kernel
math math.parser namespaces prettyprint sequences 
sequences.merged simple-tokenizer splitting strings ;
IN: day6

: debug ( n -- n ) [ . ] keep ;
: 2debug ( n n -- n n ) [ . . ] 2keep ;

: read-file ( -- n ) command-line get first utf8 file-lines ;
: remove-op-parse-int ( n -- n n ) dup but-last [ string>number ] map swap last ;

read-file [ tokenize ] map flip
[ remove-op-parse-int "+" = [ sum ] [ product ] if ] map sum
"Day 6 Part 1: %d\n" printf

: get-space-indices ( n -- n )
    [ tokenize ] map flip
    [ [ length ] map maximum ] map
    0 [ 1 + + ] accumulate*
    but-last dup [ 1 - ] map swap 2merge ;

: remove-spaces ( n n -- n ) 
    get-space-indices swap 
    [ swap [ split-indices ] keep swap [ " " = ] reject ] map nip ;

: operator-array ( n -- n ) last [ first 1string ] map ;
: number-array ( n -- n ) 
    but-last flip 
    [ flip [ >string tokenize first string>number ] map ] map ; 

read-file dup remove-spaces dup number-array swap operator-array [ "+" = [ sum ] [ product ] if ] 2map sum
"Day 6 Part 2: %d\n" printf
