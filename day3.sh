#!/bin/bash

readarray -t lines < inputs/day3.input
part1Sum=0

for line in "${lines[@]}";
do
    lineLen=${#line} 
    leftIndex=1
    leftValue=${line:0:1}
    rightIndex=$(($lineLen - 2))

    while [ $leftValue -lt ${line:leftIndex:1} ]
    do
        leftValue=${line:$((leftIndex++)):1}
    done

    while [ $leftIndex -lt $rightIndex ]
    do 
        nextBiggestIndex=$rightIndex
        for i in $(seq $rightIndex -1 $leftIndex)
        do
            if [[ ${line:$rightIndex:1} -ge ${line:$nextBiggestIndex:1} ]];
            then
                nextBiggestIndex=$rightIndex
            fi

            ((rightIndex--))
        done

        if [[ $leftValue -lt ${line:$nextBiggestIndex:1} ]];
        then
            leftValue=${line:$nextBiggestIndex:1}
            leftIndex=$(($nextBiggestIndex + 1))
            rightIndex=$(($lineLen - 2))
        else
            break
        fi
    done

    rightIndex=$(($lineLen - 1))
    rightValue=${line:$(($lineLen - 1)):1}
    for i in $(seq $leftIndex $rightIndex)
    do
        if [[ $rightValue -lt ${line:$i:1} ]]; 
        then
            rightValue=${line:$i:1}
        fi
    done

    part1Sum=$(($part1Sum + ($leftValue * 10 + $rightValue)))
done

echo "Day 3 Part 1: " $part1Sum