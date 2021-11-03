library(shiny)
shinyServer(function(input, output, env) {
    # output$belt <- renderPlot(belt())
    
    reg <- reactive(input$regions) %>% 
      bindCache(input$regions, input$years) %>% 
      bindEvent(input$regions)
    
    yrs <- reactive(input$years) %>% 
      bindCache(input$years, input$regions) %>% 
      bindEvent(input$years)
    
    dset <- reactive({
      demos(reg(), yrs())
    })
    
    output$gens <- renderPlot(dset()$g)
    output$age_gender <- renderPlot(dset()$ag)
    output$month_gender <- renderPlot(dset()$mg)
    output$age_gen_mon <- renderPlot(dset()$agm)
    output$tbl <- renderUI(dset()$t)
    output$smry <- renderText(read_file("description.txt"))
})
