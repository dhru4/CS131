#!/bin/bash

# Check if both parameters are provided
if [ $# -ne 2 ]; then
  echo "Usage: ./randomsample.sh x fileinput"
  exit 1
fi

# Extract x and fileinput from command line arguments
x=$1
fileinput=$2

# Check if x is a valid integer between 1 and 99
if ! [[ "$x" =~ ^[1-9][0-9]?$ ]]; then
  echo "Error: x must be an integer between 1 and 99."
  exit 1
fi

# Check if fileinput exists and is a file
if ! [ -f "$fileinput" ]; then
  echo "Error: fileinput does not exist or is not a file."
  exit 1
fi

# Count total number of lines in fileinput
num_lines=$(wc -l < "$fileinput")

# Calculate the number of lines to sample based on x%
num_lines_to_sample=$((num_lines * x / 100))


RANDOM=$$

sort -R "$fileinput" | head -n "$num_lines_to_sample"


