library(data.table)
library(dplyr)
recipe<-load('Recipe.RData')
datarbind<-rbindlist(Recipe)
df_all<-datarbind %>% group_by(id,cuisine)%>%summarise(ingredients=paste(ingredients,collapse=','))


library(shiny)
ui <- fluidPage(
  titlePanel("Decide what to eat!"),
  sidebarLayout(
    sidebarPanel(selectizeInput(
      inputId = "CuisineFinder",
      label = "Select cuisine(s):",
      choices = c("Brazilian" = "brazilian", 
                  "British" = "british",
                  "Cajun Creole" = "cajun_creole",
                  "Chinese" = "chinese",
                  "Filipino" = "filipino",
                  "French" = "french",
                  "Greek" = "greek", 
                  "Indian" = "indian",
                  "Irish" = "irish", 
                  "Italian" = "italian",
                  "Jamaican" = "jamaican", 
                  "Japanese" = "japanese", 
                  "Korean" = "korean", 
                  "Mexican" = "mexican",
                  "Moroccan" = "moroccan", 
                  "Russian" = "russian",
                  "Southern US" = "southern_us",
                  "Spanish" = "spanish",
                  "Thai" = "thai",
                  "Vietnamese" = "vietnamese"),
      selected = "british",
      multiple = T,
      options = list(plugins = list('remove_button')),
    )),
    mainPanel(DT::dataTableOutput("table"))
  ))

server <- function(input, output){
  output$table <- DT::renderDataTable(DT::datatable({
    data <- df_all
    data <- data[data$cuisine == input$CuisineFinder,]
    data
  }))
}
shinyApp(ui, server)