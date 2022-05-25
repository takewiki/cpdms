tabItem(tabName = "mdlReusedMtrlCom",
                    fluidRow(
                      column(width = 12,
                             tabBox(title ="回料管理工作台",width = 12,
                                    id='tabSet_mdlReusedMtrlCom',height = '300px',
                                    mdlReusedMtrlUI::prdInStockUI(),
                                    mdlReusedMtrlUI::prdPickupUI()
                                    
                                    
                                    
                                    
                             )
                      )
                    )
)
 