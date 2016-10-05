#!/bin/bash


Path=$1
echo "Given path is : $1"

cd $1

echo "Extracting Tar file"
tar -xf  *.tar

echo "Extracting nc files from .bz"
bzip2 -df  *.bz2

echo "List all extracted files"
ls -al

echo "looping thru all files with extention .nc"		
for i in `find . -name "*.nc" -type f`; do
    echo "I do something with the file $i"
    year=$(echo $i | cut -d"_" -f3); echo $year
    dayofYear=$(echo $i | cut -d"_" -f4 | cut -d"." -f1); echo $dayofYear
    dateValue=$(date -d "$dayofYear days $year-01-01" +"%Y-%m-%d")
    echo $dateValue
    echo $i

    outputFileName=output_global_30s_$dateValue.nc
    outputsetReftime=outputsetReftime_global_30s_$dateValue.nc
    outputremapcon=outputremapcon_global_30s_$dateValue.nc
    
    echo "setting date value of the file"
    cdo setdate,$dateValue $i $outputFileName
    echo "setting reference time to the file"
    cdo setreftime,2001-01-01,00:00:00 $outputFileName $outputsetReftime
    echo "remapping to the extent as given by grid.txt"
    cdo remapcon,grid.txt $outputsetReftime $outputremapcon
 done

echo "Merging all remapped .nc files into one file according to time."
cdo mergetime $outputremapcon finalmergedOutput.nc




