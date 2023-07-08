#tabName need to be update
#tabBox title need to be update
#tabBox id need to be update
tabItem(tabName = "mdlCpEcsMdCom",
                    fluidRow(
                      column(width = 12,
                             tabBox(title ="ECS基础资料工作台",width = 12,
                                    id='tabSet_mdlCpEcsMdCom',height = '300px',
                                    #以上为注册ui组件的内容-----
                                    #begin----
                                    #uiComponent seperated by comma (,)
                                    mdlCpEcsMdUI::materialUI(),
                                    mdlCpEcsMdUI::customerUI(),
                                    mdlCpEcsMdUI::supplierUI()
                                  
                                     
                                    
                                    
                                    #end----
                                    
                                    
                                    
                                    
                                    
                             )
                      )
                    )
)
 