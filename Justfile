set quiet

solutions: day1 day2 day3 day4 day5 day6 day7 day8

examples: (day1 "example") (day2 "example") (day3 "example") (day4 "example") (day5 "example") (day6 "example") (day7 "example") (day8 "example")

day1 type="input":
    @echo "--- Day 1 {{ if type == 'example' { 'Example ' } else { '' } }}(Python) ---"
    python3 day1.py inputs/day1.{{type}}

day2 type="input":
    @echo "--- Day 2 {{ if type == 'example' { 'Example ' } else { '' } }}(C) ---"
    clang -lm day2.c -o day2
    ./day2 inputs/day2.{{type}}
    rm day2

day3 type="input":
    @echo "--- Day 3 {{ if type == 'example' { 'Example ' } else { '' } }}(Bash) ---"
    bash day3.sh inputs/day3.{{type}}
    
day4 type="input":
    @echo "--- Day 4 {{ if type == 'example' { 'Example ' } else { '' } }}(OCaml) ---"
    ocamlopt -o day4 day4.ml
    ./day4 inputs/day4.{{type}}
    rm day4 day4.cmi day4.cmx day4.o

day5 type="input":
    @echo "--- Day 5 {{ if type == 'example' { 'Example ' } else { '' } }}(Common Lisp) ---"
    sbcl --script day5.lisp inputs/day5.{{type}}

day6 type="input":
    @echo "--- Day 6 {{ if type == 'example' { 'Example ' } else { '' } }}(Factor) ---"
    ~/.build/factor/factor day6.factor inputs/day6.{{type}}
    
day7 type="input":
    @echo "--- Day 7 {{ if type == 'example' { 'Example ' } else { '' } }}(SQLite) ---"

    sqlite3 day7.db \
            -cmd ".parameter set :f 'inputs/day7.{{type}}'" \
            ".read day7init.sql"

    for i in $(seq 0 $(($(sqlite3 day7.db "SELECT max(y) FROM rows;") - 1))); do \
        sqlite3 day7.db -cmd ".parameter set :y $i" ".read day7step.sql"; \
    done 

    @echo "Day 7 Part 1:" $(sqlite3 day7.db "SELECT SUM(is_used) FROM splitters;")
    @echo "Day 7 Part 2:" $(sqlite3 day7.db "SELECT SUM(strength) FROM beams WHERE y = (SELECT max(y) FROM rows);")
    
    rm -f day7.db
    
day8 type="input":
    @echo "--- Day 8 {{ if type == 'example' { 'Example ' } else { '' } }}(Uiua) ---"
    uiua run day8.ua inputs/day8.{{type}} {{ if type == 'example' { '10' } else { '1000' } }}

new day ext:
    touch day{{day}}.{{ext}}
    touch inputs/day{{day}}.input
    touch inputs/day{{day}}.example
    @echo "Created day{{day}}.{{ext}} and input files."