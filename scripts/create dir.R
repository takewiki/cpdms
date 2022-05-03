base_dir = getwd()
conn_be <- tsda::conn_rds('rdbe')
sql <-"SELECT  [Fshow]
      ,[Fname]
      ,[Fid]
      ,[Ficon]
      ,[Fpermissions]
      ,[Ftype]
      ,[FparentId]
      ,[Findex]
      ,[FappId]
  FROM [rdbe].[dbo].[t_md_objectRight] where Ftype ='module'"
data = tsda::sql_select(conn_be,sql)
View(data)

sub_dir = data$Fname
parent_dir = data$FparentId

dir_all =  paste0(base_dir,'/modules','/',parent_dir,'/',sub_dir)
dir_all
res = lapply(dir_all, function(item){
  flag = !dir.exists(item)
  print(flag)
  if(flag){
    dir.create(item)
  }
})

res[[1]]

file_servers = paste0(dir_all,"/",sub_dir,"_server.R")
file_servers

res_server = lapply(file_servers, function(item){
  flag = !file.exists(item)
  print(flag)
  if(flag){
    file1 =  file(item)
    writeLines('NULL',file1)
    close(file1)
  }
})




file_ui = paste0(dir_all,"/",sub_dir,"_ui.R")
file_ui

res_ui = lapply(file_ui, function(item){
  flag = !file.exists(item)
  print(flag)
  if(flag){
    file.copy('B10_ui.R',item)
  }
})



res_ui = lapply(file_ui, function(item){
 
    file.edit(item)

})


data


cat(paste0("load_ui(sytem_id = '",parent_dir,"',module_id = '",sub_dir,"')",collapse = ",\n"))





cat(paste0("load_server(input,output,session,system_id =  '",parent_dir,"',module_id = '",sub_dir,"')",collapse = "\n\n"))








