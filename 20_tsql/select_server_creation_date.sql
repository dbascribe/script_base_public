-- filename  : select_server_creation_date.sql
-- copyright : alexander tempel 2014-2016
-- modification history:
-- date        who         what
-- 2016-04-27  atempel     created

select convert(varchar(24),[createdate],103) + ' ' + convert(varchar(8), [createdate], 108) as sql_install_date 
from   [master].[sys].[syslogins]
where  [sid] = 0x010100000000000512000000 -- nt authority\system
;