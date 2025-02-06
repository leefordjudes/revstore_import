drop trigger if exists tg_sync_category_option on temp_acc;
--##
drop function if exists tgf_sync_category_option cascade;
--##
drop trigger if exists tg_sync_account on temp_acc;
--##
drop function if exists tgf_sync_account cascade;
--##
drop trigger if exists trig_account_from_temp_acc on temp_acc;
--##
drop function if exists fn_account_from_temp_acc cascade;
--##
drop procedure if exists restore_account_opening;
--##
drop table if exists TEMP_ACC;
--##
drop table if exists TEMP_ACC_OPENING_DATA;
--##