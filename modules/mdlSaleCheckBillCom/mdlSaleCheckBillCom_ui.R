tabItem(tabName = "mdlSaleCheckBillCom",
                    fluidRow(
                      column(width = 12,
                             tabBox(title ="销售对账工作台",width = 12,
                                    id='tabSet_mdlSaleCheckBillCom',height = '300px',
                                    tabPanel('销售对账单更新期初数据',tagList(
                                      fluidRow(column(4,box(
                                        title = "操作区域", width = NULL, solidHeader = TRUE, status = "primary",
                                        tags$a(href='赛普对账单期初数修改模板.xlsx','第一次使用,请下载赛普对账单期初数修改模板'),
                                        mdl_file(id = 'cp_dzd_initData_file',label = '对账单更新期初数据'),
                                        actionButton(inputId = 'dzd_initData_query',label = '预览数据'),
                                        actionButton(inputId = 'dzd_initData_update',label = '更新数据')
                                        
                                      )),
                                      
                                      column(8, box(
                                        title = "报表区域", width = NULL, solidHeader = TRUE, status = "primary",
                                        
                                        div(style = 'overflow-x: scroll', mdl_dataTable('dzd_initData_dataView','预览'))
                                      )
                                      ))
                                      
                                    ))
                           
                                    
                                    
                                    
                                    
                             )
                      )
                    )
)
 