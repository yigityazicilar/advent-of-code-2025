set quiet

solutions: day1 day2 day3

examples: (day1 "example") (day2 "example") (day3 "example")

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
    
new day ext:
    touch day{{day}}.{{ext}}
    touch inputs/day{{day}}.input
    touch inputs/day{{day}}.example
    @echo "Created day{{day}}.{{ext}} and input files."