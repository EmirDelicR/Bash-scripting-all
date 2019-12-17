#!/bin/bash
# Basic for loop
# file name for.sh

# String
cities="Tokyo London Paris Dubai Mumbai"

for city in $cities; do
  echo "CITY: $city"
done

# Array
FRUITS=('Apple' 'Mango' 'Strawberry' 'Orange' 'Banana')

for item in "${FRUITS[@]}"; do
  echo "FRUIT: $item"
done

# Range
for i in {5..1}; do
  echo "COUNT: $i"
done

# Normal loop
for (( i=0; i<5; i++ )); do  
  echo "COUNT: $i"
done