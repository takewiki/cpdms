#5.8
tabItem(tabName = 'mdlMngrCostCom',
                    fluidRow(
                      column(width = 12,
                             tabBox(title ="产品管理成本工作台",width = 12,
                                    id="tabSet_mdlMngrCostCom",height = '300px',
                                    #注册UI组件
                                    mdlMngrCostUI::mngrCostUI()
                                     
                                    
                                    
                                    
                                    
                             )
                      )
                    )
)
 