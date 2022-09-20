#!/bin/bash

for d in Cluster*
do
    ( cd "$d" && cat *.txt > all_together.txt && ../../src/preprocess_text.pl all_together.txt > all_together_final.txt )
done


