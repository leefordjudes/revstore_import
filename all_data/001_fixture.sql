create or replace function tgf_sync_account()
    returns trigger as
$$
begin
    select name, base_types into new.account_type_name, new.base_account_types from account_type as x where x.id = new.account_type_id;
    new.created_by = 1;
    new.updated_by = 1;
    new.created_at = current_timestamp;
    new.updated_at = current_timestamp;
    return new;
end;
$$ language plpgsql security definer;
--##
create trigger tg_sync_account
    before insert
    on account
    for each row
execute procedure tgf_sync_account();
--##
INSERT INTO account(name, account_type_id, account_type_name, contact_type, alias_name, bill_wise_detail, due_based_on)
VALUES ('MainBranchAccount', 20, 'Branch / Division', N'ACCOUNT', 'MBAc', false, 'EFF_DATE'); --101
--##
insert into account(name, account_type_id, account_type_name, contact_type) 
values ('CUSTOMER ADVANCES', 2, 'Current Liability', 'ACCOUNT'); --102
--##
insert into account(name, account_type_id, account_type_name, contact_type) 
values ('Exchange Return', 2, 'Current Liability', 'ACCOUNT'); --103
--##
insert into account(name, account_type_id, account_type_name, contact_type) 
values ('PersonalUse Expenses', 6, 'Direct Expense', 'ACCOUNT'); --104
--##
INSERT INTO account (name, account_type_id, account_type_name, contact_type) 
VALUES ('BAJAJ EMI', 25, 'Emi Account', 'ACCOUNT'); --105
--##
INSERT INTO gst_registration(reg_type, gst_no, state_id, created_by, updated_by, created_at, updated_at)
VALUES ('REGULAR','33AAICR8359N1ZN','33',1,1,current_timestamp,current_timestamp);
--##
INSERT INTO branch(name, telephone, address, city, pincode, voucher_no_prefix, account_id, gst_registration_id, members, state_id, country_id, created_by, updated_by, created_at, updated_at)
VALUES ('MainBranch','044-61234700', '118B, GNT Road, Padiyanallur, Redhills','Chennai','600052','MB',101,1,array[]::int[],'33','INDIA',1,1,current_timestamp,current_timestamp);
--##
INSERT INTO unit (name, uqc, symbol, precision, created_by, updated_by, created_at, updated_at)
VALUES ('PCS', 'PCS', 'PCS', 0,1,1,current_timestamp,current_timestamp);
--##
INSERT INTO division (name, created_by, updated_by, created_at, updated_at) VALUES
('DEFAULT',1,1,current_timestamp,current_timestamp),
('FURNITURES',1,1,current_timestamp,current_timestamp),
('VESSELS',1,1,current_timestamp,current_timestamp),
('SAREE',1,1,current_timestamp,current_timestamp),
('KIDS',1,1,current_timestamp,current_timestamp),
('LADIES',1,1,current_timestamp,current_timestamp),
('FOOTWEARS',1,1,current_timestamp,current_timestamp),
('GENTS',1,1,current_timestamp,current_timestamp),
('GIFT AND TOYS',1,1,current_timestamp,current_timestamp),
('SUPERMARKET',1,1,current_timestamp,current_timestamp),
('ELECTRONICS',1,1,current_timestamp,current_timestamp),
('CANTEEN',1,1,current_timestamp,current_timestamp),
('VEGETABLE AND FRUIT',1,1,current_timestamp,current_timestamp),
('SILK SAREE',1,1,current_timestamp,current_timestamp),
('SUITING &  SHIRTING',1,1,current_timestamp,current_timestamp),
('COSMETICS',1,1,current_timestamp,current_timestamp),
('MOBILE&WATCHES',1,1,current_timestamp,current_timestamp),
('SMALL APPLIANCE',1,1,current_timestamp,current_timestamp),
('BIG APPLIANCE',1,1,current_timestamp,current_timestamp);
--##
INSERT INTO pos_counter (code, name, branch_id, created_by, updated_by, created_at, updated_at) VALUES 
('FFC1', 'FFC1', 1,1,1,current_timestamp,current_timestamp);
--##
UPDATE category SET category='BRAND', active=true WHERE id = 'INV_CAT1';
--##
UPDATE category SET category='CATEGORY', active=true WHERE id = 'INV_CAT2';
--##
UPDATE category SET category='SUB CATEGORY', active=true WHERE id = 'INV_CAT3';
--##
UPDATE category SET category='SPL SUB CATEGORY', active=true WHERE id = 'INV_CAT4';
--##--print-template
INSERT INTO print_template (name, config, layout, created_by, updated_by, created_at, updated_at) VALUES 
('revathiStoresSale110', null, 'SALE',1,1,current_timestamp,current_timestamp),
('revathiSale', null, 'SALE',1,1,current_timestamp,current_timestamp),
('purchaseExchange', null, 'PURCHASE',1,1,current_timestamp,current_timestamp),
('revathiStoresSaleReturn110', null, 'CREDIT_NOTE',1,1,current_timestamp,current_timestamp),
('goodsInwardNote', null, 'GOODS_INWARD_NOTE',1,1,current_timestamp,current_timestamp),
('revathiStoresGiftVoucher', null, 'GIFT_VOUCHER',1,1,current_timestamp,current_timestamp),
('customerAdvance', null, 'CUSTOMER_ADVANCE',1,1,current_timestamp,current_timestamp),
('Gift Voucher Coupon', '{"items": [{"top": 46.0, "left": 55.0, "type": "text", "right": null, "value": "Gift Voucher Name", "width": null, "bottom": null, "height": null, "isField": true, "fontSize": 12.0, "maxLines": null, "fontWeight": "bold", "decorations": [], "lineSpacing": null, "letterSpacing": null}, {"top": 53.0, "left": 55.0, "type": "text", "right": null, "value": "Amount", "width": null, "bottom": null, "height": null, "isField": true, "fontSize": 12.0, "maxLines": null, "fontWeight": "bold", "decorations": [], "lineSpacing": null, "letterSpacing": null}, {"top": 68.0, "left": 35.0, "type": "qrcode", "right": null, "value": "Barcode", "width": 35.0, "bottom": null, "height": 12.0, "isField": true, "isBarcode": true, "fontWeight": "normal"}, {"top": 53.0, "left": 147.0, "type": "text", "right": null, "value": "Issued Date", "width": null, "bottom": null, "height": null, "isField": true, "fontSize": 12.0, "maxLines": null, "fontWeight": "bold", "decorations": [], "lineSpacing": null, "letterSpacing": null}, {"top": 61.0, "left": 147.0, "type": "text", "right": null, "value": "Expiry Date", "width": null, "bottom": null, "height": null, "isField": true, "fontSize": 12.0, "maxLines": null, "fontWeight": "bold", "decorations": [], "lineSpacing": null, "letterSpacing": null}, {"top": 60.0, "left": 35.0, "type": "text", "right": null, "value": "Amount In Figures", "width": null, "bottom": null, "height": null, "isField": true, "fontSize": null, "maxLines": null, "fontWeight": "bold", "decorations": [], "lineSpacing": null, "letterSpacing": null}], "width": 210.0, "height": 100.0, "labelGap": 0.0, "labelWidth": 0.0, "noOfLabels": 1}', 'GIFT_VOUCHER_COUPON',1,1,current_timestamp,current_timestamp),
('purchaseExchange110', null, 'PURCHASE',1,1,current_timestamp,current_timestamp),
('Revathi Label 2', '{"items": [{"top": 11.0, "left": 7.0, "type": "qrcode", "right": null, "value": "Barcode", "width": 10.0, "bottom": null, "height": 10.0, "isField": true, "isBarcode": false, "fontWeight": "normal"}, {"top": 9.0, "left": 20.0, "mask": "", "type": "text", "right": null, "value": "Inventory Name", "width": 35.0, "bottom": null, "height": 20.0, "isField": true, "fontSize": 7.0, "maxLines": null, "fontWeight": "bold", "decorations": [], "lineSpacing": null, "letterSpacing": 0.3}, {"top": 16.0, "left": 20.0, "mask": "", "type": "text", "right": null, "value": "Rs.", "width": 20.0, "bottom": null, "height": 10.0, "isField": false, "fontSize": 9.0, "maxLines": null, "fontWeight": "bold", "decorations": [], "lineSpacing": null, "letterSpacing": null}, {"top": 15.0, "left": 24.0, "mask": "", "type": "text", "right": null, "value": "Rate", "width": 30.0, "bottom": null, "height": 10.0, "isField": true, "fontSize": 13.0, "maxLines": null, "fontWeight": "bold", "decorations": [], "lineSpacing": null, "letterSpacing": null}, {"top": 21.0, "left": 7.0, "mask": "", "type": "text", "right": null, "value": "Barcode", "width": 30.0, "bottom": null, "height": 10.0, "isField": true, "fontSize": 7.0, "maxLines": null, "fontWeight": "bold", "decorations": [], "lineSpacing": null, "letterSpacing": null}, {"top": 12.0, "left": 20.0, "mask": "", "type": "text", "right": null, "value": "Vendor Code", "width": null, "bottom": null, "height": null, "isField": true, "fontSize": 7.0, "maxLines": null, "fontWeight": "bold", "decorations": [], "lineSpacing": null, "letterSpacing": 0.3}, {"top": 12.0, "left": 28.0, "mask": "REVATHISTO", "type": "text", "right": null, "value": "Voucher Date", "width": null, "bottom": null, "height": null, "isField": true, "fontSize": 7.0, "maxLines": null, "fontWeight": "bold", "decorations": [], "lineSpacing": null, "letterSpacing": null}, {"top": 21.0, "left": 22.0, "mask": "", "type": "text", "right": null, "value": "Voucher Number", "width": null, "bottom": null, "height": null, "isField": true, "fontSize": 7.0, "maxLines": null, "fontWeight": "bold", "decorations": [], "lineSpacing": null, "letterSpacing": null}, {"top": 21.0, "left": 32.0, "mask": "", "type": "text", "right": null, "value": "Inward Serial Number", "width": null, "bottom": null, "height": null, "isField": true, "fontSize": 7.0, "maxLines": null, "fontWeight": "bold", "decorations": [], "lineSpacing": null, "letterSpacing": null}], "width": 105.0, "height": 25.0, "labelGap": 0.0, "fontFamily": "Antonio", "labelWidth": 50.0, "noOfLabels": 2}', 'BATCH',1,1,current_timestamp,current_timestamp),
('Revathi Label 3', '{"items": [{"top": 7.5, "left": 5.0, "mask": "", "type": "text", "right": null, "value": "Inventory Name", "width": 30.0, "bottom": null, "height": 10.0, "isField": true, "fontSize": 7.0, "maxLines": null, "fontWeight": "bold", "decorations": [], "lineSpacing": null, "letterSpacing": 0.3}, {"top": 12.0, "left": 5.0, "type": "qrcode", "right": null, "value": "Barcode", "width": 8.0, "bottom": null, "height": 8.0, "isField": true, "isBarcode": false, "fontWeight": "normal"}, {"top": 16.5, "left": 15.0, "mask": "", "type": "text", "right": null, "value": "Rs.", "width": 10.0, "bottom": null, "height": 10.0, "isField": false, "fontSize": 7.0, "maxLines": null, "fontWeight": "bold", "decorations": [], "lineSpacing": null, "letterSpacing": 0.3}, {"top": 16.0, "left": 19.0, "mask": "", "type": "text", "right": null, "value": "Rate", "width": 20.0, "bottom": null, "height": 10.0, "isField": true, "fontSize": 9.0, "maxLines": null, "fontWeight": "bold", "decorations": [], "lineSpacing": null, "letterSpacing": 0.3}, {"top": 20.5, "left": 5.0, "mask": "", "type": "text", "right": null, "value": "Barcode", "width": 10.0, "bottom": null, "height": 5.0, "isField": true, "fontSize": 6.0, "maxLines": null, "fontWeight": "normal", "decorations": [], "lineSpacing": null, "letterSpacing": null}, {"top": 12.0, "left": 15.0, "mask": "", "type": "text", "right": null, "value": "Vendor Code", "width": null, "bottom": null, "height": null, "isField": true, "fontSize": 6.0, "maxLines": null, "fontWeight": "bold", "decorations": [], "lineSpacing": null, "letterSpacing": 0.3}, {"top": 12.0, "left": 24.0, "mask": "REVATHISTO", "type": "text", "right": null, "value": "Voucher Date", "width": null, "bottom": null, "height": null, "isField": true, "fontSize": 6.0, "maxLines": null, "fontWeight": "bold", "decorations": [], "lineSpacing": null, "letterSpacing": 0.3}, {"top": 20.5, "left": 18.0, "mask": "", "type": "text", "right": null, "value": "Voucher Number", "width": null, "bottom": null, "height": null, "isField": true, "fontSize": 6.0, "maxLines": null, "fontWeight": "bold", "decorations": [], "lineSpacing": null, "letterSpacing": 0.3}, {"top": 20.5, "left": 27.0, "mask": "", "type": "text", "right": null, "value": "Inward Serial Number", "width": null, "bottom": null, "height": null, "isField": true, "fontSize": 6.0, "maxLines": null, "fontWeight": "bold", "decorations": [], "lineSpacing": null, "letterSpacing": 0.3}], "width": 105.0, "height": 25.0, "labelGap": 0.0, "fontFamily": "Antonio", "labelWidth": 33.0, "noOfLabels": 3}', 'BATCH',1,1,current_timestamp,current_timestamp),
('Revathi Label 1', '{"items": [{"top": 20.0, "left": 7.0, "type": "qrcode", "right": null, "value": "Barcode", "width": 20.0, "bottom": null, "height": 20.0, "isField": true, "isBarcode": false, "fontWeight": "normal"}, {"top": 20.0, "left": 30.0, "mask": "", "type": "text", "right": null, "value": "Inventory Name", "width": 60.0, "bottom": null, "height": 30.0, "isField": true, "fontSize": 11.0, "maxLines": 3, "fontWeight": "bold", "decorations": [], "lineSpacing": null, "letterSpacing": 0.3}, {"top": 40.0, "left": 7.0, "mask": "", "type": "text", "right": null, "value": "Barcode", "width": 30.0, "bottom": null, "height": 10.0, "isField": true, "fontSize": 10.0, "maxLines": null, "fontWeight": "bold", "decorations": [], "lineSpacing": null, "letterSpacing": null}, {"top": 30.0, "left": 38.0, "mask": "", "type": "text", "right": null, "value": "Rate", "width": 60.0, "bottom": null, "height": 30.0, "isField": true, "fontSize": 18.0, "maxLines": null, "fontWeight": "bold", "decorations": [], "lineSpacing": null, "letterSpacing": null}, {"top": 31.0, "left": 29.5, "mask": "", "type": "text", "right": null, "value": "Rs.", "width": 60.0, "bottom": null, "height": 30.0, "isField": false, "fontSize": 15.0, "maxLines": null, "fontWeight": "bold", "decorations": [], "lineSpacing": null, "letterSpacing": null}, {"top": 26.0, "left": 30.0, "mask": "", "type": "text", "right": null, "value": "Vendor Code", "width": null, "bottom": null, "height": null, "isField": true, "fontSize": 8.0, "maxLines": null, "fontWeight": "bold", "decorations": [], "lineSpacing": null, "letterSpacing": 0.3}, {"top": 26.0, "left": 42.0, "mask": "REVATHISTO", "type": "text", "right": null, "value": "Voucher Date", "width": null, "bottom": null, "height": null, "isField": true, "fontSize": 8.0, "maxLines": null, "fontWeight": "bold", "decorations": [], "lineSpacing": null, "letterSpacing": 0.3}, {"top": 40.0, "left": 32.0, "mask": "", "type": "text", "right": null, "value": "Voucher Number", "width": null, "bottom": null, "height": null, "isField": true, "fontSize": 10.0, "maxLines": null, "fontWeight": "bold", "decorations": [], "lineSpacing": null, "letterSpacing": 0.3}, {"top": 40.0, "left": 62.0, "mask": "", "type": "text", "right": null, "value": "Inward Serial Number", "width": null, "bottom": null, "height": null, "isField": true, "fontSize": 10.0, "maxLines": null, "fontWeight": "bold", "decorations": [], "lineSpacing": null, "letterSpacing": null}], "width": 105.0, "height": 45.0, "labelGap": 0.0, "fontFamily": "Antonio", "labelWidth": 100.0, "noOfLabels": 1}', 'BATCH',1,1,current_timestamp,current_timestamp),
('revathiStoresSale110Amount', null, 'SALE',1,1,current_timestamp,current_timestamp),
('deliveryReceipt110', null, 'DELIVERY_RECEIPT',1,1,current_timestamp,current_timestamp),
('shipmentA5', null, 'SHIPMENT',1,1,current_timestamp,current_timestamp);
--##--voucher_type
update voucher_type 
set config='{"gift_voucher": { "print_after_save": true, "gift_voucher_account": 15, "coupon_print_template": 8, "voucher_print_template": 6, "enable_silent_print_mode": true }}'::json
where id=18; --name='Gift Voucher'
--##
update voucher_type 
set config='{"personal_use_purchase": {"set_retail_qty": false, "expense_account": 104, "set_focus_on_inventory": true}}'::json
where id=19; --name='Purchased Goods For Personal Use'
--##
update voucher_type
set config='{"customer_advance": {"advance_account": 102, "print_after_save": true, "default_print_template": 7, "enable_silent_print_mode": true}}'::json
where id=20; --name='Customer Advance'
--##
insert into voucher_type(name, base_type, config, created_by, updated_by, created_at, updated_at)
values('Old Exchange', 'PURCHASE', '{"purchase": {
"account": {"print_after_save": false, "default_print_template": null, "enable_single_entry_mode": false, "pos_counter_transaction_only": false}, 
"inventory": {"tax_hide": false, "enable_gin": false, "bill_format": "NORMAL", "prevent_loss": false, "enable_expiry": false, "s_rate_as_mrp": false, 
    "set_retail_qty": false, "barcode_enabled": false, "expiry_required": false, 
    "exchange_account": 103, 
    "print_after_save": true, "allow_new_ref_only": false, 
    "enable_bill_detail": false, "allow_credit_vendor": false, "is_exchange_voucher": true, "s_rate_mrp_required": false, "default_print_template": 9, 
    "set_focus_on_inventory": false, "enable_silent_print_mode": true, "enable_automatic_rounded_off": false}}}'::json,
    1,1,current_timestamp,current_timestamp);
--##
INSERT INTO voucher_type (name, base_type, config, created_by, updated_by, created_at, updated_at) 
VALUES ('Sale Exchange', 'SALE', '{"sale": {
"common": {"enable_e_invoice": false}, 
"account": {"print_after_save": false, "default_print_template": null, "enable_single_entry_mode": false, "pos_counter_transaction_only": false}, 
"inventory": {"hide_rack": false, "enable_emi": true, 
    "emi_accounts": [105], 
    "tax_editable": false, "enable_doctor": false, "rate_editable": false, "set_retail_qty": false, 
    "unit_editable": false, "enable_advance": true, "barcode_enabled": false, "enable_exchange": true, 
    "set_default_qty": true, "print_after_save": true, "auto_select_batch": false, "discount_editable": false, 
    "warehouse_enabled": false, "default_price_list": null, "enable_description": true, "enable_sales_person": false, 
    "price_list_editable": false, "enable_reminder_days": false, "allow_credit_customer": false, 
    "counter_slip_template": 13, "allowed_bill_ref_types": [], "bill_discount_editable": false, 
    "default_print_template": 1, "set_focus_on_inventory": false, "allowed_credit_accounts": null, 
    "handling_charge_account": null, "hide_mrp_in_batch_modal": false, "enable_silent_print_mode": true, 
    "voucherwise_sales_person": false, "customer_form_quick_create": true, "pos_counter_transaction_only": true, 
    "freeze_sales_person_for_voucher": false}}}'::json,
    1,1,current_timestamp,current_timestamp);    
--##
INSERT INTO voucher_type (name,  base_type, config, created_by, updated_by, created_at, updated_at) 
VALUES ('Exchange Return', 'CREDIT_NOTE', '{"credit_note": {
"account": {"print_after_save": false, "default_print_template": null, "enable_single_entry_mode": false, "pos_counter_transaction_only": false}, 
"inventory": {"enable_exp": false, "tax_editable": false, "rate_editable": false, "set_retail_qty": false, "unit_editable": false, "barcode_enabled": false, 
"exchange_account": 103, 
"print_after_save": true, "discount_editable": false, "warehouse_enabled": false, "default_price_list": null, "enable_description": false, 
"enable_sales_person": false, "invoice_no_required": true, "is_exchange_voucher": true, "price_list_editable": false, "print_customer_copy": true, 
"allow_credit_customer": false, "allowed_bill_ref_types": [], "bill_discount_editable": false, "default_print_template": 4, "set_focus_on_inventory": false, 
"allowed_credit_accounts": null, "enable_silent_print_mode": true, "voucherwise_sales_person": false, "customer_form_quick_create": true, 
"prevent_non_sale_bill_items": false, "pos_counter_transaction_only": true, "freeze_sales_person_for_voucher": false}}}'::json,
1,1,current_timestamp,current_timestamp);
--##--UNDER SUNDRY_CREDITOR(19)
INSERT INTO account_type(name, parent_id, allow_account, allow_sub_type, base_types, created_by, updated_by, created_at, updated_at) values ('Trade Creditors',19,true, true, array ['CURRENT_LIABILITY', 'SUNDRY_CREDITOR'], 1,1,current_timestamp,current_timestamp);
--##
INSERT INTO account_type(name, parent_id,allow_account, allow_sub_type, base_types, created_by, updated_by, created_at, updated_at) values ('Creditors for Expenses',19,true, true, array ['CURRENT_LIABILITY', 'SUNDRY_CREDITOR'], 1,1,current_timestamp,current_timestamp);
--##
INSERT INTO account_type(name, parent_id,allow_account, allow_sub_type, base_types, created_by, updated_by, created_at, updated_at) values ('Creditors for Assets',19,true, true, array ['CURRENT_LIABILITY', 'SUNDRY_CREDITOR'], 1,1,current_timestamp,current_timestamp);
--##
INSERT INTO account_type(name, parent_id,allow_account, allow_sub_type, base_types, created_by, updated_by, created_at, updated_at) values ('CREDITORS FOR CONSTRUCTIONS',19,true, true, array ['CURRENT_LIABILITY', 'SUNDRY_CREDITOR'], 1,1,current_timestamp,current_timestamp);
--##
INSERT INTO account_type(name, parent_id,allow_account, allow_sub_type, base_types, created_by, updated_by, created_at, updated_at) values ('Other Creditors',19,true, true, array ['CURRENT_LIABILITY', 'SUNDRY_CREDITOR'], 1,1,current_timestamp,current_timestamp);
--##--UNDER INDIRECT_EXPENSE(7)
INSERT INTO account_type(name, parent_id,allow_account, allow_sub_type, base_types, created_by, updated_by, created_at, updated_at) values ('TRANSFER EXPENSES',7,true, true, array ['INDIRECT_EXPENSE'], 1,1,current_timestamp,current_timestamp);
--##
INSERT INTO account_type(name, parent_id,allow_account, allow_sub_type, base_types, created_by, updated_by, created_at, updated_at) values ('Office and Administrative Expenses',7,true, true, array ['INDIRECT_EXPENSE'], 1,1,current_timestamp,current_timestamp);
--##
INSERT INTO account_type(name, parent_id,allow_account, allow_sub_type, base_types, created_by, updated_by, created_at, updated_at) values ('FINANCIAL EXPENSES',7,true, true, array ['INDIRECT_EXPENSE'], 1,1,current_timestamp,current_timestamp);
--##
INSERT INTO account_type(name, parent_id,allow_account, allow_sub_type, base_types, created_by, updated_by, created_at, updated_at) values ('Employee Benefit Expenses.',7,true, true, array ['INDIRECT_EXPENSE'], 1,1,current_timestamp,current_timestamp);
--##
INSERT INTO account_type(name, parent_id,allow_account, allow_sub_type, base_types, created_by, updated_by, created_at, updated_at) values ('Insurance Expenses',7,true, true, array ['INDIRECT_EXPENSE'], 1,1,current_timestamp,current_timestamp);
--##
INSERT INTO account_type(name, parent_id,allow_account, allow_sub_type, base_types, created_by, updated_by, created_at, updated_at) values ('Repairs & Maintenance',7,true, true, array ['INDIRECT_EXPENSE'], 1,1,current_timestamp,current_timestamp);
--##
INSERT INTO account_type(name, parent_id,allow_account, allow_sub_type, base_types, created_by, updated_by, created_at, updated_at) values ('Selling and distribution Expenses',7,true, true, array ['INDIRECT_EXPENSE'], 1,1,current_timestamp,current_timestamp);
--##
INSERT INTO account_type(name, parent_id,allow_account, allow_sub_type, base_types, created_by, updated_by, created_at, updated_at) values ('Electrical Charges',7,true, true, array ['INDIRECT_EXPENSE'], 1,1,current_timestamp,current_timestamp);
--##
INSERT INTO account_type(name, parent_id,allow_account, allow_sub_type, base_types, created_by, updated_by, created_at, updated_at) values ('LEGAL EXPENSES',7,true, true, array ['INDIRECT_EXPENSE'], 1,1,current_timestamp,current_timestamp);
--##
INSERT INTO account_type(name, parent_id,allow_account, allow_sub_type, base_types, created_by, updated_by, created_at, updated_at) values ('CONSTRUCTION EXPENSES',7,true, true, array ['INDIRECT_EXPENSE'], 1,1,current_timestamp,current_timestamp);
--##--UNDER INDIRECT_EXPENSE(7)-MAIN GROUP NAME
INSERT INTO account_type(name, parent_id,allow_account, allow_sub_type, base_types, created_by, updated_by, created_at, updated_at) values ('SELLING & DISTRIBUTION EXPENSES',7,true, true, array ['INDIRECT_EXPENSE'], 1,1,current_timestamp,current_timestamp);
--##--UNDER CURRENT_LIABILITY(2)
INSERT INTO account_type(name, parent_id,allow_account, allow_sub_type, base_types, created_by, updated_by, created_at, updated_at) values ('STATUTORY REMITTANCE',2,true, true, array ['CURRENT_LIABILITY'], 1,1,current_timestamp,current_timestamp);
--##
INSERT INTO account_type(name, parent_id,allow_account, allow_sub_type, base_types, created_by, updated_by, created_at, updated_at) values ('UNSECURED LOAN',2,true, true, array ['CURRENT_LIABILITY'], 1,1,current_timestamp,current_timestamp);
--##
INSERT INTO account_type(name, parent_id,allow_account, allow_sub_type, base_types, created_by, updated_by, created_at, updated_at) values ('WORKING CAPITAL DEMAND LOAN',2,true, true, array ['CURRENT_LIABILITY'], 1,1,current_timestamp,current_timestamp);
--##
INSERT INTO account_type(name, parent_id,allow_account, allow_sub_type, base_types, created_by, updated_by, created_at, updated_at) values ('advance from customers',2,true, true, array ['CURRENT_LIABILITY'], 1,1,current_timestamp,current_timestamp);
--##--UNDER FIXED_ASSET(9)
INSERT INTO account_type(name, parent_id,allow_account, allow_sub_type, base_types, created_by, updated_by, created_at, updated_at) values ('PLANT AND MECHINERY',9,true, true, array ['FIXED_ASSET'], 1,1,current_timestamp,current_timestamp);
--##
INSERT INTO account_type(name, parent_id,allow_account, allow_sub_type, base_types, created_by, updated_by, created_at, updated_at) values ('FURNITURE & FITTINGS',9,true, true, array ['FIXED_ASSET'], 1,1,current_timestamp,current_timestamp);
--##
INSERT INTO account_type(name, parent_id,allow_account, allow_sub_type, base_types, created_by, updated_by, created_at, updated_at) values ('Electrical & Fittings',9,true, true, array ['FIXED_ASSET'], 1,1,current_timestamp,current_timestamp);
--##
INSERT INTO account_type(name, parent_id,allow_account, allow_sub_type, base_types, created_by, updated_by, created_at, updated_at) values ('Computers & Computer Accessories',9,true, true, array ['FIXED_ASSET'], 1,1,current_timestamp,current_timestamp);
--##
INSERT INTO account_type(name, parent_id,allow_account, allow_sub_type, base_types, created_by, updated_by, created_at, updated_at) values ('VEHICLES',9,true, true, array ['FIXED_ASSET'], 1,1,current_timestamp,current_timestamp);
--##
INSERT INTO account_type(name, parent_id,allow_account, allow_sub_type, base_types, created_by, updated_by, created_at, updated_at) values ('BUILDING',9,true, true, array ['FIXED_ASSET'], 1,1,current_timestamp,current_timestamp);
--##
INSERT INTO account_type(name, parent_id,allow_account, allow_sub_type, base_types, created_by, updated_by, created_at, updated_at) values ('STP',9,true, true, array ['FIXED_ASSET'], 1,1,current_timestamp,current_timestamp);
--##
INSERT INTO account_type(name, parent_id,allow_account, allow_sub_type, base_types, created_by, updated_by, created_at, updated_at) values ('118B, G.N.T. ROAD, BUILDING',9,true, true, array ['FIXED_ASSET'], 1,1,current_timestamp,current_timestamp);
--##
INSERT INTO account_type(name, parent_id,allow_account, allow_sub_type, base_types, created_by, updated_by, created_at, updated_at) values ('INTERIORS',9,true, true, array ['FIXED_ASSET'], 1,1,current_timestamp,current_timestamp);
--##--UNDER CURRENT_ASSET(1)
INSERT INTO account_type(name, parent_id,allow_account, allow_sub_type, base_types, created_by, updated_by, created_at, updated_at) values ('OTHER CURRENT ASSETS',1,true, true, array ['CURRENT_ASSET'], 1,1,current_timestamp,current_timestamp);
--##
INSERT INTO account_type(name, parent_id,allow_account, allow_sub_type, base_types, created_by, updated_by, created_at, updated_at) values ('PRE-OPERATIVE EXPENSES',1,true, true, array ['CURRENT_ASSET'], 1,1,current_timestamp,current_timestamp);
--##
INSERT INTO account_type(name, parent_id,allow_account, allow_sub_type, base_types, created_by, updated_by, created_at, updated_at) values ('SECURITY DEPOSIT FOR SUPPLIERS',1,true, true, array ['CURRENT_ASSET'], 1,1,current_timestamp,current_timestamp);
--##--UNDER DIRECT_EXPENSE(6)
INSERT INTO account_type(name, parent_id,allow_account, allow_sub_type, base_types, created_by, updated_by, created_at, updated_at) values ('FREIGHT',6,true, true, array ['DIRECT_EXPENSE'], 1,1,current_timestamp,current_timestamp);
--##--UNDER CURRENT_LIABILITY(2)-MAIN GROUP NAME
INSERT INTO account_type(name, parent_id,allow_account, allow_sub_type, base_types, created_by, updated_by, created_at, updated_at) values ('CAPITAL ACCOUNT',2,true, true, array ['CURRENT_LIABILITY'], 1,1,current_timestamp,current_timestamp);
--##
INSERT INTO account_type(name, parent_id,allow_account, allow_sub_type, base_types, created_by, updated_by, created_at, updated_at) values ('SECURED LOANS',2,true, true, array ['CURRENT_LIABILITY'], 1,1,current_timestamp,current_timestamp);
--##
INSERT INTO account_type(name, parent_id,allow_account, allow_sub_type, base_types, created_by, updated_by, created_at, updated_at) values ('LOANS (LIABILITIES)',2,true, true, array ['CURRENT_LIABILITY'], 1,1,current_timestamp,current_timestamp);
--##
INSERT INTO account_type(name, parent_id,allow_account, allow_sub_type, base_types, created_by, updated_by, created_at, updated_at) values ('SHARE CAPITAL',2,true, true, array ['CURRENT_LIABILITY'], 1,1,current_timestamp,current_timestamp);
--##
INSERT INTO account_type(name, parent_id,allow_account, allow_sub_type, base_types, created_by, updated_by, created_at, updated_at) values ('OUTSTANDING LIABILITIES',2,true, true, array ['CURRENT_LIABILITY'], 1,1,current_timestamp,current_timestamp);
--##--UNDER CURRENT_ASSET(1)-MAIN GROUP NAME
INSERT INTO account_type(name, parent_id,allow_account, allow_sub_type, base_types, created_by, updated_by, created_at, updated_at) values ('DEPOSITS',1,true, true, array ['CURRENT_ASSET'], 1,1,current_timestamp,current_timestamp);
--##
INSERT INTO account_type(name, parent_id,allow_account, allow_sub_type, base_types, created_by, updated_by, created_at, updated_at) values ('LOANS & ADVANCES',1,true, true, array ['CURRENT_ASSET'], 1,1,current_timestamp,current_timestamp);
--##
INSERT INTO account_type(name, parent_id,allow_account, allow_sub_type, base_types, created_by, updated_by, created_at, updated_at) values ('PLANT & MACHINERY',1,true, true, array ['CURRENT_ASSET'], 1,1,current_timestamp,current_timestamp);
--##
