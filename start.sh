P=$PWD
cd data
../hazacortaenout > ../haza.log &
bash $P/n2.sh >../n2.log
bash $P/n2qt.sh >../n2qt.log
bash $P/n2qt2.sh >../n2qt2.log
bash $P/n2qi.sh >../n2qi.log
bash $P/n2qo.sh >../n2qo.log
bash $P/n2paracs.sh >../n2paracs.log
