#!/bin/bash

# Calculate number of lines for 80% split
total_lines=$(wc -l < winequality-red.csv)
train_lines=$(echo "$total_lines*0.8" | bc | awk '{print int($1)}')

# Split the data
head -1 winequality-red.csv > header.csv
tail -n +2 winequality-red.csv | shuf > tmp.csv
head -n $train_lines tmp.csv > train/data.csv
tail -n +$(($train_lines+1)) tmp.csv > test/data.csv

# Replace the separator if needed
if [ $(head -n 1 winequality-red.csv | grep -c ";") -eq 1 ]; then
    sed 's/;/,/g' train/data.csv > train/tmp.csv
    sed 's/;/,/g' test/data.csv > test/tmp.csv
    mv train/tmp.csv train/data.csv
    mv test/tmp.csv test/data.csv
fi

# Cleanup
rm header.csv tmp.csv
