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
                                        tsui::mdl_ListChoose1(id = 'sync_src_saleOrder_db',label = '数据中心选择',choiceNames = list('赛普集团旧账套2021.04.01-2022.07.31','赛普集团新账套2022.08.01-至令'),choiceValues =list(1,2),selected = 2 ),
                                        actionBttn(inputId = 'sync_src_saleOrder_click',label = '同步'),
                                        actionBttn(inputId = 'sync_src_saleOrder_view',label = '查看')
                                      )),
                                      column(8, box(
                                        title = "报表区域", width = NULL, solidHeader = TRUE, status = "primary",
                                        'rpt3'
                                      )
                                      ))
                                      
                                    )),
                                    tabPanel('数据源2-同步销售订单预收款/预收款退款',tagList(
                                      fluidRow(column(4,box(
                                        title = "操作区域", width = NULL, solidHeader = TRUE, status = "primary",
                                        tags$h4('销售订单预收款是指关联销售订单的预收款，如果预收款没有关联销售订单（简称为客户预收款），则不纳入提成计算范围;订单预收款退款是指销售订单预收款所做的退款'),
                                        tags$h4('销售订单预收款后续将按销售出库顺序分配到订单对应的销售出库单上'),
                                        tsui::mdl_dateRange(id = 'sync_src_saleAdvance_read',startDate = as.Date('2022-08-01'),endDate = as.Date('2022-08-31')),
                                        tsui::mdl_ListChoose1(id = 'sync_src_saleAdvance_db',label = '数据中心选择',choiceNames = list('赛普集团旧账套2021.04.01-2022.07.31','赛普集团新账套2022.08.01-至令'),choiceValues =list(1,2),selected = 2 ),
                                        actionBttn(inputId = 'sync_src_saleAdvance_click',label = '同步'),
                                        actionBttn(inputId = 'sync_src_saleAdvance_view',label = '查看')
                                      )),
                                      column(8, box(
                                        title = "报表区域", width = NULL, solidHeader = TRUE, status = "primary",
                                        'rpt3'
                                      )
                                      ))
                                      
                                    )),
                                    tabPanel('数据源3-同步销售出库及销售退货',tagList(
                                      fluidRow(column(4,box(
                                        title = "操作区域", width = NULL, solidHeader = TRUE, status = "primary",
                                        tags$h4('销售出库是指所有已审核未发放提成的销售出库及销售退货单，其中销售退货数量及金额使用负数表示'),
                                        tags$h4('新规则以此作为记录依据'),
                                        tsui::mdl_dateRange(id = 'sync_src_saleOutStock_read',startDate = as.Date('2022-08-01'),endDate = as.Date('2022-08-31')),
                                        tsui::mdl_ListChoose1(id = 'sync_src_saleOutStock_db',label = '数据中心选择',choiceNames = list('赛普集团旧账套2021.04.01-2022.07.31','赛普集团新账套2022.08.01-至令'),choiceValues =list(1,2),selected = 2 ),
                                        actionBttn(inputId = 'sync_src_saleOutStock_click',label = '同步'),
                                        actionBttn(inputId = 'sync_src_saleOutStock_view',label = '查看')
                                      )),
                                      column(8, box(
                                        title = "报表区域", width = NULL, solidHeader = TRUE, status = "primary",
                                        'rpt3'
                                      )
                                      ))
                                      
                                    )),
                                    
                                    tabPanel('数据源4-同步销售开票记录(应收单)',tagList(
                                      fluidRow(column(4,box(
                                        title = "操作区域", width = NULL, solidHeader = TRUE, status = "primary",
                                        tags$h4('销售开票是指所有已审核未发放提成的销售出库对应的财务应收单(旧账套)或业务应收单(新账套)'),
                                        tsui::mdl_dateRange(id = 'sync_src_saleInvoice_read',startDate = as.Date('2022-08-01'),endDate = as.Date('2022-08-31')),
                                        tsui::mdl_ListChoose1(id = 'sync_src_saleInvoice_db',label = '数据中心选择',choiceNames = list('赛普集团旧账套2021.04.01-2022.07.31','赛普集团新账套2022.08.01-至令'),choiceValues =list(1,2),selected = 2 ),
                                        actionBttn(inputId = 'sync_src_saleInvoice_click',label = '同步'),
                                        actionBttn(inputId = 'sync_src_saleInvoice_view',label = '查看')
                                      )),
                                      column(8, box(
                                        title = "报表区域", width = NULL, solidHeader = TRUE, status = "primary",
                                        'rpt3'
                                      )
                                      ))
                                      
                                    )),
                                    tabPanel('数据源5-同步销售回款/退款记录',tagList(
                                      fluidRow(column(4,box(
                                        title = "操作区域", width = NULL, solidHeader = TRUE, status = "primary",
                                        tags$h4('销售回款是指关联应收单做了收款单或关联收款单做的退款单'),
                                        tsui::mdl_dateRange(id = 'sync_src_saleRece_read',startDate = as.Date('2022-08-01'),endDate = as.Date('2022-08-31')),
                                        tsui::mdl_ListChoose1(id = 'sync_src_saleRece_db',label = '数据中心选择',choiceNames = list('赛普集团旧账套2021.04.01-2022.07.31','赛普集团新账套2022.08.01-至令'),choiceValues =list(1,2),selected = 2 ),
                                        actionBttn(inputId = 'sync_src_saleRece_click',label = '同步'),
                                        actionBttn(inputId = 'sync_src_saleRece_view',label = '查看')
                                      )),
                                      column(8, box(
                                        title = "报表区域", width = NULL, solidHeader = TRUE, status = "primary",
                                        'rpt3'
                                      )
                                      ))
                                      
                                    )),
                                    
                                    
                                    tabPanel('计算6-订单预收款分配',tagList(
                                      fluidRow(column(4,box(
                                        title = "操作区域", width = NULL, solidHeader = TRUE, status = "primary",
                                        tags$h4('订单预收款分配是指将销售订单的预收款按销售出库顺序分配到订单对应的销售出库单上'),
                                        tsui::mdl_dateRange(id = 'sync_src_saleAlloc_read',startDate = as.Date('2022-08-01'),endDate = as.Date('2022-08-31')),
                                        tsui::mdl_ListChoose1(id = 'sync_src_saleAlloc_db',label = '数据中心选择',choiceNames = list('赛普集团旧账套2021.04.01-2022.07.31','赛普集团新账套2022.08.01-至令'),choiceValues =list(1,2),selected = 2 ),
                                        actionBttn(inputId = 'sync_src_saleAlloc_click',label = '分配'),
                                        actionBttn(inputId = 'sync_src_saleAlloc_view',label = '查看')
                                      )),
                                      column(8, box(
                                        title = "报表区域", width = NULL, solidHeader = TRUE, status = "primary",
                                        'rpt3'
                                      )
                                      ))
                                      
                                    )),
                                    
                                    tabPanel('规则7-奖金提成规则',tagList(
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
                                    tabPanel('规则8-管理成本查询',tagList(
                                      fluidRow(column(4,box(
                                        title = "操作区域", width = NULL, solidHeader = TRUE, status = "primary",
                                        
                                        mdl_file(id = 'cp_item_mngrCost_file1',label = '请选择物料的管理成本文件'),
                                        actionBttn(inputId = 'cp_item_mngrcost_preview1',label = '预览管理成本')
                                        
                                      )),
                                      column(8, box(
                                        title = "报表区域", width = NULL, solidHeader = TRUE, status = "primary",
                                        div(style = 'overflow-x: scroll', mdl_dataTable('cp_item_mngrcost_dataView1','预览管理成本'))
                                        
                                      )
                                      ))
                                      
                                    )),
                                    tabPanel('计算9-奖金提成测算',tagList(
                                      fluidRow(column(4,box(
                                        title = "操作区域", width = NULL, solidHeader = TRUE, status = "primary",
                                        mdl_ListChoose1(id = 'cp_pfm_rule_options',label = '请选择一个提成规则' ,choiceNames = cprdspkg::outstock_performance_rule_names(config_file = config_file),choiceValues = cprdspkg::outstock_performance_rule_names(config_file=config_file),selected =cprdspkg::outstock_performance_rule_names(config_file=config_file)[1] ),
                                        mdl_dateRange(id = 'cp_pfm_rule_dateRange',label = '请选择日期范围',
                                                      startDate = as.Date('2021-04-01'),
                                                      endDate = as.Date('2100-12-31')),
                                        actionBttn(inputId = 'cp_pfm_rule_calc',label = '计算提成')
                                      )),
                                      column(8, box(
                                        title = "报表区域", width = NULL, solidHeader = TRUE, status = "primary",
                                        div(style = 'overflow-x: scroll', mdl_dataTable('cp_pfm_calc_dataView','预览'))
                                      )
                                      ))
                                      
                                    )),
                                    tabPanel('计算10-奖金提成计提',tagList(
                                      fluidRow(column(4,box(
                                        title = "操作区域", width = NULL, solidHeader = TRUE, status = "primary",
                                        mdl_ListChoose1(id = 'cp_pfm_res_options_query',label = '请选择一个提成规则' ,choiceNames = cprdspkg::outstock_performance_rule_names(config_file = config_file),choiceValues = cprdspkg::outstock_performance_rule_names(config_file=config_file),selected =cprdspkg::outstock_performance_rule_names(config_file=config_file)[1] ),
                                        mdl_dateRange(id = 'cp_pfm_res_dateRange_query',label = '请选择日期范围',
                                                      startDate = as.Date('2021-04-01'),
                                                      endDate = as.Date('2100-12-31')),
                                        actionBttn(inputId = 'cp_pfm_res_query',label = '查询提成'),
                                        mdl_download_button('cp_pfm_res_download',label = '下载提成')
                                      )),
                                      column(8, box(
                                        title = "报表区域", width = NULL, solidHeader = TRUE, status = "primary",
                                        div(style = 'overflow-x: scroll', mdl_dataTable('cp_pfm_res_dataView','预览'))
                                        
                                      )
                                      ))
                                      
                                    )),
                                    
                                    tabPanel('操作11-奖金提成发放',tagList(
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
                                      
                                    )),
                                    
                                    tabPanel('报表12-销售提成报表-按业务员',tagList(
                                      fluidRow(column(4,box(
                                        title = "操作区域", width = NULL, solidHeader = TRUE, status = "primary",
                                        tsui::mdl_text(id = 'rptEmp',label = '请录入业务员'),
                                        tsui::mdl_dateRange(id = 'rptEmp_read',startDate = as.Date('2022-08-01'),endDate = as.Date('2022-08-31')),
                                        tsui::mdl_ListChoose1(id = 'rptEmp_db',label = '数据中心选择',choiceNames = list('赛普集团旧账套2021.04.01-2022.07.31','赛普集团新账套2022.08.01-至令'),choiceValues =list(1,2),selected = 2 ),
                                        actionBttn(inputId = 'rptEmp_click',label = '查询')
                                      )),
                                      column(8, box(
                                        title = "报表区域", width = NULL, solidHeader = TRUE, status = "primary",
                                        'rpt4'
                                      )
                                      ))
                                      
                                    )),
                                    tabPanel('报表13-销售提成报表-按部门',tagList(
                                      fluidRow(column(4,box(
                                        title = "操作区域", width = NULL, solidHeader = TRUE, status = "primary",
                                        tsui::mdl_text(id = 'rptEmp',label = '请录入销售部门'),
                                        tsui::mdl_dateRange(id = 'rptEmp_read',startDate = as.Date('2022-08-01'),endDate = as.Date('2022-08-31')),
                                        tsui::mdl_ListChoose1(id = 'rptEmp_db',label = '数据中心选择',choiceNames = list('赛普集团旧账套2021.04.01-2022.07.31','赛普集团新账套2022.08.01-至令'),choiceValues =list(1,2),selected = 2 ),
                                        actionBttn(inputId = 'rptEmp_click',label = '查询')
                                      )),
                                      column(8, box(
                                        title = "报表区域", width = NULL, solidHeader = TRUE, status = "primary",
                                        'rpt4'
                                      )
                                      ))
                                      
                                    )),
                                    tabPanel('报表14-销售提成报表-按产品',tagList(
                                      fluidRow(column(4,box(
                                        title = "操作区域", width = NULL, solidHeader = TRUE, status = "primary",
                                        tsui::mdl_text(id = 'rptEmp',label = '请录入产品'),
                                        tsui::mdl_dateRange(id = 'rptEmp_read',startDate = as.Date('2022-08-01'),endDate = as.Date('2022-08-31')),
                                        tsui::mdl_ListChoose1(id = 'rptEmp_db',label = '数据中心选择',choiceNames = list('赛普集团旧账套2021.04.01-2022.07.31','赛普集团新账套2022.08.01-至令'),choiceValues =list(1,2),selected = 2 ),
                                        actionBttn(inputId = 'rptEmp_click',label = '查询')
                                      )),
                                      column(8, box(
                                        title = "报表区域", width = NULL, solidHeader = TRUE, status = "primary",
                                        'rpt4'
                                      )
                                      ))
                                      
                                    ))
                                    
                                    
                                    
                                    
                             )
                      )
                    )
)
 