#!/bin/bash


printf "\nhdfsListFiles\n"   >> ./total_stat.txt
python3 compute_stat.py -i ./data/listfiles.txt >> ./total_stat.txt

printf "\nsql\n" >> ./total_stat.txt
python3 compute_stat.py -i ./data/sql.txt >> ./total_stat.txt

printf "\nsql2\n" >> ./total_stat.txt
python3 compute_stat.py -i ./data/sql2.txt >> ./total_stat.txt
