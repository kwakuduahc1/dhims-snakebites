library(shiny)
shinyServer(function(input, output, env) {
    # output$belt <- renderPlot(belt())
    
    reg <- reactive(input$regions) %>% 
      bindCache(input$regions) %>% 
      bindEvent(input$regions)
    
    yrs <- reactive(input$years) %>% 
      bindCache(input$years) %>% 
      bindEvent(input$years)
    
    output$age_gender <- renderPlot(demos(reg(), yrs())$ag)
    output$gens <- renderPlot(demos(reg(), yrs())$g)
    output$month_gender <- renderPlot(demos(reg(), yrs())$mg)
    output$age_gen_mon <- renderPlot(demos(reg(), yrs())$agm)
})
