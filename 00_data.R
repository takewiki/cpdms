

#加载表体UI
#这个地方使用到了动态评估，不是标准功能

module_data <- tsui::module_getData(FappId = app_id)

module_id = module_data$module_id

module_body = paste0("load_ui0(module_id = '",module_id,"')",collapse = ",")

module_all = paste0("workAreaSetting <-shinydashboard::tabItems( ",module_body,")")

module_expr = tsdo::R_expr(module_all)

tsdo::R_exec(module_expr)




