library(shiny)
library(shiny.semantic)

source("Edd.R")
regs <- unique(bites$Region) %>% sort()
semanticPage(
    title = "Snakebites in Ghna",
    h1(class = "ui header teal centered", "Snakebites in Ghana from the DHIMS database"),
    tabset(
        tabs = list(
            list(menu = "Demographics", id = "tb_dem", 
                 content = grid(
                     grid_template(
                         default = list(
                             areas = rbind(
                                 c("head1", "head2"),
                                 c("top1", "top2"),
                                 c("bot1", "bot2")
                                 ),
                             rows_height = c("5%", "15%", "15%"),
                             cols_width = c("40%", "60%")
                             )
                         ), 
                     head1 = div(
                         selectInput("regions", "Regions:",selected = "All",
                                     c("All", regs), multiple = T, width = "50%")
                     ),
                     head2 = div(
                         # selectInput("regions", "Regions:",
                         #             c("All", regs), multiple = T, width = "50%")
                     ),
                     top1 = div(
                         h2("Reported cases by area", class = "ui header centered violet"),
                         plotOutput("belt")
                     ), 
                     top2 = div(
                         h2("Trend of snakebites from 2016 to 2020", class = "ui header centered orange"),
                         plotOutput("year_gender")
                         ),
                     bot1 = div(
                         h2("Reported cases of snakebites by age and gender", class = "ui header centered orange"),
                         plotOutput("age_gender")
                         ),
                     bot2 = div(
                         h2("Montly reported of snakebites by age and gender", class = "ui header centered violet"),
                         plotOutput("age_gen_mon")
                         ),
                     bot3 = div(
                         
                     )
                     )
                 )
            )
        )
)