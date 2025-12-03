#!/bin/bash

python3 day1.py
echo
clang -lm day2.c -o day2 && ./day2 && rm day2
echo
source day3.sh