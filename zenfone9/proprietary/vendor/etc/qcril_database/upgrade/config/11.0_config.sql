
/*
  Copyright (c) 2021 Qualcomm Technologies, Inc.
  All Rights Reserved.
  Confidential and Proprietary - Qualcomm Technologies, Inc.
*/

CREATE TABLE IF NOT EXISTS qcril_properties_table (property TEXT PRIMARY KEY NOT NULL, def_val TEXT, value TEXT);
INSERT OR REPLACE INTO qcril_properties_table(property, def_val) VALUES('qcrildb_version',11.0);
UPDATE qcril_properties_table SET def_val="" WHERE property="all_bc_msg";
UPDATE qcril_properties_table SET def_val="0" WHERE property="persist.vendor.radio.custom_ecc";
UPDATE qcril_properties_table SET def_val="1" WHERE property="persist.vendor.radio.cs_srv_type";
UPDATE qcril_properties_table SET def_val="0" WHERE property="persist.vendor.radio.poweron_opt";
UPDATE qcril_properties_table SET def_val="1" WHERE property="persist.vendor.radio.always_send_plmn";
UPDATE qcril_properties_table SET def_val="true" WHERE property="persist.vendor.radio.force_on_dc";
UPDATE qcril_properties_table SET def_val="1" WHERE property="persist.vendor.radio.add_power_save";
INSERT OR REPLACE INTO qcril_properties_table(property, def_val) VALUES("persist.vendor.radio.support_vonr_update", "false");
