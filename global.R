# 设置app标题-----

app_title <-'DMS数据中台V6.5';

# store data into rdbe in the rds database
app_id <- 'cpdms'
#upload all the library

#设置链接---

conn_cfg ='config/conn_cfg.R'

tstk::import(app_id = app_id)

token ='9B6F803F-9D37-41A2-BDA0-70A7179AF0F3'

dms_token = '9B6F803F-9D37-41A2-BDA0-70A7179AF0F3'

erp_token='4D181CAB-4CE3-47A3-8F2B-8AB11BB6A227'

config_file ='config/conn_erp.R'




# 加载R包-----

source('00_data.R',encoding = 'utf-8')













