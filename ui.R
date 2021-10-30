library(shiny)
library(shiny.semantic)

source("Edd.R")
regs <- unique(bites$Belt) %>% sort()
semanticPage(
    title = "Snakebites in Ghna",
    h1(class = "ui header teal centered", icon_name = "dog", "Snakebites in Ghana from the DHIMS database"),
    grid(
        grid_template(
            default = list(
                areas = rbind(c("btns", "conts")))
            ),
        cols_width = c("10%", "90%"),
        btns = div(
            h2("Parameters", class = "ui header left"),
            selectInput("regions", "Sector:",selected = "All", choices =  c("All", regs)),
            br(),
            shinyWidgets::numericRangeInput(inputId = "years", label = "Years", separator = " - ", width = "5%" ,step = 1, value = c(2016,2020), min = 2016, max = 2020)
            ),
        conts = div(
            tabset(
                tabs = list(
                    list(menu = "Demographics", id = "tb_dem",
                         content = grid(
                             class="ui two column very relaxed stackable grid",
                             grid_template( 
                                 default = list(
                                     areas = rbind(
                                         c("top1", "top2"),
                                         c("bot1", "bot2")
                                         ),
                                     rows_height = c("50%", "50%"),
                                     cols_width = c("45%", "55%")
                                     )
                                 ),
                             top1 = div(
                                 h2("Reported cases by sex", class = "ui header centered violet"),
                                 plotOutput("gens")
                             ),
                             top2 = div(
                                 h2("Trend of snakebites from 2016 to 2020", class = "ui header centered orange"),
                                 plotOutput("month_gender")
                                 ),
                             bot1 = div(
                                 h2("Reported cases by age and gender", class = "ui header centered orange"),
                                 plotOutput("age_gender")
                                 ),
                             bot2 = div(
                                 h2("Montly reported of snakebites by age and gender", class = "ui header centered violet"),
                                 plotOutput("age_gen_mon")
                                 )
                             )
                         ),
                    list(menu = "Tables", id = "tbls",
                         content = div("Tables")
                    )
                )
            )
        )
    )
)