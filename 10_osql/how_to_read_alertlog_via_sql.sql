
/*
   version   : 1.0
   filename  : file_name.sql
   author    : alexander tempel
   copyright : alexander tempel 2014-2016
  
   summary   : brier summary
  
   acknowledgements    : tanel poder
    
   modification history:
   date        who         what
   2016-04-26  atempel     created
*/


-- links
--    http://blog.tanelpoder.com/2009/03/21/oracle-11g-reading-alert-log-via-sql/
-- x$dbgalertext
-- accessable by sys

-- description (11g)
desc x$dbgalertext

 Name                                      Null?    Typ
 ----------------------------------------- -------- ----------------------------
 ADDR                                               RAW(8)
 INDX                                               NUMBER
 INST_ID                                            NUMBER
 CON_ID                                             NUMBER
 ORIGINATING_TIMESTAMP                              TIMESTAMP(3) WITH TIME ZONE
 NORMALIZED_TIMESTAMP                               TIMESTAMP(3) WITH TIME ZONE
 ORGANIZATION_ID                                    VARCHAR2(64)
 COMPONENT_ID                                       VARCHAR2(64)
 HOST_ID                                            VARCHAR2(64)
 HOST_ADDRESS                                       VARCHAR2(46)
 MESSAGE_TYPE                                       NUMBER
 MESSAGE_LEVEL                                      NUMBER
 MESSAGE_ID                                         VARCHAR2(64)
 MESSAGE_GROUP                                      VARCHAR2(64)
 CLIENT_ID                                          VARCHAR2(64)
 MODULE_ID                                          VARCHAR2(64)
 PROCESS_ID                                         VARCHAR2(32)
 THREAD_ID                                          VARCHAR2(64)
 USER_ID                                            VARCHAR2(64)
 INSTANCE_ID                                        VARCHAR2(64)
 DETAILED_LOCATION                                  VARCHAR2(160)
 PROBLEM_KEY                                        VARCHAR2(550)
 UPSTREAM_COMP_ID                                   VARCHAR2(100)
 DOWNSTREAM_COMP_ID                                 VARCHAR2(100)
 EXECUTION_CONTEXT_ID                               VARCHAR2(100)
 EXECUTION_CONTEXT_SEQUENCE                         NUMBER
 ERROR_INSTANCE_ID                                  NUMBER
 ERROR_INSTANCE_SEQUENCE                            NUMBER
 VERSION                                            NUMBER
 MESSAGE_TEXT                                       VARCHAR2(2048)
 MESSAGE_ARGUMENTS                                  VARCHAR2(512)
 SUPPLEMENTAL_ATTRIBUTES                            VARCHAR2(512)
 SUPPLEMENTAL_DETAILS                               VARCHAR2(4000)
 PARTITION                                          NUMBER
 RECORD_ID                                          NUMBER
 
-- show alert.log entries for the last 24h
select originating_timestamp
     , indx
     , message_text
from   x$dbgalertext
where  originating_timestamp > (sysdate - 1);

-- show alert.log entries for the last hour
select originating_timestamp
     , indx
     , host_id
     , message_text
from   x$dbgalertext
where  originating_timestamp > (sysdate - 1/24);

-- show alert.log for a specific row
select *
from   x$dbgalertext
where  indx = 1243593;

-- search alert.log for ora- messages for last seven days
select originating_timestamp
     , indx
     , host_id
     , message_text
from   x$dbgalertext
where  regexp_like (message_text, '(ORA-)')
and    originating_timestamp > (sysdate - 7);

-- writing to alert.log
-- 1 = writing trace file
-- 2 = writing alert.log
-- 3 = writing both of them
exec dbms_system.ksdwrt(2, 'ORA-99999: Test message in alert log.');