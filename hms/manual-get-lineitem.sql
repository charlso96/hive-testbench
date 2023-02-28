select p.PART_ID, sd.SD_ID, sd.CD_ID, ser.SERDE_ID, p.CREATE_TIME, 
p.LAST_ACCESS_TIME, sd.INPUT_FORMAT, sd.IS_COMPRESSED, sd.IS_STOREDASSUBDIRECTORIES, 
sd.LOCATION, sd.NUM_BUCKETS, sd.OUTPUT_FORMAT, ser.NAME, ser.SLIB, pp.PARAM_KEYS, pp.PARAM_VALUES, pk.PART_KEY_VALS,
sdp.PARAM_KEYS, sdp.PARAM_VALUES, sc.COLUMN_NAMES, sc.ORDERS, bc.BUCKET_COL_NAMES, skc.SKEWED_COL_NAMES, serp.PARAM_KEYS, 
serp.PARAM_VALUES
from PARTITIONS as p 
    inner join TBLS as t on p.TBL_ID = t.TBL_ID and t.TBL_NAME = 'lineitem' 
    inner join DBS as d on t.DB_ID = d.DB_ID and d.NAME = 'tpch_partitioned_orc_2' and d.CTLG_NAME ='hive'
    left outer join SDS as sd on p.SD_ID = sd.SD_ID 
    left outer join SERDES as ser on sd.SERDE_ID = ser.SERDE_ID 
    left outer join (select PART_ID, GROUP_CONCAT(PARAM_KEY) as PARAM_KEYS, GROUP_CONCAT(PARAM_VALUE) as PARAM_VALUES
                    from PARTITION_PARAMS
                    where PARAM_KEY is not null
                    group by PART_ID) as pp on p.PART_ID = pp.PART_ID
    left outer join (select PART_ID, GROUP_CONCAT(PART_KEY_VAL) as PART_KEY_VALS
                    from PARTITION_KEY_VALS
                    group by PART_ID) as pk on p.PART_ID = pk.PART_ID
    left outer join (select SD_ID, GROUP_CONCAT(PARAM_KEY) as PARAM_KEYS, GROUP_CONCAT(PARAM_VALUE) as PARAM_VALUES
                    from SD_PARAMS
                    where PARAM_KEY is not null
                    group by SD_ID) as sdp on sd.SD_ID = sdp.SD_ID
    left outer join (select SD_ID, GROUP_CONCAT(COLUMN_NAME) as COLUMN_NAMES, GROUP_CONCAT(SORT_COLS.ORDER) as ORDERS
                    from SORT_COLS
                    group by SD_ID) as sc on sd.SD_ID = sc.SD_ID
    left outer join (select SD_ID, GROUP_CONCAT(BUCKET_COL_NAME) as BUCKET_COL_NAMES
                    from BUCKETING_COLS
                    group by SD_ID) as bc on sd.SD_ID = bc.SD_ID
    left outer join (select SD_ID, GROUP_CONCAT(SKEWED_COL_NAME) as SKEWED_COL_NAMES
                    from SKEWED_COL_NAMES
                    group by SD_ID) as skc on sd.SD_ID = skc.SD_ID
    left outer join (select SERDE_ID, GROUP_CONCAT(PARAM_KEY) as PARAM_KEYS, GROUP_CONCAT(PARAM_VALUE) as PARAM_VALUES
                    from SERDE_PARAMS
                    where PARAM_KEY is not null
                    group by SERDE_ID) as serp on ser.SERDE_ID = serp.SERDE_ID;