tabItem(tabName = "mdlUserManagerCom",
                    fluidRow(
                      column(width = 12,
                             tabBox(title ="用户管理管理工作台",width = 12,
                                    id='tabSet_mdlMultipleMaterialCom',height = '300px',
                                    mdlUserManagerUI::userAddUI(),
                                    mdlUserManagerUI::userQueryUI(),
                                    mdlUserManagerUI::userRoleSettingUI(),
                                    mdlUserManagerUI::roleAddUI(),
                                    mdlUserManagerUI::roleQueryUI(),
                                    mdlUserManagerUI::roleRightUI()
                                    
                                   
                                    
                                    
                                    
                                    
                             )
                      )
                    )
)
 