create or replace procedure restore_account_opening()
as
$$
declare
    input_data json;
    _fn_res bool;
begin
    for input_data in (select x::json from get_acc_opening_data() x)
    loop
        begin
        select * into _fn_res from set_account_opening(input_data::json);
        exception when others then
          raise exception 'select * from set_account_opening(%);',input_data::json;
        end;
    end loop;
end;
$$ language plpgsql;
--##
call restore_account_opening();