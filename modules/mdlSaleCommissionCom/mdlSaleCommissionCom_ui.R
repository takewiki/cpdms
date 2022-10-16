tabItem(tabName = "mdlSaleCommissionCom",
                    fluidRow(
                      column(width = 12,
                             tabBox(title ="奖金提成工作台",width = 12,
                                    id='tabSet_mdlSaleCommissionCom',height = '300px',
                                    tabPanel('数据源1-同步销售订单',tagList(
                                      fluidRow(column(4,box(
                                        title = "操作区域", width = NULL, solidHeader = TRUE, status = "primary",
                                        tags$h4('销售订单是指所有已审核未发放提成的销售订单'),
                                        tsui::mdl_dateRange(id = 'sync_src_saleOrder_read',startDate = as.Date('2022-08-01'),endDate = as.Date('2022-08-31')),
                                        tsui::mdl_ListChoose1(id = 'sync_src_saleOrder_org',label = '选择公司',choiceNames = mdlSaleCommissionUI::organization_query(dms_token = dms_token),choiceValues = mdlSaleCommissionUI::organization_query(dms_token = dms_token),selected = '苏州赛普生物科技有限公司'),
                                        tsui::mdl_ListChoose1(id = 'sync_src_saleOrder_db',label = '数据中心选择',choiceNames = list('赛普集团旧账套2021.04.01-2022.07.31','赛普集团新账套2022.08.01-至令'),choiceValues =list(1,2),selected = 2 ),
                                        actionBttn(inputId = 'sync_src_saleOrder_click',label = '同步'),
                                        actionBttn(inputId = 'sync_src_saleOrder_view',label = '查看'),
                                        tsui::mdl_download_button(id = 'sync_src_saleOrder_dl',label = '下载')
                                      )),
                                      column(8, box(
                                        title = "报表区域", width = NULL, solidHeader = TRUE, status = "primary",
                                        div(style = 'overflow-x: scroll', mdl_dataTable('sync_src_saleOrder_dt','订单数据'))
                                      )
                                      ))
                                      
                                    )),
                                   
                                    tabPanel('数据源2-同步销售出库及销售退货',tagList(
                                      fluidRow(column(4,box(
                                        title = "操作区域", width = NULL, solidHeader = TRUE, status = "primary",
                                        tags$h4('销售出库是指所有已审核未发放提成的销售出库及销售退货单，其中销售退货数量及金额使用负数表示'),
                                        tags$h4('新规则以此作为记录依据'),
                                        tsui::mdl_dateRange(id = 'sync_src_saleOutStock_read',startDate = as.Date('2022-08-01'),endDate = as.Date('2022-08-31')),
                                        tsui::mdl_ListChoose1(id = 'sync_src_saleOutStock_org',label = '选择公司',choiceNames = mdlSaleCommissionUI::organization_query(dms_token = dms_token),choiceValues = mdlSaleCommissionUI::organization_query(dms_token = dms_token),selected = '苏州赛普生物科技有限公司'),
                                        tsui::mdl_ListChoose1(id = 'sync_src_saleOutStock_db',label = '数据中心选择',choiceNames = list('赛普集团旧账套2021.04.01-2022.07.31','赛普集团新账套2022.08.01-至令'),choiceValues =list(1,2),selected = 2 ),
                                        actionBttn(inputId = 'sync_src_saleOutStock_click',label = '同步'),
                                        actionBttn(inputId = 'sync_src_saleOutStock_view',label = '查看'),
                                        tsui::mdl_download_button(id = 'sync_src_saleOutStock_dl',label = '下载')
                                      )),
                                      column(8, box(
                                        title = "报表区域", width = NULL, solidHeader = TRUE, status = "primary",
                                        div(style = 'overflow-x: scroll', mdl_dataTable('sync_src_saleOutStock_dt','出库数据'))
                                      )
                                      ))
                                      
                                    )),
                                    
                                    tabPanel('数据源3-毛利计算',tagList(
                                      fluidRow(column(4,box(
                                        title = "操作区域", width = NULL, solidHeader = TRUE, status = "primary",
                                        tags$h4('按月针对销售出库匹配管理成本'),
                                        tsui::mdl_dateRange(id = 'sync_src_saleInvoice_read',startDate = as.Date('2022-08-01'),endDate = as.Date('2022-08-31')),
                                        tsui::mdl_ListChoose1(id = 'sync_src_saleInvoice_org',label = '选择公司',choiceNames = mdlSaleCommissionUI::organization_query(dms_token = dms_token),choiceValues = mdlSaleCommissionUI::organization_query(dms_token = dms_token),selected = '苏州赛普生物科技有限公司'),
                                        tsui::mdl_ListChoose1(id = 'sync_src_saleInvoice_db',label = '数据中心选择',choiceNames = list('赛普集团旧账套2021.04.01-2022.07.31','赛普集团新账套2022.08.01-至令'),choiceValues =list(1,2),selected = 2 ),
                                       actionBttn(inputId = 'sync_src_saleInvoice_view',label = '查看'),
                                        tsui::mdl_download_button(id = 'sync_src_saleInvoice_dl',label = '下载')
                                      )),
                                      column(8, box(
                                        title = "报表区域", width = NULL, solidHeader = TRUE, status = "primary",
                                        div(style = 'overflow-x: scroll', mdl_dataTable('sync_src_saleInvoice_dt','管理成本'))
                                      )
                                      ))
                                      
                                    )),
                                    
                                    tabPanel('规则4-奖金提成规则',tagList(
                                      fluidRow(column(4,box(
                                        title = "操作区域", width = NULL, solidHeader = TRUE, status = "primary",
                                        mdl_text('cp_pfm_rule_chooser',label = '请输入一个规则名称，不输入表示全部',value = ''),
                                        actionBttn(inputId = 'cp_pfm_rule_query',label = '查看明细'),br(),
                                        br(),
                                        hr(),
                                        mdl_text('cp_pfm_rule_new_FRuleName',label = '提成规则名称',value = ''),
                                        mdl_text('cp_pfm_rule_new_FParam_x',label = '提成系数x',value = ''),
                                        mdl_text('cp_pfm_rule_new_FParam_y',label = '止损系数y',value = ''),
                                        mdl_text('cp_pfm_rule_new_FParam_z',label = '类别系数z',value = ''),
                                        mdl_date('cp_pfm_rule_new_FStartDate',label = '生效日期',value =  as.Date('2021-04-01')),
                                        mdl_date('cp_pfm_rule_new_FEndDate',label = '失效日期',value =  as.Date('2100-12-31')),
                                        actionBttn(inputId = 'cp_pfm_rule_new',label = '新增明细'),br()
                                        
                                        
                                      )),
                                      column(8, box(
                                        title = "报表区域", width = NULL, solidHeader = TRUE, status = "primary",
                                        
                                        div(style = 'overflow-x: scroll', mdl_dataTable('cp_pfm_rule_dataView','预览管理成本'))
                                      )
                                      ))
                                      
                                    )),
                                    tabPanel('规则5-管理成本查询',tagList(
                                      fluidRow(column(4,box(
                                        title = "操作区域", width = NULL, solidHeader = TRUE, status = "primary",
                                        
                                        tsui::mdl_text(id = 'cp_item_mngrcost_year',label = '年份'),
                                        tsui::mdl_text(id = 'cp_item_mngrcost_period',label = '月份'),
                                        
                                        actionBttn(inputId = 'cp_item_mngrcost_query',label = '预览管理成本'),
                                        tsui::mdl_download_button(id = 'cp_item_mngrcost_dl',label = '下载管理成本')
                                        
                                      )),
                                      column(8, box(
                                        title = "报表区域", width = NULL, solidHeader = TRUE, status = "primary",
                                        div(style = 'overflow-x: scroll', mdl_dataTable('cp_item_mngrcost_dt','预览管理成本'))
                                        
                                      )
                                      ))
                                      
                                    )),
                                    tabPanel('计算6-奖金提成查询',tagList(
                                      fluidRow(column(4,box(
                                        title = "操作区域", width = NULL, solidHeader = TRUE, status = "primary",
                                        mdl_ListChoose1(id = 'cp_pfm_res_options_query',label = '请选择一个提成规则' ,choiceNames = cprdspkg::outstock_performance_rule_names(config_file = config_file),choiceValues = cprdspkg::outstock_performance_rule_names(config_file=config_file),selected =cprdspkg::outstock_performance_rule_names(config_file=config_file)[1] ),
                                        tsui::mdl_ListChoose1(id = 'cp_pfm_res_org',label = '选择公司',choiceNames = mdlSaleCommissionUI::organization_query(dms_token = dms_token),choiceValues = mdlSaleCommissionUI::organization_query(dms_token = dms_token),selected = '苏州赛普生物科技有限公司'),
                                        tsui::mdl_ListChoose1(id = 'cp_pfm_res_db',label = '数据中心选择',choiceNames = list('赛普集团旧账套2021.04.01-2022.07.31','赛普集团新账套2022.08.01-至令'),choiceValues =list(1,2),selected = 2 ),
                                        
                                        mdl_dateRange(id = 'cp_pfm_res_dateRange_query',label = '请选择日期范围',
                                                      startDate = as.Date('2022-08-01'),
                                                      endDate = as.Date('2022-09-30')),
                                        shiny::selectizeInput(inputId = 'cp_pfm_res_saleMan_selector',choices=mdlSaleCommissionServer::saleMan_query(dms_token = dms_token),label='销售员'),
                                        actionBttn(inputId = 'cp_pfm_res_query',label = '查询提成'),
                                        mdl_download_button('cp_pfm_res_download',label = '下载提成')
                                      )),
                                      column(8, box(
                                        title = "报表区域", width = NULL, solidHeader = TRUE, status = "primary",
                                        div(style = 'overflow-x: scroll', mdl_dataTable('cp_pfm_res_dataView','预览'))
                                        
                                      )
                                      ))
                                      
                                    )),
                                    tabPanel('报表7-销售提成报表-按业务员',tagList(
                                      fluidRow(column(4,box(
                                        title = "操作区域", width = NULL, solidHeader = TRUE, status = "primary",
                                        mdl_ListChoose1(id = 'cp_pfm_emp_options_query',label = '请选择一个提成规则' ,choiceNames = cprdspkg::outstock_performance_rule_names(config_file = config_file),choiceValues = cprdspkg::outstock_performance_rule_names(config_file=config_file),selected =cprdspkg::outstock_performance_rule_names(config_file=config_file)[1] ),
                                        tsui::mdl_ListChoose1(id = 'cp_pfm_emp_org',label = '选择公司',choiceNames = mdlSaleCommissionUI::organization_query(dms_token = dms_token),choiceValues = mdlSaleCommissionUI::organization_query(dms_token = dms_token),selected = '苏州赛普生物科技有限公司'),
                                        tsui::mdl_ListChoose1(id = 'cp_pfm_emp_db',label = '数据中心选择',choiceNames = list('赛普集团旧账套2021.04.01-2022.07.31','赛普集团新账套2022.08.01-至令'),choiceValues =list(1,2),selected = 2 ),
                                        
                                       tsui::mdl_text2(id = 'cp_pfm_emp_YearPeriod',label = '提成年月格式为年4位月2位如202208'),
                                      
                                        actionBttn(inputId = 'cp_pfm_emp_query',label = '查询提成'),
                                        mdl_download_button('cp_pfm_emp_download',label = '下载提成')
                                      )),
                                      column(8, box(
                                        title = "报表区域", width = NULL, solidHeader = TRUE, status = "primary",
                                        div(style = 'overflow-x: scroll', mdl_dataTable('cp_pfm_emp_dataView','预览'))
                                        
                                      )
                                      ))
                                      
                                    )),
                                    
                                    tabPanel('操作8-奖金提成发放',tagList(
                                      fluidRow(column(4,box(
                                        title = "操作区域", width = NULL, solidHeader = TRUE, status = "primary",
                                        tags$a(href='奖金提成发放模板.xlsx','第一次使用,请下载奖金提成发放模板'),
                                        mdl_file(id = 'cp_pfmr_file',label = '请选择奖金提成发放文件'),
                                        actionBttn(inputId = 'cp_pfmr_preview',label = '预览奖金提成发放'),
                                        actionBttn(inputId = 'cp_pfmr_update',label = '更新ERP状态')
                                      )),
                                      column(8, box(
                                        title = "报表区域", width = NULL, solidHeader = TRUE, status = "primary",
                                        div(style = 'overflow-x: scroll', mdl_dataTable('cp_pfmr_dataView','预览管理成本'))
                                        
                                      )
                                      ))
                                      
                                    ))
                                    
                           
                                    
                                    
                                    
                                    
                             )
                      )
                    )
)
 