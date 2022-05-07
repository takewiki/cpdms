print('global')
## global.R ##
# 加载R包-----
enableBookmarking(store = "url")
library(shiny);
library(shinydashboard);
library(tsda);
library(tsdo);
library(tsui);
library(dplyr)
library(shinyjs)
library(glue)
library(shinyauthr)
library(digest)
library(shinyWidgets)
library(tsai);
library(shinyalert);
library(rclipboard);
library(DTedit);

# for ui----
library(mdlMultipleMaterialUI);

#for server
library(mdlMultipleMaterialServer)


source('00_data.R',encoding = 'utf-8')












