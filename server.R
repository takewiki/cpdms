
#shinyserver start point----
 shinyServer(function(input, output,session) {
   

    #00-基础框设置-------------
    #读取用户列表
    user_base <- getUsers(app_id = app_id)
    
    
    
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
          res <-tsui::userQueryField(app_id = app_id,user =user_info()$Fuser,key = fkey)
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
      tstk::debug_print('menu test start ')
       res <- tsui::menu_getItemData(app_id =app_id,permission = user_info()$Fpermissions )
       tstk::debug_print('menu test end ')
       return(res)
    })
    
    
    #针对侧边栏进行控制
    output$show_sidebarMenu <- renderUI({
       if(credentials()$user_auth){
         tstk::debug_print('menu call start ')
         res = sidebarMenu()
         tstk::debug_print('menu call end ')
          return(res)
       } else{
          return(NULL) 
       }
       
       
    })
    
    #针对工作区进行控制---------
    output$show_workAreaSetting <- renderUI({
       if(credentials()$user_auth){
         tstk::debug_print('menu call start 2')
         res = workAreaSetting
         tstk::debug_print('menu call end 2')
         
       
          return(res)
         
       } else{
          return(NULL) 
       }
       
       
    })
    
   
    
    #针对功能进行处理
    observeEvent(input$prdGen_more_button,{
      
      shinyjs::disable(id = 'prdGen_more_button')
      
      role_name = user_info()$Fpermissions
      
      mdlMultipleMaterialServer::tabPanel_initial_Server(input,output,session,conn_cfg,app_id,role_name )
      
      
    })
    
    

    

  
      

  
    
    ncount_module  =nrow(module_data)
    lapply(1:ncount_module, function(i){
      load_server0(input,output,session,module_id = module_id[i],app_id = app_id)
    })
    
    #针对账进行设置
    #针对对账单据的功能进行设置
    #mdlSalesReconciliationServer::dzd_init_query_server(input=input,output = output,session = session,dms_token = dms_token)
    
    #mdlSalesReconciliationServer::dzd_init_update_server(input=input,output = output,session = session,erp_token = erp_token)
    #对账单初始设置查询
    var_cp_dzd_initData_file <- var_file('cp_dzd_initData_file')
    shiny::observeEvent(input$dzd_initData_query,{
      file_name = var_cp_dzd_initData_file()
      if(is.null(file_name)){
        pop_notice('请选择一个文件')
      }else{
        data = cprdspkg::dzd_initData_read(file_name = file_name,lang = 'cn')
        tsui::run_dataTable2(id = 'dzd_initData_dataView',data = data)
      }
      
    })
    #对账单初始设置更新
    shiny::observeEvent(input$dzd_initData_update,{
      file_name = var_cp_dzd_initData_file()
      if(is.null(file_name)){
        pop_notice('请选择一个文件')
      }else{
        data = cprdspkg::dzd_initData_read(file_name = file_name,lang = 'en')
        ncount = nrow(data)
        if(ncount >0){
          try({
            cprdspkg::dzd_initData_updateAll2(erp_token = erp_token,data = data)
            pop_notice('更新成功')
          })
        }else{
          pop_notice('更新失败')
          
        }
        
      }
      
      
    })
    
    
    
  
  
})
