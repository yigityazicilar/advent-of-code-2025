#!/bin/bash
function max_string_index {
    string=$1
    max=0
    index=-1
    for (( i=0; i<${#string}; i++ )); do
        if (( ${string:i:1} > $max )); then
            max=${string:i:1}
            index=$i
        fi
    done

    echo $index
}

function max_joltage {
    local line=$1
    local batteries_left=$2
    
    if (( ${#line} == $batteries_left )); then
        echo $line
        return 0
    fi

    if (( $batteries_left > 1 )); then
        max_index=$(max_string_index ${line:0:$((${#line} - batteries_left + 1))})
        value=$((10 ** ($batteries_left - 1) * ${line:max_index:1}))
        recursion=$(max_joltage ${line:$(($max_index + 1))} $(($batteries_left - 1)))
        echo $(($value + $recursion)) 
    else
        echo ${line:$(max_string_index $line):1}
    fi
}

IFS=$'\n'
input=$(cat "inputs/day3.input")
read -d '' -a lines <<< "$input"

part1Joltage=0
part2Joltage=0
for line in ${lines[@]}; do
    part1Joltage=$(($part1Joltage + $(max_joltage $line 2)))
    part2Joltage=$(($part2Joltage + $(max_joltage $line 12)))
done

echo "Day 3 Part 1:" $part1Joltage
echo "Day 3 Part 2:" $part2Joltage
