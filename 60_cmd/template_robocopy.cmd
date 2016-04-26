REM
REM Synchronize user files (a.k.a. backup)
REM
REM Make a copy of specific files 
REM SRC is source folder
REM DST is destination folder
REM LOG is logfile (including path), log data will be appended
REM DAT is data to copy (*.*)
REM CMD is robocopy command
REM OPT are robocopy options
REM 
REM Author: Alexander Tempel 2015
REM Update: 2015-12-29 ate setup
REM Update: 2016-02-05 ateadded dat variable, modified cmd command by adding dat variable

REM Enter data here
REM backup keepass file
setlocal
set SRC=C:\<source_path>\
set DST=C:\<destination_path\
set LOG=C:\<destination_path\rbc_bckp_<file_name>.log
set DAT=<filename>.txt

set CMD=robocopy %SRC% %DST% %DAT%
set OPT=/LOG+:%LOG%
start /MIN "Copying <file_name> file to local drive" %CMD% %OPT%