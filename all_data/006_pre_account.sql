CREATE TABLE IF NOT EXISTS TEMP_ACC (
  ID TEXT NOT NULL PRIMARY KEY,
  NAME TEXT,
  AGENT_ACCOUNT_NAME TEXT,
  CONTACT_TYPE TEXT,  
  ACCOUNT_TYPE_NAME TEXT,
  GST_REG_TYPE TEXT,
  GST_LOCATION_ID TEXT,
  GST_NO TEXT,
  PAN_NO TEXT,
  MOBILE TEXT,
  TELEPHONE TEXT,
  EMAIL TEXT,
  CONTACT_PERSON TEXT,
  ADDRESS TEXT,
  CITY TEXT,
  PINCODE TEXT,
  STATE_ID TEXT,
  COUNTRY_ID TEXT
);
--##
CREATE TABLE IF NOT EXISTS TEMP_ACC_OPENING_DATA
(
    ID           INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    ACNAME       TEXT,
    RECNO        TEXT,
    RECDATE      DATE,
    REFNO        TEXT,
    REFDATE      DATE,
    AMOUNT       FLOAT
);
--##
create or replace function fn_account_from_temp_acc()
returns trigger
language plpgsql
as
$$
declare
    cur_task text := '';
    ac_type_id int;
    ag_ac_id int;
    billwisedetail bool := false;
    transaction_enabled bool := false;
    duebasedon text;
    ex_ac_id int;
begin
    begin
    cur_task = format('getting account_type_id for account_type_name: %s',new.account_type_name);
    select id into ac_type_id
    from account_type
    where name=new.account_type_name or default_name=new.account_type_name
    or new.account_type_name=any(base_types)
    limit 1;

    cur_task = format('agent_account_name: %s',new.agent_account_name);
    if (new.agent_account_name is not null) and (length(trim(new.agent_account_name)) > 0) then
      select id into ag_ac_id from account where trim(name) like trim(new.agent_account_name);
      cur_task=format('agent account id: %s',ag_ac_id);
    end if;

    cur_task=format('checking contact type: %s',new.contact_type);
    if new.contact_type='CUSTOMER' and new.gst_reg_type is null and new.gst_location_id is null then
      new.gst_location_id='33';
      new.gst_reg_type='UNREGISTERED';
    end if;

    if new.contact_type='CUSTOMER' then
      ac_type_id=16;
    end if;

    if new.contact_type='VENDOR' and ac_type_id not in (1,2,19) then
      new.contact_type='ACCOUNT';
    end if;
    if new.contact_type='VENDOR' and new.gst_reg_type='REGULAR' and new.gst_no is null then
      new.gst_reg_type='UNREGISTERED';
      if new.gst_location_id is null then
        new.gst_location_id='33';
      end if;
    end if;
    if new.contact_type='VENDOR' and new.gst_reg_type is null then
      new.gst_reg_type='UNREGISTERED';
      new.gst_location_id='33';
    end if;
    if new.contact_type='VENDOR' and new.gst_reg_type='UNREGISTERED' and new.gst_location_id is null then
      new.gst_location_id='33';
    end if;

    if new.contact_type='AGENT' and ac_type_id in (1,2,19) then
      if new.gst_reg_type is null then
        new.gst_reg_type='UNREGISTERED';
      end if;
      if new.gst_location_id is null then
        new.gst_location_id='33';
      end if;
    end if;
    if new.contact_type in ('VENDOR','AGENT') then
      ac_type_id=19;
    end if;

    if new.contact_type in ('VENDOR','AGENT') then
      transaction_enabled=true;
      billwisedetail=true;
      duebasedon='EFF_DATE';
    end if;

    select id into ex_ac_id from account where trim(name)=trim(new.name);
    cur_task = format('account type name: %s id: %s, ex_ac_id: %s',new.account_type_name, ac_type_id, ex_ac_id);
    if ac_type_id is not null and ex_ac_id is null then
      cur_task = format('ac_type_id: %s, check_gst_no - %s: %s',ac_type_id, new.gst_no, check_gst_no(new.gst_no));
      if check_gst_no(new.gst_no) then
          cur_task = format('gstno true, insert account id: %s', new.id);
          INSERT INTO account(NAME, ACCOUNT_TYPE_ID, AGENT_ID, CONTACT_TYPE, GST_REG_TYPE, GST_LOCATION_ID, GST_NO, PAN_NO,
          BILL_WISE_DETAIL, transaction_enabled, DUE_BASED_ON, MOBILE, TELEPHONE, EMAIL, CONTACT_PERSON, ADDRESS, CITY, PINCODE, STATE_ID, COUNTRY_ID) VALUES
          (trim(new.name), ac_type_id, ag_ac_id, new.contact_type, new.gst_reg_type, new.gst_location_id, new.gst_no, new.pan_no,
          billwisedetail, transaction_enabled, duebasedon, new.mobile, new.telephone, new.email, new.contact_person, new.address, new.city, new.pincode, new.state_id, new.country_id);
--           delete from temp_acc where id=new.id;
      else
          cur_task = format('gstno false, insert account id: %s', new.id);
          INSERT INTO account(NAME, ACCOUNT_TYPE_ID, AGENT_ID, CONTACT_TYPE, GST_REG_TYPE, GST_LOCATION_ID, PAN_NO,
          BILL_WISE_DETAIL, transaction_enabled, DUE_BASED_ON, MOBILE, TELEPHONE, EMAIL, CONTACT_PERSON, ADDRESS, CITY, PINCODE, STATE_ID, COUNTRY_ID) VALUES
          (trim(new.name), ac_type_id, ag_ac_id, new.contact_type, new.gst_reg_type, new.gst_location_id, new.pan_no,
          billwisedetail, transaction_enabled, duebasedon, new.mobile, new.telephone, new.email, new.contact_person, new.address, new.city, new.pincode, new.state_id, new.country_id);
      end if;
    end if;
    exception when others then
      raise exception 'task: %, data: %',cur_task, new;
    end;
    return new;
end;
$$;
--##
create or replace trigger trig_account_from_temp_acc
after insert on temp_acc
for each row
execute procedure fn_account_from_temp_acc();
--##
create or replace function get_acc_opening_data()
    returns setof json
as
$$
begin
    return query
        with s1 as (select acname,
                           amount,
                           json_build_object(
                                   'ref_type', 'NEW',
                                   'ref_no', refno,
                                   'eff_date', refdate,
                                   'amount', amount
                           ) as bill_allocations
                    from temp_acc_opening_data),
             s2 as (select acname,
                           sum(s1.amount)               as amt,
                           json_agg(s1.bill_allocations) as bill_allocations
                    from s1
                    group by s1.acname),
             s3 as (select --*
                        json_build_object('accountName',x.account_name, 'baseTypes',x.base_types, 'accountId', x.account_id, 'branchId', 1, 'billAllocations', x.bill_allocations,
                                             'debit', x.debit, 'credit', x.credit
                           ) as data
                    from (select a.id as account_id,
                                 a.name as account_name,
                                 a.base_account_types as base_types,
                                 s2.bill_allocations,
                                 round((case when s2.amt > 0 then s2.amt else 0 end))      as debit,
                                 round((case when s2.amt < 0 then abs(s2.amt) else 0 end)) as credit
                          from s2 left join account as a on trim(s2.acname) = trim(a.name)
                          WHERE (a.base_account_types && array ['SUNDRY_DEBTOR','SUNDRY_CREDITOR'])
                          ) x
                    where x.account_id is NOT null
                      and not (x.credit = 0 and x.debit = 0)
                    )
        select
                data
--             account_id, account_name, base_types
        from s3;
--         WHERE not (s3.base_types && array ['SUNDRY_DEBTOR','SUNDRY_CREDITOR']);

end;
$$ language plpgsql security definer;
--##