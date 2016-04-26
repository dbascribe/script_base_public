/*
   version   : 1.0
   filename  : select_database_file_size.sql
   author    : alexander tempel
   copyright : alexander tempel 2014-2015
  
   summary   : shows datafile and transactionlog file sizes on an instance for each
               db. Works with sqlserver 2005 and greater.

  
   acknowledgements    :
  
  
   modification history:
   date        who         what
   2014-12-02  atempel     created
*/

with fs
as
(
select database_id, type, size * 8 / 1024 size
from master.sys.master_files
)
select
   name,
   (select sum(size) from fs where type = 0 and fs.database_id = db.database_id) DatafileSizeMB,
   (select sum(size) from fs where type = 1 and fs.database_id = db.database_id) LogfileSizeMB
from sys.databases db
