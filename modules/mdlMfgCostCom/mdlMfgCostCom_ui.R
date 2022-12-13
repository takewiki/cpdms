tabItem(tabName = 'mdlMfgCostCom',
                    fluidRow(
                      column(width = 12,
                             tabBox(title ="产品成本工作台",width = 12,
                                    id="tabSet_mdlMfgCostCom",height = '300px',
                                    #注册UI组件
                                    mdlMfgCostUI::mfgCostUI()
                                    
                                    
                             )
                      )
                    )
)
 