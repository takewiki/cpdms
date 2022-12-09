tabItem(tabName = "mdlCasCom",
        fluidRow(
          column(width = 12,
                 tabBox(title ="资金管理工作台",width = 12,
                        id='tabSet_mdlCasCom',height = '300px',
                        tabPanel('账户清单',tagList(
                          fluidRow(column(4,box(
                            title = "操作区域", width = NULL, solidHeader = TRUE, status = "primary",
                            tsui::mdl_ListChoose1(id = 'cas_company_selector1',label = '选择公司',choiceNames = mdlCasServer::company_getList(dms_token = dms_token),choiceValues =mdlCasServer::company_getList(dms_token = dms_token),selected = '赛普集团' ),
                            actionBttn('cas_bankList_query','查询账户明细')
                            
                          )),
                          column(8, box(
                            title = "报表区域", width = NULL, solidHeader = TRUE, status = "primary",
                          
                            
                            div(style = 'overflow-x: scroll', mdl_dataTable('cas_bankList_dataView','银行账户清单'))
                            
                            
                          )
                          ))
                          
                        )),
                        tabPanel('资金日报查询',tagList(
                          fluidRow(column(4,box(
                            title = "操作区域", width = NULL, solidHeader = TRUE, status = "primary",
                            tsui::mdl_date(id = 'cas_dailyRpt_date',label = '日期'),
                            actionButton('cas_dailyRpt_query',label = '查询日报'),
                            mdl_download_button('cas_dailyRpt_dl','下载日报')
                            
                            
                          )),
                          column(8, box(
                            title = "报表区域", width = NULL, solidHeader = TRUE, status = "primary",
                            # mdl_dataTable('week_dataShow','周报数据预览')
                            #add the scrollable 
                            div(style = 'overflow-x: scroll', mdl_dataTable('cas_dailyRpt_dataView','日报数据预览')))
                          )
                          )
                          
                        )),
                        tabPanel('交易明细查询',tagList(
                          fluidRow(column(4,box(
                            title = "操作区域", width = NULL, solidHeader = TRUE, status = "primary",
                            
                            tsui::mdl_text2(id = 'cas_transaction_account',label = '账号',value = '467677162516'),
                            tsui::mdl_date(id = 'cas_transaction_date',label = '交易日期'),
                            actionButton('cas_transaction_query',label = '查询明细'),
                            mdl_download_button('cas_transaction_dl','下载明细')
                          )),
                          column(8, box(
                            title = "报表区域", width = NULL, solidHeader = TRUE, status = "primary",
                            # mdl_dataTable('month_dataShow','明细数据预览')
                            
                            #add the scroll bar
                            div(style = 'overflow-x: scroll', mdl_dataTable('cas_transaction_dataShow','交易明细数据预览'))
                            
                            
                            
                          )
                          ))
                          
                        ))
                       
                        
                        
                        
                        
                        
                        
                 )
          )
        )
)
