#!/bin/sh

mkdir Base
cd Base

wget https://download.inep.gov.br/microdados/microdados_enem_2020.zip --no-check-certificate

unzip microdados_enem_2020.zip

cd DADOS

awk -F ';' '$14 == "Rio Branco" && $16 == "AC"' MICRODADOS_ENEM_2020.csv > provas_i.csv

cut -d";" -f14,16,28,29,30,31,32 provas_i.csv > provas_AC.txt

echo Número de Provas: > resultados.txt

wc -l provas_AC.txt |cut -f1 -d' ' >> resultados.txt

echo Média de nota >> resultados.txt

var=$(wc -l provas_AC.txt |cut -f1 -d' ')

awk -v awkvar="$var" -F ';' '{s+=$5} END {print s/awkvar}' provas_AC.txt >> resultados.txt

rm ITENS_PROVA_2020.csv
rm provas_AC.txt
rm provas_i.csv
rm -r DICIONÁRIO


cd ..
rm -r INPUTS
rm -r 'PROVAS E GABARITOS'
rm -r microdados_enem_2020.zip
rm -r 'LEIA-ME E DOCUMENTOS TÉCNICOS'
cd ..

mv dados_enem.sh Base
cd Base

mv dados_enem.sh DADOS 
 
cd DADOS

echo 'Done'