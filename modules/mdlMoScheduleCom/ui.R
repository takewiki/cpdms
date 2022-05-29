#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#


# Define UI for application that draws a histogram
shinyUI(
    dashboardPage(
        dashboardHeader(title = tsui::module_title(module_id = module_id),titleWidth = '500px'),
        dashboardSidebar(
            sidebarMenu(
               
                menuItem("Widgets", tabName = module_id, icon = icon("th"))
            )
        ),
        dashboardBody(
            tsui::use_pop(),
            tabItems(
              
              
                tsui::module_ui(module_id = module_id)
            )
        )
    )

)
