-- filename : rename_sqlserver.sql
-- author   : alexander tempel (ate)
-- version  : 15.02.2016

-- rename sqlserver after the host was renamed
-- get current name
select @@servername

-- some basic checks
-- query to check remote login
select srlo.remote_name as remote_login_name
     , ssse.srvname as server_name
from   sys.remote_logins srlo 
join   sys.sysservers ssse 
       on srlo.server_id = ssse.srvid

-- query to check if the sql instance databases are involved in replication
select name
     , is_published
     , is_subscribed
     , is_distributor
from   sys.databases
where  is_published = 1
or     is_subscribed = 1
or     is_distributor = 1

-- query to find out the databases involved in db mirroring
select database_id
     , db_name(database_id)
from   sys.database_mirroring 
where  mirroring_guid is not null

-- action
-- rename default instance
sp_dropserver n'<old_name>';
go
sp_addserver n'<new_name>', local;
go

-- rename named instance
sp_dropserver N'<old_name\instancename>';
go
sp_addserver N'<new_name\instancename>', local;
go


-- links
-- https://msdn.microsoft.com/en-us/library/ms143799(v=sql.120).aspx