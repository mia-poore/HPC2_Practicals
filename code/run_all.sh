#!/bin/bash

Rscript 1_get_unique_conditions.R

while IFS=, read -r line;
do
	Rscript 2_find_side_effects.R "${line}"

done < ../data/derived/top_conditions.csv
