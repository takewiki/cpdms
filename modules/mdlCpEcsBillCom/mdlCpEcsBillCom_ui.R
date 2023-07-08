#tabName need to be update
#tabBox title need to be update
#tabBox id need to be update
tabItem(tabName = "mdlCpEcsBillCom",
                    fluidRow(
                      column(width = 12,
                             tabBox(title ="ECS单据工作台",width = 12,
                                    id='tabSet_mdlCpEcsBillCom',height = '300px',
                                    #以上为注册ui组件的内容-----
                                    #begin----
                                    #uiComponent seperated by comma (,)
                                    mdlCpEcsBillUI::purchaseOrderUI(),
                                    mdlCpEcsBillUI::purchaseReceiveNoticeUI(),
                                    mdlCpEcsBillUI::purchaseInStockUI(),
                                    mdlCpEcsBillUI::apBillUI(),
                                    mdlCpEcsBillUI::purchaseReturnNoticeUI(),
                                    mdlCpEcsBillUI::purchaseReturnStockUI(),
                                    mdlCpEcsBillUI::saleOrderUI(),
                                    mdlCpEcsBillUI::saleDeliveryNoticeUI(),
                                    mdlCpEcsBillUI::saleOutStockUI(),
                                    mdlCpEcsBillUI::arBillUI(),
                                    mdlCpEcsBillUI::saleReturnNoticeUI(),
                                    mdlCpEcsBillUI::saleReturnStockUI(),
                                    mdlCpEcsBillUI::miscellaneousInStockUI(),
                                    mdlCpEcsBillUI::miscellaneousOutStockUI(),
                                    mdlCpEcsBillUI::stkAssemblyBillUI()
                                    
                                     
                                    
                                    
                                    #end----
                                    
                                    
                                    
                                    
                                    
                             )
                      )
                    )
)
 