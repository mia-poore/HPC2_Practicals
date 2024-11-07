#!/bin/bash

echo 'Setting up environment'

source ~/initMamba.sh


echo "CONDITIONS:" > config.yml
{       read
        while IFS=, read -r line;
        do
                printf "  - ${line}\n">>config.yml

        done

} < ../data/derived/top_conditions.csv

