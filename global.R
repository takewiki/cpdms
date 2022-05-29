# 设置app标题-----

app_title <-'DMS数据中台V5.3';

# store data into rdbe in the rds database
app_id <- 'cpdms'
#upload all the library

#设置链接---

conn_cfg ='config/conn_cfg.R'

tstk::import(app_id = app_id)

token ='9B6F803F-9D37-41A2-BDA0-70A7179AF0F3'



# 加载R包-----

source('00_data.R',encoding = 'utf-8')













