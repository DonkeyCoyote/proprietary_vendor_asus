/*
  Copyright (c) 2022 Qualcomm Technologies, Inc.
  All Rights Reserved.
  Confidential and Proprietary - Qualcomm Technologies, Inc.
*/

INSERT OR REPLACE INTO qcril_properties_table (property, value) VALUES ('qcrildb_version', 90);

/* AU */
DELETE FROM qcril_emergency_source_mcc_table where MCC = '505' AND NUMBER = '000';
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('505','000','','');

/* BR */
DELETE FROM qcril_emergency_source_mcc_table where MCC = '724' AND NUMBER = '190';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '724' AND NUMBER = '192';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '724' AND NUMBER = '193';
DELETE FROM qcril_emergency_source_hard_mcc_table where MCC = '724' AND NUMBER = '192';
DELETE FROM qcril_emergency_source_hard_mcc_table where MCC = '724' AND NUMBER = '193';
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('724','190','','');
INSERT OR REPLACE INTO qcril_emergency_source_escv_nw_table VALUES('724', NULL, '190', 1);

/* CL */
DELETE FROM qcril_emergency_source_mcc_table where MCC = '730' AND NUMBER = '131';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '730' AND NUMBER = '132';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '730' AND NUMBER = '133';
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('730','131','','');
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('730','132','','');
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('730','133','','');
INSERT OR REPLACE INTO qcril_emergency_source_escv_nw_table VALUES('730', NULL, '131', 2);
INSERT OR REPLACE INTO qcril_emergency_source_escv_nw_table VALUES('730', NULL, '132', 4);
INSERT OR REPLACE INTO qcril_emergency_source_escv_nw_table VALUES('730', NULL, '133', 1);

/* CO */
DELETE FROM qcril_emergency_source_mcc_table where MCC = '732' AND NUMBER = '123';
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('732','123','','');
INSERT OR REPLACE INTO qcril_emergency_source_voice_table VALUES('732','123','','full');

/* CN */
DELETE FROM qcril_emergency_source_mcc_table where MCC = '460' AND NUMBER = '110';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '460' AND NUMBER = '119';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '460' AND NUMBER = '120';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '460' AND NUMBER = '122';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '460' AND NUMBER = '112';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '460' AND NUMBER = '999';
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('460','110','','');
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('460','119','','');
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('460','120','','');
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('460','122','','');
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('460','112','','');
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('460','999','','');

/* CX */
DELETE FROM qcril_emergency_source_mcc_table where MCC = '334' AND NUMBER = '060';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '334' AND NUMBER = '066';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '334' AND NUMBER = '074066';
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('334','060','','');
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('334','066','','');
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('334','074066','','');
INSERT OR REPLACE INTO qcril_emergency_source_voice_table VALUES('334','060','','full');
INSERT OR REPLACE INTO qcril_emergency_source_voice_table VALUES('334','066','','full');
INSERT OR REPLACE INTO qcril_emergency_source_voice_table VALUES('334','074066','','full');

/* FR */
DELETE FROM qcril_emergency_source_mcc_table where MCC = '208';
DELETE FROM qcril_emergency_source_mcc_mnc_table where MCC = '208';
DELETE FROM qcril_emergency_source_voice_mcc_mnc_table where MCC = '208';
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('208','112','','');
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('208','911','','');

/* HK */
DELETE FROM qcril_emergency_source_mcc_table where MCC = '454' AND NUMBER = '999';
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('454','999','','');

/* ID */
DELETE FROM qcril_emergency_source_mcc_table where MCC = '510' AND NUMBER = '110';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '510' AND NUMBER = '113';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '510' AND NUMBER = '119';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '510' AND NUMBER = '112';
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('510','110','','');
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('510','113','','');
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('510','119','','');
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('510','112','','');
INSERT OR REPLACE INTO qcril_emergency_source_voice_table VALUES('510','110','','full');
INSERT OR REPLACE INTO qcril_emergency_source_voice_table VALUES('510','113','','full');
INSERT OR REPLACE INTO qcril_emergency_source_voice_table VALUES('510','119','','full');
INSERT OR REPLACE INTO qcril_emergency_source_escv_nw_table VALUES('510', NULL, '110', 1);
INSERT OR REPLACE INTO qcril_emergency_source_escv_nw_table VALUES('510', NULL, '113', 4);
INSERT OR REPLACE INTO qcril_emergency_source_escv_nw_table VALUES('510', NULL, '119', 2);

/* IN */
DELETE FROM qcril_emergency_source_mcc_table where MCC = '404' AND NUMBER = '100';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '404' AND NUMBER = '101';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '404' AND NUMBER = '102';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '404' AND NUMBER = '108';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '404' AND NUMBER = '112';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '405' AND NUMBER = '100';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '405' AND NUMBER = '101';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '405' AND NUMBER = '102';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '405' AND NUMBER = '108';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '405' AND NUMBER = '112';
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('404','100','','');
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('404','101','','');
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('404','102','','');
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('404','108','','');
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('404','112','','');
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('405','100','','');
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('405','101','','');
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('405','102','','');
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('405','108','','');
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('405','112','','');
INSERT OR REPLACE INTO qcril_emergency_source_voice_table VALUES('404','100','','full');
INSERT OR REPLACE INTO qcril_emergency_source_voice_table VALUES('404','101','','full');
INSERT OR REPLACE INTO qcril_emergency_source_voice_table VALUES('404','102','','full');
INSERT OR REPLACE INTO qcril_emergency_source_voice_table VALUES('404','108','','full');
INSERT OR REPLACE INTO qcril_emergency_source_voice_table VALUES('405','100','','full');
INSERT OR REPLACE INTO qcril_emergency_source_voice_table VALUES('405','101','','full');
INSERT OR REPLACE INTO qcril_emergency_source_voice_table VALUES('405','102','','full');
INSERT OR REPLACE INTO qcril_emergency_source_voice_table VALUES('405','108','','full');
INSERT OR REPLACE INTO qcril_emergency_source_escv_nw_table VALUES('404', NULL, '100', 1);
INSERT OR REPLACE INTO qcril_emergency_source_escv_nw_table VALUES('404', NULL, '101', 4);
INSERT OR REPLACE INTO qcril_emergency_source_escv_nw_table VALUES('404', NULL, '102', 2);
INSERT OR REPLACE INTO qcril_emergency_source_escv_nw_table VALUES('404', NULL, '108', 2);
INSERT OR REPLACE INTO qcril_emergency_source_escv_nw_table VALUES('405', NULL, '100', 1);
INSERT OR REPLACE INTO qcril_emergency_source_escv_nw_table VALUES('405', NULL, '101', 4);
INSERT OR REPLACE INTO qcril_emergency_source_escv_nw_table VALUES('405', NULL, '102', 2);
INSERT OR REPLACE INTO qcril_emergency_source_escv_nw_table VALUES('405', NULL, '108', 2);

/* IT */
DELETE FROM qcril_emergency_source_mcc_table where MCC = '222' AND NUMBER = '08';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '222' AND NUMBER = '118';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '222' AND NUMBER = '119';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '222' AND NUMBER = '911';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '222' AND NUMBER = '999';
DELETE FROM qcril_emergency_source_hard_mcc_table where MCC = '222' AND NUMBER = '08';
DELETE FROM qcril_emergency_source_hard_mcc_table where MCC = '222' AND NUMBER = '118';
DELETE FROM qcril_emergency_source_hard_mcc_table where MCC = '222' AND NUMBER = '119';
DELETE FROM qcril_emergency_source_hard_mcc_table where MCC = '222' AND NUMBER = '911';
DELETE FROM qcril_emergency_source_hard_mcc_table where MCC = '222' AND NUMBER = '999';

/* KR */
DELETE FROM qcril_emergency_source_mcc_table where MCC = '450' AND NUMBER = '111';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '450' AND NUMBER = '113';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '450' AND NUMBER = '117';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '450' AND NUMBER = '118';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '450' AND NUMBER = '119';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '450' AND NUMBER = '122';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '450' AND NUMBER = '125';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '450' AND NUMBER = '112';
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('450','111','','');
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('450','113','','');
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('450','117','','');
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('450','118','','');
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('450','119','','');
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('450','122','','');
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('450','125','','');
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('450','112','','');
INSERT OR REPLACE INTO qcril_emergency_source_voice_table VALUES('450','111','','full');
INSERT OR REPLACE INTO qcril_emergency_source_voice_table VALUES('450','113','','full');
INSERT OR REPLACE INTO qcril_emergency_source_voice_table VALUES('450','117','','full');
INSERT OR REPLACE INTO qcril_emergency_source_voice_table VALUES('450','118','','full');
INSERT OR REPLACE INTO qcril_emergency_source_voice_table VALUES('450','119','','full');
INSERT OR REPLACE INTO qcril_emergency_source_voice_table VALUES('450','122','','full');
INSERT OR REPLACE INTO qcril_emergency_source_voice_table VALUES('450','125','','full');

/* JP */
DELETE FROM qcril_emergency_source_mcc_table where MCC = '440' AND NUMBER = '110';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '440' AND NUMBER = '118';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '440' AND NUMBER = '119';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '441' AND NUMBER = '110';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '441' AND NUMBER = '118';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '441' AND NUMBER = '119';
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('440','110','','');
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('440','118','','');
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('440','119','','');
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('441','110','','');
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('441','118','','');
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('441','119','','');
INSERT OR REPLACE INTO qcril_emergency_source_escv_nw_table VALUES('440', NULL, '110', 1);
INSERT OR REPLACE INTO qcril_emergency_source_escv_nw_table VALUES('440', NULL, '118', 8);
INSERT OR REPLACE INTO qcril_emergency_source_escv_nw_table VALUES('440', NULL, '119', 6);
INSERT OR REPLACE INTO qcril_emergency_source_escv_nw_table VALUES('441', NULL, '110', 1);
INSERT OR REPLACE INTO qcril_emergency_source_escv_nw_table VALUES('441', NULL, '118', 8);
INSERT OR REPLACE INTO qcril_emergency_source_escv_nw_table VALUES('441', NULL, '119', 6);

/* MY */
DELETE FROM qcril_emergency_source_mcc_table where MCC = '502' AND NUMBER = '112';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '502' AND NUMBER = '911';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '502' AND NUMBER = '991';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '502' AND NUMBER = '994';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '502' AND NUMBER = '999';
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('502','112','','');
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('502','911','','');
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('502','991','','');
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('502','994','','');
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('502','999','','');

/* NZ */
DELETE FROM qcril_emergency_source_mcc_table where MCC = '530' AND NUMBER = '111';
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('530','111','','');

/* PH */
DELETE FROM qcril_emergency_source_mcc_table where MCC = '515' AND NUMBER = '117';
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('515','117','','');

/* RU */
DELETE FROM qcril_emergency_source_mcc_table where MCC = '250' AND NUMBER = '101';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '250' AND NUMBER = '102';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '250' AND NUMBER = '103';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '250' AND NUMBER = '104';
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('250','101','','');
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('250','102','','');
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('250','103','','');
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('250','104','','');
INSERT OR REPLACE INTO qcril_emergency_source_voice_table VALUES('250','101','','full');
INSERT OR REPLACE INTO qcril_emergency_source_voice_table VALUES('250','102','','full');
INSERT OR REPLACE INTO qcril_emergency_source_voice_table VALUES('250','103','','full');
INSERT OR REPLACE INTO qcril_emergency_source_voice_table VALUES('250','104','','full');

/* SG */
DELETE FROM qcril_emergency_source_mcc_table where MCC = '525' AND NUMBER = '999';
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('525','999','','');

/* TH */
DELETE FROM qcril_emergency_source_mcc_table where MCC = '520' AND NUMBER = '191';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '520' AND NUMBER = '199';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '520' AND NUMBER = '1669';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '520' AND NUMBER = '112';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '520' AND NUMBER = '911';
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('520','191','','');
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('520','199','','');
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('520','1669','','');
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('520','112','','');
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('520','911','','');
INSERT OR REPLACE INTO qcril_emergency_source_voice_table VALUES('520','191','','full');
INSERT OR REPLACE INTO qcril_emergency_source_voice_table VALUES('520','199','','full');
INSERT OR REPLACE INTO qcril_emergency_source_voice_table VALUES('520','1669','','full');
INSERT OR REPLACE INTO qcril_emergency_source_escv_nw_table VALUES('520', NULL, '191', 1);
INSERT OR REPLACE INTO qcril_emergency_source_escv_nw_table VALUES('520', NULL, '199', 4);
INSERT OR REPLACE INTO qcril_emergency_source_escv_nw_table VALUES('520', NULL, '1669', 2);

/* TR */
DELETE FROM qcril_emergency_source_mcc_table where MCC = '286' AND NUMBER = '110';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '286' AND NUMBER = '122';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '286' AND NUMBER = '155';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '286' AND NUMBER = '156';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '286' AND NUMBER = '158';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '286' AND NUMBER = '177';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '286' AND NUMBER = '112';
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('286','110','','');
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('286','122','','');
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('286','155','','');
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('286','156','','');
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('286','158','','');
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('286','177','','');
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('286','112','','');
INSERT OR REPLACE INTO qcril_emergency_source_voice_table VALUES('286','110','','full');
INSERT OR REPLACE INTO qcril_emergency_source_voice_table VALUES('286','122','','full');
INSERT OR REPLACE INTO qcril_emergency_source_voice_table VALUES('286','155','','full');
INSERT OR REPLACE INTO qcril_emergency_source_voice_table VALUES('286','156','','full');
INSERT OR REPLACE INTO qcril_emergency_source_voice_table VALUES('286','158','','full');
INSERT OR REPLACE INTO qcril_emergency_source_voice_table VALUES('286','177','','full');
INSERT OR REPLACE INTO qcril_emergency_source_escv_nw_table VALUES('286', NULL, '110', 4);
INSERT OR REPLACE INTO qcril_emergency_source_escv_nw_table VALUES('286', NULL, '155', 1);

/* TW */
DELETE FROM qcril_emergency_source_mcc_table where MCC = '466' AND NUMBER = '110';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '466' AND NUMBER = '118';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '466' AND NUMBER = '119';
INSERT OR REPLACE INTO qcril_emergency_source_hard_mcc_table VALUES('466','111','','');
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('466','110','','');
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('466','118','','');
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('466','119','','');
INSERT OR REPLACE INTO qcril_emergency_source_voice_table VALUES('466','110','','full');
INSERT OR REPLACE INTO qcril_emergency_source_voice_table VALUES('466','118','','full');
INSERT OR REPLACE INTO qcril_emergency_source_voice_table VALUES('466','119','','full');
INSERT OR REPLACE INTO qcril_emergency_source_escv_nw_table VALUES('466', '01', '119', 4);
INSERT OR REPLACE INTO qcril_emergency_source_escv_nw_table VALUES('466', NULL, '110', 1);
INSERT OR REPLACE INTO qcril_emergency_source_escv_nw_table VALUES('466', NULL, '112', 4);
INSERT OR REPLACE INTO qcril_emergency_source_escv_nw_table VALUES('466', NULL, '118', 8);
INSERT OR REPLACE INTO qcril_emergency_source_escv_nw_table VALUES('466', NULL, '119', 6);

/* UK */
DELETE FROM qcril_emergency_source_mcc_table where MCC = '234' AND NUMBER = '999';
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('234','999','','');

/* VN */
DELETE FROM qcril_emergency_source_mcc_table where MCC = '452' AND NUMBER = '113';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '452' AND NUMBER = '114';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '452' AND NUMBER = '115';
DELETE FROM qcril_emergency_source_mcc_table where MCC = '452' AND NUMBER = '112';
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('452','113','','');
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('452','114','','');
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('452','115','','');
INSERT OR REPLACE INTO qcril_emergency_source_nw_table VALUES('452','112','','');
INSERT OR REPLACE INTO qcril_emergency_source_voice_table VALUES('452','113','','full');
INSERT OR REPLACE INTO qcril_emergency_source_voice_table VALUES('452','114','','full');
INSERT OR REPLACE INTO qcril_emergency_source_voice_table VALUES('452','115','','full');
INSERT OR REPLACE INTO qcril_emergency_source_escv_nw_table VALUES('452', NULL, '113', 1);
INSERT OR REPLACE INTO qcril_emergency_source_escv_nw_table VALUES('452', NULL, '114', 3);
INSERT OR REPLACE INTO qcril_emergency_source_escv_nw_table VALUES('452', NULL, '115', 2);
