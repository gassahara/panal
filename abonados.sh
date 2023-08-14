cat AB2.txt | tr -d "'" | sed "s/\([[:alnum:]]\)[,;]\{1,\}\([[:alnum:]]\)/\1\;\2/g;" | sed "s/\([[:alnum:]]\),\([[:alnum:]]\)/\1;\2/g" | tr "(" "\n" | tr "\)" "\n"  > ABB.txt
