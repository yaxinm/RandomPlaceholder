#!/bin/bash

# example: ./placeholderinit.sh placeholderimage
# first command line argument is the directory with the images
# creates a file call placeholdermacros.tex


# =================== variables ============================
IMDIR=$1
NUMOFFIG=$(ls $IMDIR | wc -l)
DIRINIT=placeholder_init
FILE=$DIRINIT/placeholdermacros.tex

# # =================== check if target exist ======================
if [ -f $FILE ] 
then
    # echo "The file placeholdermacros.tex already exist."
    # read -p "Do you want to overwrite? Type yes to overwrite, no to exit" OVERWRITE
    # if [ $OVERWRITE != 'yes' ]; then exit 0; fi;
    exit 0
fi

# =================== write file =========================
echo "% Define path to placeholder image directory" > $FILE
echo "\def\placeholderpath{$IMDIR}" >> $FILE
echo " " >> $FILE

echo "% setup new counter fignum" >> $FILE
echo "\reinitrand[first=1, last=$NUMOFFIG, counter=fignum]" >> $FILE
echo " " >> $FILE

echo "% list of image" >> $FILE
echo "\def\placeholderimage#1{" >> $FILE
echo "    \ifcase#1\relax" >> $FILE

for IMG in $(ls $IMDIR)
do
    echo "    \or\placeholderpath/$IMG" >> $FILE
done

echo "    \fi" >> $FILE
echo "}" >> $FILE

echo "\input{$DIRINIT/placeholderinit_part2.tex}" >> $FILE
