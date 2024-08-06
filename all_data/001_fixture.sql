-- INSERT INTO account(name, account_type_id, contact_type, alias_name, bill_wise_detail, due_based_on)
-- VALUES ('MainBranchAccount', 20, N'ACCOUNT', 'MBAc', false, 'EFF_DATE'); --101
--##
insert into account(name, account_type_id, contact_type) 
values ('CUSTOMER ADVANCES', 2, 'ACCOUNT'); --102
--##
insert into account(name, account_type_id, contact_type) 
values ('Exchange Return', 2, 'ACCOUNT'); --103
--##
insert into account(name, account_type_id, contact_type) 
values ('PersonalUse Expenses', 6, 'ACCOUNT'); --104
--##
INSERT INTO account (name, account_type_id, contact_type) 
VALUES ('BAJAJ EMI', 16, 'ACCOUNT'); --105
--##
INSERT INTO gst_registration(reg_type, gst_no, state_id)
VALUES ('REGULAR','33AAICR8359N1ZN','33');
--##
INSERT INTO branch(name, telephone, address, city, pincode, voucher_no_prefix, account_id, gst_registration_id, members, state_id, country_id)
VALUES ('MainBranch','044-61234700', '118B, GNT Road, Padiyanallur, Redhills','Chennai','600052','MB',101,1,array[]::int[],'33','INDIA');
--##
INSERT INTO unit (name, uqc_id, symbol, precision)
VALUES ('PCS', 'PCS', 'PCS', 0);
--##
INSERT INTO division (name) VALUES
('DEFAULT'),('FURNITURES'),('VESSELS'),('SAREE'),('KIDS'),('LADIES'),('FOOTWEARS'),
('GENTS'),('GIFT AND TOYS'),('SUPERMARKET'),('ELECTRONICS'),('CANTEEN'),
('VEGETABLE AND FRUIT'),('SILK SAREE'),('SUITING &  SHIRTING'),('COSMETICS'),
('MOBILE&WATCHES'),('SMALL APPLIANCE'),('BIG APPLIANCE');
--##
INSERT INTO pos_counter (code, name, branch_id) VALUES ('FFC1', 'FFC1', 1);
--##
UPDATE category SET category='BRAND', active=true WHERE id = 'INV_CAT1';
--##
UPDATE category SET category='CATEGORY', active=true WHERE id = 'INV_CAT2';
--##
UPDATE category SET category='SUB CATEGORY', active=true WHERE id = 'INV_CAT3';
--##
UPDATE category SET category='SPL SUB CATEGORY', active=true WHERE id = 'INV_CAT4';
--##--print-template
INSERT INTO print_template (name, config, layout) VALUES ('revathiStoresSale110', null, 'SALE');
--##
INSERT INTO print_template (name, config, layout) VALUES ('revathiSale', null, 'SALE');
--##
INSERT INTO print_template (name, config, layout) VALUES ('purchaseExchange', null, 'PURCHASE');
--##
INSERT INTO print_template (name, config, layout) VALUES ('revathiStoresSaleReturn110', null, 'CREDIT_NOTE');
--##
INSERT INTO print_template (name, config, layout) VALUES ('goodsInwardNote', null, 'GOODS_INWARD_NOTE');
--##
INSERT INTO print_template (name, config, layout) VALUES ('revathiStoresGiftVoucher', null, 'GIFT_VOUCHER');
--##
INSERT INTO print_template (name, config, layout) VALUES ('customerAdvance', null, 'CUSTOMER_ADVANCE');
--##
INSERT INTO print_template (name, config, layout) VALUES ('Gift Voucher Coupon', '{"items": [{"top": 46.0, "left": 55.0, "type": "text", "right": null, "value": "Gift Voucher Name", "width": null, "bottom": null, "height": null, "isField": true, "fontSize": 12.0, "maxLines": null, "fontWeight": "bold", "decorations": [], "lineSpacing": null, "letterSpacing": null}, {"top": 53.0, "left": 55.0, "type": "text", "right": null, "value": "Amount", "width": null, "bottom": null, "height": null, "isField": true, "fontSize": 12.0, "maxLines": null, "fontWeight": "bold", "decorations": [], "lineSpacing": null, "letterSpacing": null}, {"top": 68.0, "left": 35.0, "type": "qrcode", "right": null, "value": "Barcode", "width": 35.0, "bottom": null, "height": 12.0, "isField": true, "isBarcode": true, "fontWeight": "normal"}, {"top": 53.0, "left": 147.0, "type": "text", "right": null, "value": "Issued Date", "width": null, "bottom": null, "height": null, "isField": true, "fontSize": 12.0, "maxLines": null, "fontWeight": "bold", "decorations": [], "lineSpacing": null, "letterSpacing": null}, {"top": 61.0, "left": 147.0, "type": "text", "right": null, "value": "Expiry Date", "width": null, "bottom": null, "height": null, "isField": true, "fontSize": 12.0, "maxLines": null, "fontWeight": "bold", "decorations": [], "lineSpacing": null, "letterSpacing": null}, {"top": 60.0, "left": 35.0, "type": "text", "right": null, "value": "Amount In Figures", "width": null, "bottom": null, "height": null, "isField": true, "fontSize": null, "maxLines": null, "fontWeight": "bold", "decorations": [], "lineSpacing": null, "letterSpacing": null}], "width": 210.0, "height": 100.0, "labelGap": 0.0, "labelWidth": 0.0, "noOfLabels": 1}', 'GIFT_VOUCHER_COUPON');
--##
INSERT INTO print_template (name, config, layout) VALUES ('purchaseExchange110', null, 'PURCHASE');
--##
INSERT INTO print_template (name, config, layout) VALUES ('Revathi Label 2', '{"items": [{"top": 11.0, "left": 7.0, "type": "qrcode", "right": null, "value": "Barcode", "width": 10.0, "bottom": null, "height": 10.0, "isField": true, "isBarcode": false, "fontWeight": "normal"}, {"top": 9.0, "left": 20.0, "mask": "", "type": "text", "right": null, "value": "Inventory Name", "width": 35.0, "bottom": null, "height": 20.0, "isField": true, "fontSize": 7.0, "maxLines": null, "fontWeight": "bold", "decorations": [], "lineSpacing": null, "letterSpacing": 0.3}, {"top": 16.0, "left": 20.0, "mask": "", "type": "text", "right": null, "value": "Rs.", "width": 20.0, "bottom": null, "height": 10.0, "isField": false, "fontSize": 9.0, "maxLines": null, "fontWeight": "bold", "decorations": [], "lineSpacing": null, "letterSpacing": null}, {"top": 15.0, "left": 24.0, "mask": "", "type": "text", "right": null, "value": "Rate", "width": 30.0, "bottom": null, "height": 10.0, "isField": true, "fontSize": 13.0, "maxLines": null, "fontWeight": "bold", "decorations": [], "lineSpacing": null, "letterSpacing": null}, {"top": 21.0, "left": 7.0, "mask": "", "type": "text", "right": null, "value": "Barcode", "width": 30.0, "bottom": null, "height": 10.0, "isField": true, "fontSize": 7.0, "maxLines": null, "fontWeight": "bold", "decorations": [], "lineSpacing": null, "letterSpacing": null}, {"top": 12.0, "left": 20.0, "mask": "", "type": "text", "right": null, "value": "Vendor Code", "width": null, "bottom": null, "height": null, "isField": true, "fontSize": 7.0, "maxLines": null, "fontWeight": "bold", "decorations": [], "lineSpacing": null, "letterSpacing": 0.3}, {"top": 12.0, "left": 28.0, "mask": "REVATHISTO", "type": "text", "right": null, "value": "Voucher Date", "width": null, "bottom": null, "height": null, "isField": true, "fontSize": 7.0, "maxLines": null, "fontWeight": "bold", "decorations": [], "lineSpacing": null, "letterSpacing": null}, {"top": 21.0, "left": 22.0, "mask": "", "type": "text", "right": null, "value": "Voucher Number", "width": null, "bottom": null, "height": null, "isField": true, "fontSize": 7.0, "maxLines": null, "fontWeight": "bold", "decorations": [], "lineSpacing": null, "letterSpacing": null}, {"top": 21.0, "left": 32.0, "mask": "", "type": "text", "right": null, "value": "Inward Serial Number", "width": null, "bottom": null, "height": null, "isField": true, "fontSize": 7.0, "maxLines": null, "fontWeight": "bold", "decorations": [], "lineSpacing": null, "letterSpacing": null}], "width": 105.0, "height": 25.0, "labelGap": 0.0, "fontFamily": "Antonio", "labelWidth": 50.0, "noOfLabels": 2}', 'BATCH');
--##
INSERT INTO print_template (name, config, layout) VALUES ('Revathi Label 3', '{"items": [{"top": 7.5, "left": 5.0, "mask": "", "type": "text", "right": null, "value": "Inventory Name", "width": 30.0, "bottom": null, "height": 10.0, "isField": true, "fontSize": 7.0, "maxLines": null, "fontWeight": "bold", "decorations": [], "lineSpacing": null, "letterSpacing": 0.3}, {"top": 12.0, "left": 5.0, "type": "qrcode", "right": null, "value": "Barcode", "width": 8.0, "bottom": null, "height": 8.0, "isField": true, "isBarcode": false, "fontWeight": "normal"}, {"top": 16.5, "left": 15.0, "mask": "", "type": "text", "right": null, "value": "Rs.", "width": 10.0, "bottom": null, "height": 10.0, "isField": false, "fontSize": 7.0, "maxLines": null, "fontWeight": "bold", "decorations": [], "lineSpacing": null, "letterSpacing": 0.3}, {"top": 16.0, "left": 19.0, "mask": "", "type": "text", "right": null, "value": "Rate", "width": 20.0, "bottom": null, "height": 10.0, "isField": true, "fontSize": 9.0, "maxLines": null, "fontWeight": "bold", "decorations": [], "lineSpacing": null, "letterSpacing": 0.3}, {"top": 20.5, "left": 5.0, "mask": "", "type": "text", "right": null, "value": "Barcode", "width": 10.0, "bottom": null, "height": 5.0, "isField": true, "fontSize": 6.0, "maxLines": null, "fontWeight": "normal", "decorations": [], "lineSpacing": null, "letterSpacing": null}, {"top": 12.0, "left": 15.0, "mask": "", "type": "text", "right": null, "value": "Vendor Code", "width": null, "bottom": null, "height": null, "isField": true, "fontSize": 6.0, "maxLines": null, "fontWeight": "bold", "decorations": [], "lineSpacing": null, "letterSpacing": 0.3}, {"top": 12.0, "left": 24.0, "mask": "REVATHISTO", "type": "text", "right": null, "value": "Voucher Date", "width": null, "bottom": null, "height": null, "isField": true, "fontSize": 6.0, "maxLines": null, "fontWeight": "bold", "decorations": [], "lineSpacing": null, "letterSpacing": 0.3}, {"top": 20.5, "left": 18.0, "mask": "", "type": "text", "right": null, "value": "Voucher Number", "width": null, "bottom": null, "height": null, "isField": true, "fontSize": 6.0, "maxLines": null, "fontWeight": "bold", "decorations": [], "lineSpacing": null, "letterSpacing": 0.3}, {"top": 20.5, "left": 27.0, "mask": "", "type": "text", "right": null, "value": "Inward Serial Number", "width": null, "bottom": null, "height": null, "isField": true, "fontSize": 6.0, "maxLines": null, "fontWeight": "bold", "decorations": [], "lineSpacing": null, "letterSpacing": 0.3}], "width": 105.0, "height": 25.0, "labelGap": 0.0, "fontFamily": "Antonio", "labelWidth": 33.0, "noOfLabels": 3}', 'BATCH');
--##
INSERT INTO print_template (name, config, layout) VALUES ('Revathi Label 1', '{"items": [{"top": 20.0, "left": 7.0, "type": "qrcode", "right": null, "value": "Barcode", "width": 20.0, "bottom": null, "height": 20.0, "isField": true, "isBarcode": false, "fontWeight": "normal"}, {"top": 20.0, "left": 30.0, "mask": "", "type": "text", "right": null, "value": "Inventory Name", "width": 60.0, "bottom": null, "height": 30.0, "isField": true, "fontSize": 11.0, "maxLines": 3, "fontWeight": "bold", "decorations": [], "lineSpacing": null, "letterSpacing": 0.3}, {"top": 40.0, "left": 7.0, "mask": "", "type": "text", "right": null, "value": "Barcode", "width": 30.0, "bottom": null, "height": 10.0, "isField": true, "fontSize": 10.0, "maxLines": null, "fontWeight": "bold", "decorations": [], "lineSpacing": null, "letterSpacing": null}, {"top": 30.0, "left": 38.0, "mask": "", "type": "text", "right": null, "value": "Rate", "width": 60.0, "bottom": null, "height": 30.0, "isField": true, "fontSize": 18.0, "maxLines": null, "fontWeight": "bold", "decorations": [], "lineSpacing": null, "letterSpacing": null}, {"top": 31.0, "left": 29.5, "mask": "", "type": "text", "right": null, "value": "Rs.", "width": 60.0, "bottom": null, "height": 30.0, "isField": false, "fontSize": 15.0, "maxLines": null, "fontWeight": "bold", "decorations": [], "lineSpacing": null, "letterSpacing": null}, {"top": 26.0, "left": 30.0, "mask": "", "type": "text", "right": null, "value": "Vendor Code", "width": null, "bottom": null, "height": null, "isField": true, "fontSize": 8.0, "maxLines": null, "fontWeight": "bold", "decorations": [], "lineSpacing": null, "letterSpacing": 0.3}, {"top": 26.0, "left": 42.0, "mask": "REVATHISTO", "type": "text", "right": null, "value": "Voucher Date", "width": null, "bottom": null, "height": null, "isField": true, "fontSize": 8.0, "maxLines": null, "fontWeight": "bold", "decorations": [], "lineSpacing": null, "letterSpacing": 0.3}, {"top": 40.0, "left": 32.0, "mask": "", "type": "text", "right": null, "value": "Voucher Number", "width": null, "bottom": null, "height": null, "isField": true, "fontSize": 10.0, "maxLines": null, "fontWeight": "bold", "decorations": [], "lineSpacing": null, "letterSpacing": 0.3}, {"top": 40.0, "left": 62.0, "mask": "", "type": "text", "right": null, "value": "Inward Serial Number", "width": null, "bottom": null, "height": null, "isField": true, "fontSize": 10.0, "maxLines": null, "fontWeight": "bold", "decorations": [], "lineSpacing": null, "letterSpacing": null}], "width": 105.0, "height": 45.0, "labelGap": 0.0, "fontFamily": "Antonio", "labelWidth": 100.0, "noOfLabels": 1}', 'BATCH');
--##
INSERT INTO print_template (name, config, layout) VALUES ('revathiStoresSale110Amount', null, 'SALE');
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
insert into voucher_type(name, base_type, config)
values('Old Exchange', 'PURCHASE', '{"purchase": {
"account": {"print_after_save": false, "default_print_template": null, "enable_single_entry_mode": false, "pos_counter_transaction_only": false}, 
"inventory": {"tax_hide": false, "enable_gin": false, "bill_format": "NORMAL", "prevent_loss": false, "enable_expiry": false, "s_rate_as_mrp": false, 
    "set_retail_qty": false, "barcode_enabled": false, "expiry_required": false, 
    "exchange_account": 103, 
    "print_after_save": true, "allow_new_ref_only": false, 
    "enable_bill_detail": false, "allow_credit_vendor": false, "is_exchange_voucher": true, "s_rate_mrp_required": false, "default_print_template": 9, 
    "set_focus_on_inventory": false, "enable_silent_print_mode": true, "enable_automatic_rounded_off": false}}}'::json);
--##
INSERT INTO voucher_type (name, base_type, config) 
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
    "freeze_sales_person_for_voucher": false}}}'::json);    
--##
INSERT INTO voucher_type (name,  base_type, config) 
VALUES ('Exchange Return', 'CREDIT_NOTE', '{"credit_note": {
"account": {"print_after_save": false, "default_print_template": null, "enable_single_entry_mode": false, "pos_counter_transaction_only": false}, 
"inventory": {"enable_exp": false, "tax_editable": false, "rate_editable": false, "set_retail_qty": false, "unit_editable": false, "barcode_enabled": false, 
"exchange_account": 103, 
"print_after_save": true, "discount_editable": false, "warehouse_enabled": false, "default_price_list": null, "enable_description": false, 
"enable_sales_person": false, "invoice_no_required": true, "is_exchange_voucher": true, "price_list_editable": false, "print_customer_copy": true, 
"allow_credit_customer": false, "allowed_bill_ref_types": [], "bill_discount_editable": false, "default_print_template": 4, "set_focus_on_inventory": false, 
"allowed_credit_accounts": null, "enable_silent_print_mode": true, "voucherwise_sales_person": false, "customer_form_quick_create": true, 
"prevent_non_sale_bill_items": false, "pos_counter_transaction_only": true, "freeze_sales_person_for_voucher": false}}}'::json);
--##--UNDER SUNDRY_CREDITOR(19)
INSERT INTO account_type(name, parent_id) values ('Trade Creditors',19);
--##
INSERT INTO account_type(name, parent_id) values ('Creditors for Expenses',19);
--##
INSERT INTO account_type(name, parent_id) values ('Creditors for Assets',19);
--##
INSERT INTO account_type(name, parent_id) values ('CREDITORS FOR CONSTRUCTIONS',19);
--##
INSERT INTO account_type(name, parent_id) values ('Other Creditors',19);
--##--UNDER INDIRECT_EXPENSE(7)
INSERT INTO account_type(name, parent_id) values ('TRANSFER EXPENSES',7);
--##
INSERT INTO account_type(name, parent_id) values ('Office and Administrative Expenses',7);
--##
INSERT INTO account_type(name, parent_id) values ('FINANCIAL EXPENSES',7);
--##
INSERT INTO account_type(name, parent_id) values ('Employee Benefit Expenses.',7);
--##
INSERT INTO account_type(name, parent_id) values ('Insurance Expenses',7);
--##
INSERT INTO account_type(name, parent_id) values ('Repairs & Maintenance',7);
--##
INSERT INTO account_type(name, parent_id) values ('Selling and distribution Expenses',7);
--##
INSERT INTO account_type(name, parent_id) values ('Electrical Charges',7);
--##
INSERT INTO account_type(name, parent_id) values ('LEGAL EXPENSES',7);
--##
INSERT INTO account_type(name, parent_id) values ('CONSTRUCTION EXPENSES',7);
--##--UNDER CURRENT_LIABILITY(2)
INSERT INTO account_type(name, parent_id) values ('STATUTORY REMITTANCE',2);
--##
INSERT INTO account_type(name, parent_id) values ('UNSECURED LOAN',2);
--##
INSERT INTO account_type(name, parent_id) values ('WORKING CAPITAL DEMAND LOAN',2);
--##
INSERT INTO account_type(name, parent_id) values ('advance from customers',2);
--##--UNDER FIXED_ASSET(9)
INSERT INTO account_type(name, parent_id) values ('PLANT AND MECHINERY',9);
--##
INSERT INTO account_type(name, parent_id) values ('FURNITURE & FITTINGS',9);
--##
INSERT INTO account_type(name, parent_id) values ('Electrical & Fittings',9);
--##
INSERT INTO account_type(name, parent_id) values ('Computers & Computer Accessories',9);
--##
INSERT INTO account_type(name, parent_id) values ('VEHICLES',9);
--##
INSERT INTO account_type(name, parent_id) values ('BUILDING',9);
--##
INSERT INTO account_type(name, parent_id) values ('STP',9);
--##
INSERT INTO account_type(name, parent_id) values ('118B, G.N.T. ROAD, BUILDING',9);
--##
INSERT INTO account_type(name, parent_id) values ('INTERIORS',9);
--##--UNDER CURRENT_ASSET(1)
INSERT INTO account_type(name, parent_id) values ('OTHER CURRENT ASSETS',1);
--##
INSERT INTO account_type(name, parent_id) values ('PRE-OPERATIVE EXPENSES',1);
--##
INSERT INTO account_type(name, parent_id) values ('SECURITY DEPOSIT FOR SUPPLIERS',1);
--##--UNDER DIRECT_EXPENSE(6)
INSERT INTO account_type(name, parent_id) values ('FREIGHT',6);
--##--UNDER CURRENT_LIABILITY(2)-MAIN GROUP NAME
INSERT INTO account_type(name, parent_id) values ('CAPITAL ACCOUNT',2);
--##
INSERT INTO account_type(name, parent_id) values ('SECURED LOANS',2);
--##
INSERT INTO account_type(name, parent_id) values ('LOANS (LIABILITIES)',2);
--##
INSERT INTO account_type(name, parent_id) values ('SHARE CAPITAL',2);
--##
INSERT INTO account_type(name, parent_id) values ('OUTSTANDING LIABILITIES',2);
--##--UNDER CURRENT_ASSET(1)-MAIN GROUP NAME
INSERT INTO account_type(name, parent_id) values ('DEPOSITS',1);
--##
INSERT INTO account_type(name, parent_id) values ('LOANS & ADVANCES',1);
--##
INSERT INTO account_type(name, parent_id) values ('PLANT & MACHINERY',1);
--##--UNDER INDIRECT_EXPENSE(7)-MAIN GROUP NAME
INSERT INTO account_type(name, parent_id) values ('SELLING & DISTRIBUTION EXPENSES',7);
