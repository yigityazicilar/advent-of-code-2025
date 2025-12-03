#usr/bin/env python3
from itertools import accumulate
from functools import reduce
from typing import Tuple
import sys

with open(sys.argv[1]) as f:
    lines = f.readlines()

lines = [line.strip() for line in lines]
values = [int(line[1:]) if line[0] == "R" else -int(line[1:]) for line in lines]
print(f"Day 1 Part 1: {sum([1 for x in accumulate(values, lambda x, y: (x + y) % 100, initial=50) if x == 0])}")

def countZeroClicks(acc, nextVal): 
    currVal, count = acc
    newVal = currVal + nextVal
    
    if nextVal >= 0:
        crossings = (newVal // 100) - (currVal // 100)
    else:
        crossings = ((currVal - 1) // 100) - ((newVal - 1) // 100)
    
    return (newVal, count + crossings)

print(f"Day 1 Part 2: {reduce(countZeroClicks, values, (50, 0))[1]}")
