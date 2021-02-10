#!/bin/sh

# Author : Michael Kilgore

musicfolder=$1

read -p "Enter 1 to output to screen and 2 to write report in a file called Answer.txt" answer

if [ $answer == 1 ] 
then


#WARMUP

echo ""
echo "WARMUP"
echo ""

printf "Total Tracks: "
find $musicfolder -name '*.ogg' | wc -l
echo ""

printf "Total Artists: "
find $musicfolder -maxdepth 2 -mindepth 2 -type d | rev | cut -d '/' -f1 | rev | sort | uniq | wc -l 
echo ""

echo "Multi-Genre Artists: "
find $musicfolder -maxdepth 2 -mindepth 2 -type d | rev | cut -d '/' -f1 | rev | sort | uniq -d
echo ""

echo "Multi-Disk Albums: "
find $musicfolder -maxdepth 4 -mindepth 4 -type d | rev | cut -d '/' -f2- | cut -d '/' -f1 | rev | sort | uniq

#DETAILED REPORT

echo ""
echo "DETAILED REPORT"
echo ""

echo "      Multi-Genre Artists: "
find $musicfolder -maxdepth 2 -mindepth 2 -type d | sed 's# #=#g' | sed 's#/# #g' | sort -k 3,3 | guniq -f2 -D | sed 's# #/#g' | sed 's#=# #g' | awk -F '/' '{if($4 in seen) printf "          %s\n",$3; else printf "        %s\n          %s\n",$4,$3; !seen[$4]++;}'  

echo ""

echo "      Multi-Disk Albums: "
find $musicfolder -maxdepth 4 -mindepth 4 -type d | sed 's# #=#g' | sed 's#/# #g' | sort -k 3,3 | sed 's# #/#g' | sed 's#=# #g' | rev | cut -d '/' -f2- | rev | uniq | awk -F '/' '{if($4 in seen) printf "          %s\n", $5; else printf "        %s\n          %s\n", $4, $5; !seen[$4]++;}'

echo ""

echo "      Possible Duplicate Albums: "
find $musicfolder -maxdepth 3 -mindepth 3 | sed 's# #=#g' | sed 's#/# #g' | sort -k 4,4 | guniq -f3 -D | sed 's# #/#g' | sed 's#=# #g' | awk -F '/' '{if($5 in seen) printf "          %s  %s\n", $3, $4; else printf "        %s\n          %s  %s\n", $5, $3, $4; !seen[$5]++;}'   
 
fi

if [ $answer == 2 ] 
then

#WARMUP

echo "" >> Answer.txt 
echo "WARMUP" >> Answer.txt
echo "" >> Answer.txt

printf "Total Tracks: " >> Answer.txt
find $musicfolder -name '*.ogg' | wc -l  >> Answer.txt
echo "" >> Answer.txt

printf "Total Artists: " >> Answer.txt
find $musicfolder -maxdepth 2 -mindepth 2 -type d | rev | cut -d '/' -f1 | rev | sort | uniq | wc -l >> Answer.txt
echo "" >> Answer.txt

echo "Multi-Genre Artists: " >> Answer.txt
find $musicfolder -maxdepth 2 -mindepth 2 -type d | rev | cut -d '/' -f1 | rev | sort | uniq -d >> Answer.txt
echo "" >> Answer.txt

echo "Multi-Disk Albums: " >> Answer.txt
find $musicfolder -maxdepth 4 -mindepth 4 -type d | rev | cut -d '/' -f2- | cut -d '/' -f1 | rev | sort | uniq >> Answer.txt

#DETAILED REPORT

echo "" >> Answer.txt
echo "DETAILED REPORT" >> Answer.txt
echo "" >> Answer.txt

echo "      Multi-Genre Artists: " >> Answer.txt
find $musicfolder -maxdepth 2 -mindepth 2 -type d | sed 's# #=#g' | sed 's#/# #g' | sort -k 3,3 | guniq -f2 -D | sed 's# #/#g' | sed 's#=# #g' | awk -F '/' '{if($4 in seen) printf "          %s\n",$3; else printf "        %s\n          %s\n",$4,$3; !seen[$4]++;}' >> Answer.txt

echo "" >> Answer.txt

echo "      Multi-Disk Albums: " >> Answer.txt
find $musicfolder -maxdepth 4 -mindepth 4 -type d | sed 's# #=#g' | sed 's#/# #g' | sort -k 3,3 | sed 's# #/#g' | sed 's#=# #g' | rev | cut -d '/' -f2- | rev | uniq | awk -F '/' '{if($4 in seen) printf "          %s\n", $5; else printf "        %s\n          %s\n", $4, $5; !seen[$4]++;}' >> Answer.txt

echo "" >> Answer.txt

echo "      Possible Duplicate Albums: " >> Answer.txt
find $musicfolder -maxdepth 3 -mindepth 3 | sed 's# #=#g' | sed 's#/# #g' | sort -k 4,4 | guniq -f3 -D | sed 's# #/#g' | sed 's#=# #g' | awk -F '/' '{if($5 in seen) printf "          %s  %s\n", $3, $4; else printf "        %s\n          %s  %s\n", $5, $3, $4; !seen[$5]++;}' >> Answer.txt



fi




