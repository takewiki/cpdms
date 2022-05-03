

#shinyserver start point----
 shinyServer(function(input, output,session) {
    #00-基础框设置-------------
    #读取用户列表
    user_base <- getUsers(conn_be,app_id)
    
    
    
    credentials <- callModule(shinyauthr::login, "login", 
                              data = user_base,
                              user_col = Fuser,
                              pwd_col = Fpassword,
                              hashed = TRUE,
                              algo = "md5",
                              log_out = reactive(logout_init()))
    
    
    
    logout_init <- callModule(shinyauthr::logout, "logout", reactive(credentials()$user_auth))
    
    observe({
       if(credentials()$user_auth) {
          shinyjs::removeClass(selector = "body", class = "sidebar-collapse")
       } else {
          shinyjs::addClass(selector = "body", class = "sidebar-collapse")
       }
    })
    
    user_info <- reactive({credentials()$info})
    
    #显示用户信息
    output$show_user <- renderUI({
       req(credentials()$user_auth)
       
       dropdownButton(
          fluidRow(  box(
             title = NULL, status = "primary", width = 12,solidHeader = FALSE,
             collapsible = FALSE,collapsed = FALSE,background = 'black',
             #2.01.01工具栏选项--------
             
             
             actionLink('cu_updatePwd',label ='修改密码',icon = icon('gear') ),
             br(),
             br(),
             actionLink('cu_UserInfo',label = '用户信息',icon = icon('address-card')),
             br(),
             br(),
             actionLink(inputId = "closeCuMenu",
                        label = "关闭菜单",icon =icon('window-close' ))
             
             
          )) 
          ,
          circle = FALSE, status = "primary", icon = icon("user"), width = "100px",
          tooltip = FALSE,label = user_info()$Fuser,right = TRUE,inputId = 'UserDropDownMenu'
       )
       #
       
       
    })
    
    observeEvent(input$closeCuMenu,{
       toggleDropdownButton(inputId = "UserDropDownMenu")
    }
    )
    
    #修改密码
    observeEvent(input$cu_updatePwd,{
       req(credentials()$user_auth)
       
       showModal(modalDialog(title = paste0("修改",user_info()$Fuser,"登录密码"),
                             
                             mdl_password('cu_originalPwd',label = '输入原密码'),
                             mdl_password('cu_setNewPwd',label = '输入新密码'),
                             mdl_password('cu_RepNewPwd',label = '重复新密码'),
                             
                             footer = column(shiny::modalButton('取消'),
                                             shiny::actionButton('cu_savePassword', '保存'),
                                             width=12),
                             size = 'm'
       ))
    })
    
    #处理密码修改
    
    var_originalPwd <-var_password('cu_originalPwd')
    var_setNewPwd <- var_password('cu_setNewPwd')
    var_RepNewPwd <- var_password('cu_RepNewPwd')
    
    observeEvent(input$cu_savePassword,{
       req(credentials()$user_auth)
       #获取用户参数并进行加密处理
       var_originalPwd <- password_md5(var_originalPwd())
       var_setNewPwd <-password_md5(var_setNewPwd())
       var_RepNewPwd <- password_md5(var_RepNewPwd())
       check_originalPwd <- password_checkOriginal(fappId = app_id,fuser =user_info()$Fuser,fpassword = var_originalPwd)
       check_newPwd <- password_equal(var_setNewPwd,var_RepNewPwd)
       if(check_originalPwd){
          #原始密码正确
          #进一步处理
          if(check_newPwd){
             password_setNew(fappId = app_id,fuser =user_info()$Fuser,fpassword = var_setNewPwd)
             pop_notice('新密码设置成功:)') 
             shiny::removeModal()
             
          }else{
             pop_notice('两次输入的密码不一致，请重试:(') 
          }
          
          
       }else{
          pop_notice('原始密码不对，请重试:(')
       }
       
       
       
       
       
    }
    )
    
    
    
    #查看用户信息
    
    #修改密码
    observeEvent(input$cu_UserInfo,{
       req(credentials()$user_auth)
       
       user_detail <-function(fkey){
          res <-tsui::userQueryField(conn = conn_be,app_id = app_id,user =user_info()$Fuser,key = fkey)
          return(res)
       } 
       
       
       showModal(modalDialog(title = paste0("查看",user_info()$Fuser,"用户信息"),
                             
                             textInput('cu_info_name',label = '姓名:',value =user_info()$Fname ),
                             textInput('cu_info_role',label = '角色:',value =user_info()$Fpermissions ),
                             textInput('cu_info_email',label = '邮箱:',value =user_detail('Femail') ),
                             textInput('cu_info_phone',label = '手机:',value =user_detail('Fphone') ),
                             textInput('cu_info_rpa',label = 'RPA账号:',value =user_detail('Frpa') ),
                             textInput('cu_info_dept',label = '部门:',value =user_detail('Fdepartment') ),
                             textInput('cu_info_company',label = '公司:',value =user_detail('Fcompany') ),
                             
                             
                             footer = column(shiny::modalButton('确认(不保存修改)'),
                                             
                                             width=12),
                             size = 'm'
       ))
    })
    
    
    
    #针对用户信息进行处理
    
    sidebarMenu <- reactive({
       
       #res <- setSideBarMenu(conn_be,app_id,user_info()$Fpermissions)
       res <- tsui::menu_getItemData(conn = conn_be,app_id =app_id,permission = user_info()$Fpermissions )
       return(res)
    })
    
    
    #针对侧边栏进行控制
    output$show_sidebarMenu <- renderUI({
       if(credentials()$user_auth){
          return(sidebarMenu())
       } else{
          return(NULL) 
       }
       
       
    })
    
    #针对工作区进行控制---------
    output$show_workAreaSetting <- renderUI({
       if(credentials()$user_auth){
          return(workAreaSetting)
       } else{
          return(NULL) 
       }
       
       
    })
    #针对功能进行处理
    #A01---------
    load_server(input,output,session,system_id =  'A',module_id = 'A01')

    load_server(input,output,session,system_id =  'A',module_id = 'A02')
    
    load_server(input,output,session,system_id =  'A',module_id = 'A03')
    
    load_server(input,output,session,system_id =  'A',module_id = 'A04')
    
    load_server(input,output,session,system_id =  'A',module_id = 'A05')
    
    load_server(input,output,session,system_id =  'A',module_id = 'A06')
    
    load_server(input,output,session,system_id =  'A',module_id = 'A07')
    
    load_server(input,output,session,system_id =  'A',module_id = 'A08')
    
    load_server(input,output,session,system_id =  'A',module_id = 'A09')
    
    load_server(input,output,session,system_id =  'A',module_id = 'A10')
    
     load_server(input,output,session,system_id =  'B',module_id = 'B01')
    
     load_server(input,output,session,system_id =  'B',module_id = 'B02')
    
     load_server(input,output,session,system_id =  'B',module_id = 'B03')
    
     load_server(input,output,session,system_id =  'B',module_id = 'B04')
    
     load_server(input,output,session,system_id =  'B',module_id = 'B05')
    
     load_server(input,output,session,system_id =  'B',module_id = 'B06')
    
     load_server(input,output,session,system_id =  'B',module_id = 'B07')
    
     load_server(input,output,session,system_id =  'B',module_id = 'B08')
    
     load_server(input,output,session,system_id =  'B',module_id = 'B09')
    
     load_server(input,output,session,system_id =  'B',module_id = 'B10')

     load_server(input,output,session,system_id =  'C',module_id = 'C01')
    
     load_server(input,output,session,system_id =  'C',module_id = 'C02')
    
     load_server(input,output,session,system_id =  'C',module_id = 'C03')
    
     load_server(input,output,session,system_id =  'C',module_id = 'C04')
    
     load_server(input,output,session,system_id =  'C',module_id = 'C05')
    
     load_server(input,output,session,system_id =  'C',module_id = 'C06')
    
     load_server(input,output,session,system_id =  'C',module_id = 'C07')
    
     load_server(input,output,session,system_id =  'C',module_id = 'C08')
    
     load_server(input,output,session,system_id =  'C',module_id = 'C09')
    
     load_server(input,output,session,system_id =  'C',module_id = 'C10')
    
     load_server(input,output,session,system_id =  'D',module_id = 'D01')
    
     load_server(input,output,session,system_id =  'D',module_id = 'D02')
    
     load_server(input,output,session,system_id =  'D',module_id = 'D03')
    
     load_server(input,output,session,system_id =  'D',module_id = 'D04')
    
     load_server(input,output,session,system_id =  'D',module_id = 'D05')
    
     load_server(input,output,session,system_id =  'D',module_id = 'D06')
    
     load_server(input,output,session,system_id =  'D',module_id = 'D07')
    
     load_server(input,output,session,system_id =  'D',module_id = 'D08')
    
     load_server(input,output,session,system_id =  'D',module_id = 'D09')
    
     load_server(input,output,session,system_id =  'D',module_id = 'D10')
    
     load_server(input,output,session,system_id =  'E',module_id = 'E01')
    
     load_server(input,output,session,system_id =  'E',module_id = 'E02')
    
     load_server(input,output,session,system_id =  'E',module_id = 'E03')
    
     load_server(input,output,session,system_id =  'E',module_id = 'E04')
    
     load_server(input,output,session,system_id =  'E',module_id = 'E05')
    
     load_server(input,output,session,system_id =  'E',module_id = 'E06')
    
     load_server(input,output,session,system_id =  'E',module_id = 'E07')
    
     load_server(input,output,session,system_id =  'E',module_id = 'E08')
    
     load_server(input,output,session,system_id =  'E',module_id = 'E09')
    
     load_server(input,output,session,system_id =  'E',module_id = 'E10')
    
     load_server(input,output,session,system_id =  'F',module_id = 'F01')
    
     load_server(input,output,session,system_id =  'F',module_id = 'F02')
    
     load_server(input,output,session,system_id =  'F',module_id = 'F03')
    
     load_server(input,output,session,system_id =  'F',module_id = 'F04')
    
     load_server(input,output,session,system_id =  'F',module_id = 'F05')
    
     load_server(input,output,session,system_id =  'F',module_id = 'F06')
    
     load_server(input,output,session,system_id =  'F',module_id = 'F07')
    
     load_server(input,output,session,system_id =  'F',module_id = 'F08')
    
     load_server(input,output,session,system_id =  'F',module_id = 'F09')
    
     load_server(input,output,session,system_id =  'F',module_id = 'F10')
    
     load_server(input,output,session,system_id =  'G',module_id = 'G01')
    
     load_server(input,output,session,system_id =  'G',module_id = 'G02')
    
     load_server(input,output,session,system_id =  'G',module_id = 'G03')
    
     load_server(input,output,session,system_id =  'G',module_id = 'G04')
    
     load_server(input,output,session,system_id =  'G',module_id = 'G05')
    
     load_server(input,output,session,system_id =  'G',module_id = 'G06')
    
     load_server(input,output,session,system_id =  'G',module_id = 'G07')
    
     load_server(input,output,session,system_id =  'G',module_id = 'G08')
    
     load_server(input,output,session,system_id =  'G',module_id = 'G09')
    
     load_server(input,output,session,system_id =  'G',module_id = 'G10')
    
     load_server(input,output,session,system_id =  'H',module_id = 'H01')
    
     load_server(input,output,session,system_id =  'H',module_id = 'H02')
    
     load_server(input,output,session,system_id =  'H',module_id = 'H03')
    
     load_server(input,output,session,system_id =  'H',module_id = 'H04')
    
     load_server(input,output,session,system_id =  'H',module_id = 'H05')
    
     load_server(input,output,session,system_id =  'H',module_id = 'H06')
    
     load_server(input,output,session,system_id =  'H',module_id = 'H07')
    
     load_server(input,output,session,system_id =  'H',module_id = 'H08')
    
     load_server(input,output,session,system_id =  'H',module_id = 'H09')
    
     load_server(input,output,session,system_id =  'H',module_id = 'H10')
    
     load_server(input,output,session,system_id =  'I',module_id = 'I01')
    
     load_server(input,output,session,system_id =  'I',module_id = 'I02')
    
     load_server(input,output,session,system_id =  'I',module_id = 'I03')
    
     load_server(input,output,session,system_id =  'I',module_id = 'I04')
    
     load_server(input,output,session,system_id =  'I',module_id = 'I05')
    
     load_server(input,output,session,system_id =  'I',module_id = 'I06')
    
     load_server(input,output,session,system_id =  'I',module_id = 'I07')
    
     load_server(input,output,session,system_id =  'I',module_id = 'I08')
    
     load_server(input,output,session,system_id =  'I',module_id = 'I09')
    
     load_server(input,output,session,system_id =  'I',module_id = 'I10')
    
     load_server(input,output,session,system_id =  'J',module_id = 'J01')
    
     load_server(input,output,session,system_id =  'J',module_id = 'J02')
    
     load_server(input,output,session,system_id =  'J',module_id = 'J03')
    
     load_server(input,output,session,system_id =  'J',module_id = 'J04')
    
     load_server(input,output,session,system_id =  'J',module_id = 'J05')
    
     load_server(input,output,session,system_id =  'J',module_id = 'J06')
    
     load_server(input,output,session,system_id =  'J',module_id = 'J07')
    
     load_server(input,output,session,system_id =  'J',module_id = 'J08')
    
     load_server(input,output,session,system_id =  'J',module_id = 'J09')
    
     load_server(input,output,session,system_id =  'J',module_id = 'J10')
    
     load_server(input,output,session,system_id =  'K',module_id = 'K01')
    
     load_server(input,output,session,system_id =  'K',module_id = 'K02')
    
     load_server(input,output,session,system_id =  'K',module_id = 'K03')
    
     load_server(input,output,session,system_id =  'K',module_id = 'K04')
    
     load_server(input,output,session,system_id =  'K',module_id = 'K05')
    
     load_server(input,output,session,system_id =  'K',module_id = 'K06')
    
     load_server(input,output,session,system_id =  'K',module_id = 'K07')
    
     load_server(input,output,session,system_id =  'K',module_id = 'K08')
    
     load_server(input,output,session,system_id =  'K',module_id = 'K09')
    
     load_server(input,output,session,system_id =  'K',module_id = 'K10')
    
     load_server(input,output,session,system_id =  'L',module_id = 'L01')
    
     load_server(input,output,session,system_id =  'L',module_id = 'L02')
    
     load_server(input,output,session,system_id =  'L',module_id = 'L03')
    
     load_server(input,output,session,system_id =  'L',module_id = 'L04')
    
     load_server(input,output,session,system_id =  'L',module_id = 'L05')
    
     load_server(input,output,session,system_id =  'L',module_id = 'L06')
    
     load_server(input,output,session,system_id =  'L',module_id = 'L07')
    
     load_server(input,output,session,system_id =  'L',module_id = 'L08')
    
     load_server(input,output,session,system_id =  'L',module_id = 'L09')
    
     load_server(input,output,session,system_id =  'L',module_id = 'L10')
    
     load_server(input,output,session,system_id =  'M',module_id = 'M01')
    
     load_server(input,output,session,system_id =  'M',module_id = 'M02')
    
     load_server(input,output,session,system_id =  'M',module_id = 'M03')
    
     load_server(input,output,session,system_id =  'M',module_id = 'M04')
    
     load_server(input,output,session,system_id =  'M',module_id = 'M05')
    
     load_server(input,output,session,system_id =  'M',module_id = 'M06')
    
     load_server(input,output,session,system_id =  'M',module_id = 'M07')
    
     load_server(input,output,session,system_id =  'M',module_id = 'M08')
    
     load_server(input,output,session,system_id =  'M',module_id = 'M09')
    
     load_server(input,output,session,system_id =  'M',module_id = 'M10')
    
     load_server(input,output,session,system_id =  'N',module_id = 'N01')
    
     load_server(input,output,session,system_id =  'N',module_id = 'N02')
    
     load_server(input,output,session,system_id =  'N',module_id = 'N03')
    
     load_server(input,output,session,system_id =  'N',module_id = 'N04')
    
     load_server(input,output,session,system_id =  'N',module_id = 'N05')
    
     load_server(input,output,session,system_id =  'N',module_id = 'N06')
    
     load_server(input,output,session,system_id =  'N',module_id = 'N07')
    
     load_server(input,output,session,system_id =  'N',module_id = 'N08')
    
     load_server(input,output,session,system_id =  'N',module_id = 'N09')
    
     load_server(input,output,session,system_id =  'N',module_id = 'N10')
    
     load_server(input,output,session,system_id =  'O',module_id = 'O01')
    
     load_server(input,output,session,system_id =  'O',module_id = 'O02')
    
     load_server(input,output,session,system_id =  'O',module_id = 'O03')
    
     load_server(input,output,session,system_id =  'O',module_id = 'O04')
    
     load_server(input,output,session,system_id =  'O',module_id = 'O05')
    
     load_server(input,output,session,system_id =  'O',module_id = 'O06')
    
     load_server(input,output,session,system_id =  'O',module_id = 'O07')
    
     load_server(input,output,session,system_id =  'O',module_id = 'O08')
    
     load_server(input,output,session,system_id =  'O',module_id = 'O09')
    
     load_server(input,output,session,system_id =  'O',module_id = 'O10')
    
     load_server(input,output,session,system_id =  'P',module_id = 'P01')
    
     load_server(input,output,session,system_id =  'P',module_id = 'P02')
    
     load_server(input,output,session,system_id =  'P',module_id = 'P03')
    
     load_server(input,output,session,system_id =  'P',module_id = 'P04')
    
     load_server(input,output,session,system_id =  'P',module_id = 'P05')
    
     load_server(input,output,session,system_id =  'P',module_id = 'P06')
    
     load_server(input,output,session,system_id =  'P',module_id = 'P07')
    
     load_server(input,output,session,system_id =  'P',module_id = 'P08')
    
     load_server(input,output,session,system_id =  'P',module_id = 'P09')
    
     load_server(input,output,session,system_id =  'P',module_id = 'P10')
    
     load_server(input,output,session,system_id =  'Q',module_id = 'Q01')
    
     load_server(input,output,session,system_id =  'Q',module_id = 'Q02')
    
     load_server(input,output,session,system_id =  'Q',module_id = 'Q03')
    
     load_server(input,output,session,system_id =  'Q',module_id = 'Q04')
    
     load_server(input,output,session,system_id =  'Q',module_id = 'Q05')
    
     load_server(input,output,session,system_id =  'Q',module_id = 'Q06')
    
     load_server(input,output,session,system_id =  'Q',module_id = 'Q07')
    
     load_server(input,output,session,system_id =  'Q',module_id = 'Q08')
    
     load_server(input,output,session,system_id =  'Q',module_id = 'Q09')
    
     load_server(input,output,session,system_id =  'Q',module_id = 'Q10')
    
     load_server(input,output,session,system_id =  'R',module_id = 'R01')
    
     load_server(input,output,session,system_id =  'R',module_id = 'R02')
    
     load_server(input,output,session,system_id =  'R',module_id = 'R03')
    
     load_server(input,output,session,system_id =  'R',module_id = 'R04')
    
     load_server(input,output,session,system_id =  'R',module_id = 'R05')
    
     load_server(input,output,session,system_id =  'R',module_id = 'R06')
    
     load_server(input,output,session,system_id =  'R',module_id = 'R07')
    
     load_server(input,output,session,system_id =  'R',module_id = 'R08')
    
     load_server(input,output,session,system_id =  'R',module_id = 'R09')
    
     load_server(input,output,session,system_id =  'R',module_id = 'R10')
    
     load_server(input,output,session,system_id =  'S',module_id = 'S01')
    
     load_server(input,output,session,system_id =  'S',module_id = 'S02')
    
     load_server(input,output,session,system_id =  'S',module_id = 'S03')
    
     load_server(input,output,session,system_id =  'S',module_id = 'S04')
    
     load_server(input,output,session,system_id =  'S',module_id = 'S05')
    
     load_server(input,output,session,system_id =  'S',module_id = 'S06')
    
     load_server(input,output,session,system_id =  'S',module_id = 'S07')
    
     load_server(input,output,session,system_id =  'S',module_id = 'S08')
    
     load_server(input,output,session,system_id =  'S',module_id = 'S09')
    
     load_server(input,output,session,system_id =  'S',module_id = 'S10')
    
     load_server(input,output,session,system_id =  'T',module_id = 'T01')
    
     load_server(input,output,session,system_id =  'T',module_id = 'T02')
    
     load_server(input,output,session,system_id =  'T',module_id = 'T03')
    
     load_server(input,output,session,system_id =  'T',module_id = 'T04')
    
     load_server(input,output,session,system_id =  'T',module_id = 'T05')
    
     load_server(input,output,session,system_id =  'T',module_id = 'T06')
    
     load_server(input,output,session,system_id =  'T',module_id = 'T07')
    
     load_server(input,output,session,system_id =  'T',module_id = 'T08')
    
     load_server(input,output,session,system_id =  'T',module_id = 'T09')
    
     load_server(input,output,session,system_id =  'T',module_id = 'T10')
    
     load_server(input,output,session,system_id =  'U',module_id = 'U01')
    
     load_server(input,output,session,system_id =  'U',module_id = 'U02')
    
     load_server(input,output,session,system_id =  'U',module_id = 'U03')
    
     load_server(input,output,session,system_id =  'U',module_id = 'U04')
    
     load_server(input,output,session,system_id =  'U',module_id = 'U05')
    
     load_server(input,output,session,system_id =  'U',module_id = 'U06')
    
     load_server(input,output,session,system_id =  'U',module_id = 'U07')
    
     load_server(input,output,session,system_id =  'U',module_id = 'U08')
    
     load_server(input,output,session,system_id =  'U',module_id = 'U09')
    
     load_server(input,output,session,system_id =  'U',module_id = 'U10')
    
     load_server(input,output,session,system_id =  'V',module_id = 'V01')
    
     load_server(input,output,session,system_id =  'V',module_id = 'V02')
    
     load_server(input,output,session,system_id =  'V',module_id = 'V03')
    
     load_server(input,output,session,system_id =  'V',module_id = 'V04')
    
     load_server(input,output,session,system_id =  'V',module_id = 'V05')
    
     load_server(input,output,session,system_id =  'V',module_id = 'V06')
    
     load_server(input,output,session,system_id =  'V',module_id = 'V07')
    
     load_server(input,output,session,system_id =  'V',module_id = 'V08')
    
     load_server(input,output,session,system_id =  'V',module_id = 'V09')
    
     load_server(input,output,session,system_id =  'V',module_id = 'V10')
    
     load_server(input,output,session,system_id =  'W',module_id = 'W01')
    
     load_server(input,output,session,system_id =  'W',module_id = 'W02')
    
     load_server(input,output,session,system_id =  'W',module_id = 'W03')
    
     load_server(input,output,session,system_id =  'W',module_id = 'W04')
    
     load_server(input,output,session,system_id =  'W',module_id = 'W05')
    
     load_server(input,output,session,system_id =  'W',module_id = 'W06')
    
     load_server(input,output,session,system_id =  'W',module_id = 'W07')
    
     load_server(input,output,session,system_id =  'W',module_id = 'W08')
    
     load_server(input,output,session,system_id =  'W',module_id = 'W09')
    
     load_server(input,output,session,system_id =  'W',module_id = 'W10')
    
     load_server(input,output,session,system_id =  'X',module_id = 'X01')
    
     load_server(input,output,session,system_id =  'X',module_id = 'X02')
    
     load_server(input,output,session,system_id =  'X',module_id = 'X03')
    
     load_server(input,output,session,system_id =  'X',module_id = 'X04')
    
     load_server(input,output,session,system_id =  'X',module_id = 'X05')
    
     load_server(input,output,session,system_id =  'X',module_id = 'X06')
    
     load_server(input,output,session,system_id =  'X',module_id = 'X07')
    
     load_server(input,output,session,system_id =  'X',module_id = 'X08')
    
     load_server(input,output,session,system_id =  'X',module_id = 'X09')
    
     load_server(input,output,session,system_id =  'X',module_id = 'X10')
    
     load_server(input,output,session,system_id =  'Y',module_id = 'Y01')
    
     load_server(input,output,session,system_id =  'Y',module_id = 'Y02')
    
     load_server(input,output,session,system_id =  'Y',module_id = 'Y03')
    
     load_server(input,output,session,system_id =  'Y',module_id = 'Y04')
    
     load_server(input,output,session,system_id =  'Y',module_id = 'Y05')
    
     load_server(input,output,session,system_id =  'Y',module_id = 'Y06')
    
     load_server(input,output,session,system_id =  'Y',module_id = 'Y07')
    
     load_server(input,output,session,system_id =  'Y',module_id = 'Y08')
    
     load_server(input,output,session,system_id =  'Y',module_id = 'Y09')
    
     load_server(input,output,session,system_id =  'Y',module_id = 'Y10')
    
     load_server(input,output,session,system_id =  'Z',module_id = 'Z01')
    
     load_server(input,output,session,system_id =  'Z',module_id = 'Z02')
    
     load_server(input,output,session,system_id =  'Z',module_id = 'Z03')
    
     load_server(input,output,session,system_id =  'Z',module_id = 'Z04')
    
     load_server(input,output,session,system_id =  'Z',module_id = 'Z05')
    
     load_server(input,output,session,system_id =  'Z',module_id = 'Z06')
    
     load_server(input,output,session,system_id =  'Z',module_id = 'Z07')
    
     load_server(input,output,session,system_id =  'Z',module_id = 'Z08')
    
     load_server(input,output,session,system_id =  'Z',module_id = 'Z09')
    
     load_server(input,output,session,system_id =  'Z',module_id = 'Z10')
     
     
     
     
     
     

   
   
   
  
})
