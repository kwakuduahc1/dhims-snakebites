library(shiny)
shinyServer(function(input, output, env) {
    output$belt <- renderPlot(belt())
    output$age_gender <- renderPlot(age_gender())
    output$age_gen_mon <- renderPlot(age_gen_mon())
    
    # observeEvent(input$regions,{
    #   print(input$regions)
    # })
    
    reg <- reactive({input$regions}) %>% 
      bindCache(input$regions) %>% 
      bindEvent(input$regions,{
        if(input$regions %>% length() >5){
          toast(class = "ui toast yellow", "More than 2 regions selected", 
                title = "Notification", duration = 5)
        }
      })
    
    output$year_gender <- renderPlot(year_gender(reg()))
})
