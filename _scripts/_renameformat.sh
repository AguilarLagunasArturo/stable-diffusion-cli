#!/bin/bash

# Find all files with the format "f_16_*.png" and loop through them
for file in ./*_*.png; do
    # Extract the number part from the filename (assuming format "f_16_%02d.png")
    # num=$(echo "$file" | grep -Eo '[0-9]{2}')
    num=$(echo "$file" | grep -o '[0-9]*' | tail -n 1)

    # Remove leading zero if present, and store as an integer
    num_int=$((10#$num))

    # Replace the original 2-digit number with the new 4-digit number
    new_file=$(printf "%04d.png" "$num_int")

    # Rename the original file to the new filename
    mv "$file" "$new_file"
done
