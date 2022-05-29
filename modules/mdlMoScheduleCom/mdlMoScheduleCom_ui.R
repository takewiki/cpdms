tabItem(tabName = "mdlMoScheduleCom",
                    fluidRow(
                      column(width = 12,
                             tabBox(title ="生产订单排产管理工作台",width = 12,
                                    id='tabSet_mdlMoScheduleCom',height = '300px',
                                    mdlMoScheduleUI::scheduleDetailUI(),
                                    mdlMoScheduleUI::scheduleStatUI()
                                    
                                     
                                   
                                    
                                    
                                    
                                    
                             )
                      )
                    )
)
 