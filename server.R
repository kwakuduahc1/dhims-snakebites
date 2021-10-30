library(shiny)
shinyServer(function(input, output, env) {
    output$belt <- renderPlot(belt())
    
    reg <- reactive({input$regions}) %>% 
      bindCache(input$regions) %>% 
      bindEvent(input$regions,{
        if(input$regions %>% length() >5){
          toast(class = "ui toast yellow", "More than 5 regions selected", 
                title = "Notification", duration = 5)
        }
      })
    
    output$age_gender <- renderPlot(demos(reg())$yg)
    output$year_gender <- renderPlot(demos(reg())$ag)
    output$age_gen_mon <- renderPlot(demos(reg())$agm)
})
