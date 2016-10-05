The shell script, using the CDO library, processes the lai netcdf files downloaded from http://globalchange.bnu.edu.cn/research/lai/ .
Processing involves setting the reference time and date for each 8 day composite followed by remapping of the global extent 
to the extent as specified in the grid.txt file. Finally all 8 day composites are merged by time into one file. 
