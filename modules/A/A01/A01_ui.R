 tabItem(tabName = "A01",
                    fluidRow(
                      column(width = 12,
                             tabBox(title ="A01工作台",width = 12,
                                    id='tabSet_row',height = '300px',
                                    tabPanel('sheet1',tagList(
                                      fluidRow(column(4,box(
                                        title = "操作区域", width = NULL, solidHeader = TRUE, status = "primary",
                                        sliderInput("bins",
                                                    "Number of bins:",
                                                    min = 1,
                                                    max = 50,
                                                    value = 30)
                                      )),
                                      column(8, box(
                                        title = "报表区域", width = NULL, solidHeader = TRUE, status = "primary",
                                        
                                        plotOutput("distPlot")
                                      )
                                      ))
                                      
                                    )),
                                    tabPanel('sheet2',tagList(
                                      fluidRow(column(4,box(
                                        title = "操作区域", width = NULL, solidHeader = TRUE, status = "primary",
                                        'sheet2'
                                      )),
                                      column(8, box(
                                        title = "报表区域", width = NULL, solidHeader = TRUE, status = "primary",
                                       'rpt2'
                                      )
                                      ))
                                      
                                    )),
                                    
                                    tabPanel('sheet3',tagList(
                                      fluidRow(column(4,box(
                                        title = "操作区域", width = NULL, solidHeader = TRUE, status = "primary",
                                        'sheet3'
                                      )),
                                      column(8, box(
                                        title = "报表区域", width = NULL, solidHeader = TRUE, status = "primary",
                                        'rpt3'
                                      )
                                      ))
                                      
                                    )),
                                    tabPanel('sheet4',tagList(
                                      fluidRow(column(4,box(
                                        title = "操作区域", width = NULL, solidHeader = TRUE, status = "primary",
                                        'sheet4'
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