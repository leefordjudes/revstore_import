--list 'CUSTOMER','VENDOR','AGENT' accounts that are not in 'SUNDRY_DEBTOR','SUNDRY_CREDITOR'
select id, name, contact_type, base_account_types, gst_reg_type, gst_no, gst_location_id
from account
where contact_type in ('CUSTOMER','VENDOR','AGENT')
and not (base_account_types && array ['SUNDRY_DEBTOR','SUNDRY_CREDITOR'])
order by gst_reg_type, gst_no, gst_location_id;
