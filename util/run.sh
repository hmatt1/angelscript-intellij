#!/bin/bash

rm out.txt
rm cleaned.txt
rg --sort path --multiline '\*script(.|\n)*?";\s*(//.*)?\s*$' > out.txt

#rg --sort path --multiline '\*script(.|\n)*?";' > out.txt
#cat out.txt | perl -pe's/(.*)?://; $name=$1; if(/\*script/){print "matches_script $name\n"} s/(static)?\s+const.*?=//; s/^\s+//; s/^"//; s/";?\s+$/\n/; s/\\n$//;' > cleaned.txt
#cat out.txt | perl -pe's/^([^:]*)://; $name=$1; if(/\*script/){print "matches_script $name\n"} s/^[^"]*(static)?\s+const.*?=//; s/^\s+//; s/^"//; s/";?\s+$/\n/; s/\\n$//; s/\\\\/\\/g; s/\\"/"/g;' > cleaned.txt
cat out.txt | perl -pe's/^([^:]*)://; $name=$1; if(/\*script/){print "matches_script $name\n"} s/^[^"]*(static)?\s+const.*?=//; s/^\s+//; s/^"//; s/";?\s*(\/\/[^"]*)?\s*$/\n/; s/\\n$//; s/\\\\/\\/g; s/\\"/"/g;' > cleaned.txt

rm -rf scripts
mkdir -p scripts

name=unknown.txt
file_num=0

while IFS="" read -r p || [ -n "$p" ]
do
    new_name=$(echo "$p" | sed -E 's/^matches_script (.*)/\1/')
    
    if [[ "$new_name" = *.cpp ]]
    then
        ((file_num++))
        name=$(echo $new_name | sed -E 's/\.cpp/_'$file_num'.as/; s/test_?//;')
        echo $name
    else
        printf '%s\n' "$p" | sed -E 's/\s+$//' >> "./scripts/$name"
    fi

done < cleaned.txt

