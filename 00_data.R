# 设置app标题-----

app_title <-'DMS数据中台V5.0';

# store data into rdbe in the rds database
app_id <- 'cpdms'

#设置数据库链接---

conn_be <- conn_rds('rdbe')



#设置链接---
#conn <- conn_rds('cprds')
conn_cfg ='config/conn_cfg.R'

#加载表体UI
#这个地方使用到了动态评估，不是标准功能
tstk::debug_print('load_up start')
module_data <- tsui::module_getData(conn = conn_be,FappId = app_id)
sytem_id = module_data$sytem_id
module_id = module_data$module_id
module_body = paste0("load_ui0(module_id = '",module_id,"')",collapse = ",")

module_all = paste0("workAreaSetting <-shinydashboard::tabItems( ",module_body,")")
module_expr = tsdo::R_expr(module_all)
tsdo::R_exec(module_expr)
tstk::debug_print('load_up end')




