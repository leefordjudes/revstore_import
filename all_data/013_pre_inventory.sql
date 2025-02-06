CREATE TABLE TEMP_INV (
  ID int NOT NULL PRIMARY KEY,
  NAME TEXT,
  DIVISION_NAME TEXT,
  GST_TAX TEXT,
  CATEGORY1 TEXT,
  CATEGORY2 TEXT,
  CATEGORY3 TEXT,
  CATEGORY4 TEXT,
  BARCODE TEXT,
  HSN_CODE TEXT,
  MRP FLOAT, --PRODUCTMRP --PRICE_CONFIG_MRP
  S_RATE FLOAT,
  PUR_BILL_TYPE TEXT,
  PRICE_CONFIG_DISC1 FLOAT, --WSALEDISPER,
  PRICE_CONFIG_DISC2 FLOAT, --RETAILDISPER
  TAX_INCL INT, --INCLUDETAX
  COSTRATE FLOAT, --IF TAX_INCL FALSE THEN SET COSTRATE AS Pur.Rate,
  PRATE FLOAT, --IF TAX_INCL TRUE THEN SET PRATE AS Pur.Rate,
  PC_COST_MRP_MARKDOWN FLOAT, --MARKUPPER
  PC_COST_MRP_DISCOUNT FLOAT, --MARKDOWNPER
  PC_SRATE_LANDCOST_MARKUP FLOAT, --PMARGIN
  PC_SRATE_MRP_DISCOUNT FLOAT --MRPMARGINPER
);
--##
create or replace function fn_inventory_from_temp_inv()
returns trigger
language plpgsql
as
$$
declare
    inv inventory;
    br_id int := 1;
    br_name text := 'MainBranch';
    div_id int;
    cat1_id int;
    cat2_id int;
    cat3_id int;
    cat4_id int;
    unit_id int;
    gst_tax text := 'gst0';
    _fn_res bool;
    inv_items jsonb;
    input_data json;
    pur_conf json := '{"mrp_editable": true, "tax_editable": true, "free_editable": true, "disc_1_editable": true, "disc_2_editable": true, "p_rate_editable": true, "s_rate_editable": true}'::json;
    disc1 json;
    disc2 json;
    nlc_price_list json;
    s_rate_price_list json;
    pc_prate float;
    bcodes text[];
begin

    select id into div_id from division where name = coalesce(new.division_name,'DEFAULT');
    select id into cat1_id from category_option where name = new.category1 and category_id='INV_CAT1';
    select id into cat2_id from category_option where name = new.category2 and category_id='INV_CAT2';
    select id into cat3_id from category_option where name = new.category3 and category_id='INV_CAT3';
    select id into cat4_id from category_option where name = new.category4 and category_id='INV_CAT4';
    select id into unit_id from unit where name = 'PCS';
    if (new.gst_tax <> 'gst') then
        gst_tax = new.gst_tax;
    end if;
    if new.pur_bill_type='TYPE_B' then
      pur_conf = '{"mrp_editable": false, "tax_editable": false, "free_editable": false, "disc_1_editable": false, "disc_2_editable": false, "p_rate_editable": false, "s_rate_editable": false}'::json;
    elseif new.pur_bill_type='TYPE_C' then
      pur_conf = '{"mrp_editable": false, "tax_editable": false, "free_editable": false, "disc_1_editable": false, "disc_2_editable": true, "p_rate_editable": false, "s_rate_editable": false}'::json;
    end if;
    -- inventory insert
    begin
      if (char_length(new.name) > 0) then
          bcodes=ARRAY[new.id::text]::text[];
          if char_length(new.barcode::text) >0 then
              bcodes=(select array_agg(distinct n order by n) from unnest(ARRAY[new.id::text, new.barcode::text]::text[]) as t(n));
          end if;
          insert into inventory(name, division_id, gst_tax, unit_id, sale_unit_id, purchase_unit_id, allow_negative_stock, purchase_config,
                  barcodes,  hsn_code, category1, category2, category3, category4, created_by, updated_by, created_at, updated_at)
          values(new.name, div_id, gst_tax, unit_id, unit_id, unit_id, true, pur_conf, bcodes,
                (case when (new.hsn_code ~ '^[0-9]*$') and (char_length(new.hsn_code) between 1 and 10) then trim(new.hsn_code) end),
                (case when cat1_id is null then null else ARRAY[cat1_id]::int[] end),
                (case when cat2_id is null then null else ARRAY[cat2_id]::int[] end),
                (case when cat3_id is null then null else ARRAY[cat3_id]::int[] end),
                (case when cat4_id is null then null else ARRAY[cat4_id]::int[] end),
                1,1,current_timestamp,current_timestamp)
          returning * into inv;
          delete from temp_inv where id=new.id;
      end if;

    exception when others then
      raise exception 'insert into inventory(name, division_id, gst_tax, unit_id, sale_unit_id, purchase_unit_id, allow_negative_stock, purchase_config,
                       barcodes, hsn_code, category1, category2, category3, category4)
                       values(%,%,%,%,%,%,%,%,%,%,%,%,%,%);',new.name, div_id, new.gst_tax, unit_id,unit_id,unit_id,true, pur_conf,bcodes,
                        (case when (new.hsn_code ~ '^[0-9]*$') and (char_length(new.hsn_code) between 1 and 10) then trim(new.hsn_code) end),
                        (case when cat1_id is null then null else ARRAY[cat1_id]::int[] end),
                        (case when cat2_id is null then null else ARRAY[cat2_id]::int[] end),
                        (case when cat3_id is null then null else ARRAY[cat3_id]::int[] end),
                        (case when cat4_id is null then null else ARRAY[cat4_id]::int[] end);
    end;

    -- price config : inventory branch detail
    begin
      if inv.id is not null then
        if new.price_config_disc1 is not null then
            disc1 = json_build_object('mode','P', 'amount', new.price_config_disc1);
        end if;
        if new.price_config_disc2 is not null then
            disc2 = json_build_object('mode','P', 'amount', new.price_config_disc2);
        end if;
        if new.pc_cost_mrp_markdown is not null then  --PC_COST_MRP_MARKDOWN
            nlc_price_list = json_build_object('margin_type','MARK_DOWN_MRP', 'mode','P', 'amount',new.pc_cost_mrp_markdown, 'precision',4);
        end if;
        if new.pc_cost_mrp_discount is not null then  --PC_COST_MRP_DISCOUNT
            nlc_price_list = json_build_object('margin_type','DISCOUNT_MRP','mode','P', 'amount',new.pc_cost_mrp_discount, 'precision',4);
        end if;
        if new.pc_srate_landcost_markup is not null then -- PC_SRATE_LANDCOST_MARKUP
            s_rate_price_list = json_build_object('margin_type','MARK_UP_LANDING_COST','mode','P', 'amount',new.pc_srate_landcost_markup, 'precision',4);
        end if;
        if new.pc_srate_mrp_discount is not null then -- PC_SRATE_MRP_DISCOUNT
            s_rate_price_list = json_build_object('margin_type','DISCOUNT_MRP','mode','P', 'amount',new.pc_srate_mrp_discount, 'precision',4);
        end if;
        if new.tax_incl then
            pc_prate = (case when new.prate>0.0 then new.prate end);
        else
            pc_prate = (case when new.costrate>0.0 then new.costrate end);
        end if;

        INSERT INTO inventory_branch_detail(inventory_id,inventory_name, branch_id,branch_name, discount_1, discount_2,
        nlc_price_list, s_rate_price_list, mrp, s_rate, p_rate_tax_inc, p_rate,reorder_inventory_id, 
        created_by, updated_by, created_at, updated_at ) values
        (inv.id,inv.name, br_id,br_name, disc1, disc2, nlc_price_list, s_rate_price_list,
         case when new.mrp>0.0 then new.mrp end,
         case when new.s_rate>0.0 then new.s_rate end,
         case when new.tax_incl=1 then true else false end,
         pc_prate, inv.id, 1,1,current_timestamp,current_timestamp);
      end if;

    exception when others then
      raise exception 'INSERT INTO inventory_branch_detail(inventory_id, branch_id, discount_1, discount_2,
        nlc_price_list, s_rate_price_list, mrp, s_rate, p_rate_tax_inc, p_rate ) values
        (%,%,%,%,%,%,%,%,%,%);',inv.id, br_id, disc1, disc2, nlc_price_list, s_rate_price_list,
         case when new.mrp>0.0 then new.mrp end,
         case when new.s_rate>0.0 then new.s_rate end,
         case when new.tax_incl=1 then true else false end,
         pc_prate;
    end;

    return new;
end;
$$;
--##
create or replace trigger trig_inventory_from_temp_inv
after insert on temp_inv
for each row
execute procedure fn_inventory_from_temp_inv();
