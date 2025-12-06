# Advent of Code 2025
This repository contains solutions for [Advent of Code 2025](https://adventofcode.com/2025). 

## Schedule
|  Day  | Language            | Status |
| :---: | :------------------ | -----: |
|  01   | **Python**          |      ✓ |
|  02   | **C**               |      ✓ |
|  03   | **Bash**            |      ✓ |
|  04   | **OCaml**           |      ✓ |
|  05   | **Common Lisp**     |      ✓ |
|  06   | **Factor**          |      ✓ |
|  07   | **SQL**             |        |
|  08   | **APL**             |        |
|  09   | **Idris**           |        |
|  10   | **Agda**            |        |
|  11   | **ARM Assembly**    |        |
|  12   | **Lambda Calculus** |        |

## Usage
This project uses [Just](https://github.com/casey/just) to standardise running solutions across different languages/compilers.

### Prerequisites
* **Just:** `cargo install just` (or via your package manager)
* **Compilers/Runtimes:**
    * Python 3
    * C (`clang`)
    * Bash
    * OCaml (`ocamlopt`)
    * Common Lisp (`sbcl`)
    * *More to be added as days progress...*

### Commands
> [!IMPORTANT]
> **Input Files Required**
> 
> Advent of Code inputs are unique to every user and are **not checked into this repository**.
>
> To run the solutions with real data, you must save your specific puzzle input as `inputs/dayX.input` (e.g., `inputs/day1.input`).
>
> The `example` runs will work out-of-the-box

**Run all solutions:**
```bash
just
```

**Run all examples:**
```bash
just examples
```

**Run a specific day:**
```bash
# Defaults to running with the real input
just day1

# Run with example input
just day5 example
```