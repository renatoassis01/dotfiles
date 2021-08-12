-- vim: ft=pgsql

-----------------------------------------
-- psql prompt settings for superuser  --
-- Author : Jesus Rafael Sanchez       --
-----------------------------------------

-- Mute psql
\set QUIET ON

-- Check if is superuser
select current_setting('is_superuser') is_superuser \gset

-- PROMPT1 and PROMPT2 Settings
\set PROMPT1 '\n%[%033[1;33m%]➤ %[%033[2;37m%]%`\! date "+%F %H:%M %p "` %[%033[0m%] %[%033[1;34m%]%n%[%033[0;31m%]@%[%033[1;34m%]%M:%>%[%033[1;33m%]/%/ %[%033[1;31m%]%x %[%033[K%]%[%033[0m%]\n%[%033[1;33m%]%R%#%[%033[0m%] '
\set PROMPT2 '%[%033[1;32m%]%R%#%[%033[0m%] '

-- Unmute psql
\set QUIET OFF

