#!/bin/bash

rm -r results
mkdir -p results

patterns="patterns/pattern-q*.txt" #get list of pattern files
p_regex="patterns/pattern-q([0-9]*).txt" #pattern files regex for group capture the pattern number

for pattern in $patterns
do
    if [[ $pattern =~ $p_regex ]] #check if pattern matches p_regex (and captures group)
    then
        p_num="${BASH_REMATCH[1]}" #regex capture group: get pattern number
        pattern_content=$(cat $pattern) #open pattern and get its content
        test_cases_num=$(echo "$pattern_content" | wc -l) #get number of test cases in pattern file

        #build csv header        
        printf "login\weigths" >> results/q$p_num.csv
        for i in $(seq $test_cases_num)
        do
            printf ",1" >> results/q$p_num.csv
        done
        printf ",\n" >> results/q$p_num.csv #print final ,\n

        files="codes/*-q$p_num.hs" #get list of code files reggarding pattern p_num
        f_regex="codes/([a-zA-Z0-9]*)-q$p_num.hs" #files regex for group capture the login
        for file in $files
        do
            if [[ $file =~ $f_regex ]] #check if file  matches f_regex (and captures group)
            then
                login="${BASH_REMATCH[1]}" #regex capture group: get login
                printf $login, >> results/q$p_num.csv

                #call ghci on the file and pattern then capture regex group
                result=$(echo "$pattern_content" | ghci codes/$login-q$p_num.hs 2>&1 | grep -oE "(\*[a-zA-Z0-9]*>|<interactive>:[0-9]*:[0-9]*:) (True|False|error)")

                #split result into words. Discard odd entries. Save to scsv
                let i=1
                for word in $result
                do
                    if (( i == 1 ))
                    then
                        let i=0
                    else
                        printf  $word, >> results/q$p_num.csv #print results to csv
                        let i=1
                    fi
                done
                printf "\n" >> results/q$p_num.csv #print final \n
            fi
        done
        #converts True/False/error to numeric value
        sed -i 's/True/1/g' results/q$p_num.csv
        sed -i 's/False/0/g' results/q$p_num.csv
        sed -i 's/error/0/g' results/q$p_num.csv
    fi
done
