-- filename  : linked_server.sql
-- copyright : alexander tempel 2014-2016
-- modification history:
-- date        who         what
-- 2016-02-15  atempel     created

-- test linked server
-- modify linked server and postfix if neccessary
-- linked server naming is <servername>_<username>
declare @linkedserver   [nvarchar](4000)
declare @postfix_in     [nvarchar](50)
declare @connect_status [int]
set @linkedserver = '<fqdn_of_server>'
set @postfix_in = '<user_name>'
set @linkedserver = upper(@linkedserver + '_' + @postfix_in)
execute @connect_status = sys.sp_testlinkedserver @linkedserver;
select @connect_status as connect_status