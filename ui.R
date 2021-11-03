library(shiny)
library(shiny.semantic)
library(shinyWidgets)

source("Edd.R")
regs <- unique(bites$Belt) %>% sort()

semanticPage(
  theme = "superhero",
  title = "Snakebites in Ghna",
  h1(class = "ui header teal centered", "Snakebites in Ghana"),
  div(
    class = "ui grid vertically divided",
    div(
      class = "three wide column",
      h2("Parameters", class = "ui header left"),
      div(
        class = "row",
        selectInput(
          "regions",
          "Sector:",
          selected = "All",
          choices =  c("All", regs)
        )
      ),
      div(
        class = "row",
        numericRangeInput(
          inputId = "years",
          label = "Years",
          separator = "",
          step = 1,
          value = c(2016, 2020),
          min = 2016,
          max = 2020
        )
      ),
      div(class = "row",
          uiOutput("tbl")
      ),
      div(class = "row",
          htmlOutput("smry"))
    ),
    div(class = "thirteen wide column my_menu",
        div(
          class = "ui grid",
          div(
            class = "row",
            div(
              class = "six wide column ",
              h2("Reported cases by sex", class = "ui header centered orange"),
              plotOutput("gens")
            ),
            div(
              class = "ten wide column ",
              h2("Trend of snakebites from 2016 to 2020", class = "ui header centered orange"),
              plotOutput("month_gender")
            )
          ),
          div(
            class = "row",
            div(
              class = "seven wide column",
              h2("Reported cases by age and gender", class = "ui header centered orange"),
              plotOutput("age_gender")
            ),
            div(
              class = "nine wide column",
              h2("Montly reported of snakebites by age and gender", class = "ui header centered orange"),
              plotOutput("age_gen_mon")
            )
          )
        ))
  ),
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")
  )
)