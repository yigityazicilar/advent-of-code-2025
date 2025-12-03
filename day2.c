#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define EXAMPLE_FILE "inputs/day2.example"
#define INPUT_FILE "inputs/day2.input"
#define i64 long long int

typedef struct {
  i64 a;
  i64 b;
} Range;

int digitCount(i64 n) { return floor(log10(n)) + 1; }

int isInRange(i64 num, Range range) { return num >= range.a && num <= range.b; }

i64 part1(Range *ranges, int count) {
  i64 sum = 0;
  for (int i = 0; i < count; i++) {
    i64 a = ranges[i].a;
    i64 b = ranges[i].b;
    int aDigits = digitCount(a);
    int bDigits = digitCount(b);

    if (aDigits % 2 == 1 && bDigits % 2 == 1) {
      continue;
    }

    i64 start = a / pow(10, ceil(aDigits / 2.0));
    for (i64 j = start; j < b; j++) {
      i64 num = j * pow(10, digitCount(j)) + j;
      if (num > b) {
        break;
      }

      if (isInRange(num, ranges[i])) {
        sum += num;
      }
    }
  }

  return sum;
}

int isInvalidPart2(i64 n) {
  char str[32];
  sprintf(str, "%lld", n);
  int len = strlen(str);

  for (int subLen = 1; subLen <= len / 2; subLen++) {
    if (len % subLen == 0) {
      int repeats = len / subLen;
      int match = 1;
      for (int i = 1; i < repeats; i++) {
        if (strncmp(str, str + i * subLen, subLen) != 0) {
          match = 0;
          break;
        }
      }
      if (match)
        return 1;
    }
  }
  return 0;
}

i64 part2(Range *ranges, int count) {
  i64 sum = 0;
  for (int i = 0; i < count; i++) {
    for (i64 j = ranges[i].a; j <= ranges[i].b; j++) {
      if (isInvalidPart2(j)) {
        sum += j;
      }
    }
  }
  return sum;
}

int main() {
  FILE *input = fopen(INPUT_FILE, "r");
  if (!input) {
    fprintf(stderr, "Error opening file\n");
    return 1;
  }

  int capacity = 10;
  int count = 0;
  Range *ranges = malloc(capacity * sizeof(Range));

  i64 a, b;
  while (fscanf(input, "%lld-%lld", &a, &b) == 2) {
    if (count >= capacity) {
      capacity *= 2;
      ranges = realloc(ranges, capacity * sizeof(Range));
    }

    ranges[count].a = a;
    ranges[count].b = b;
    count++;

    fgetc(input);
  }

  ranges = realloc(ranges, count * sizeof(Range));

  printf("Day 2 Part 1: %lld\n", part1(ranges, count));
  printf("Day 2 Part 2: %lld\n", part2(ranges, count));
  free(ranges);
  fclose(input);
  return 0;
}