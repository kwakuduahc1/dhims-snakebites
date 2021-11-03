# Load libraries and data -------------------------------------------------
library(DBI)
library(tidyverse)
library(ggpubr)
library(flextable)
library(ggthemes)
bites <- read_rds("bites.rds")
my_com <- scale_y_continuous(labels = scales::comma_format())

# Cases by region and gender ----------------------------------------------
# bites %>% 
#   group_by(Region, Gender) %>% 
#   summarise(Cases = sum(Number)) %>% 
#   arrange(Cases) %>% 
#   ggbarplot(x = "Region", y = "Cases", fill = "Gender", palette = palette_pander(n = 2)) + coord_flip() + my_com
# 
# 
# Yearly trend ------------------------------------------------------------
demos <- function(belt, years){
  if(is_null(belt) | belt == "All"){
    tmp <- bites
  }
  else{
    tmp <- bites %>% 
      filter(Belt == belt)
  }
  
  tmp <- tmp %>% 
    filter(Year %in% years)
  
  gens <- tmp %>% 
    count(Gender) %>% 
    ggdonutchart(x= "n", label = "Gender", fill = "Gender", lab.pos = "out", lab.font = c(0, "italize", "green"), lab.adjust = .2, palette = palette_pander(n = 2)) + theme(legend.position = "none")
  
  mon_gen <- tmp %>%
    group_by(Month, Gender) %>%
      mutate(
        Month = factor(Month, labels = month.abb, levels = 1:12)
      ) %>% 
    summarise(Number = sum(Number), .groups = "keep") %>%
    ggline(x="Month", y = "Number", group = "Gender", color = "Gender",
         palette = "startrek") + my_com
  
  # Monthly trend by age ----------------------------------------------------
  age_gen_mon <- tmp %>% 
      group_by(Month, AgeGroup, Gender) %>% 
      summarise(Number = sum(Number), .groups = "keep") %>% 
      mutate(
        Month = factor(Month, labels = month.abb, levels = 1:12)
      ) %>% 
      ggline(x = "Month", y="Number", color = "AgeGroup", palette = "pander", facet.by = "Gender") +
      my_com
  
  # Age and gender ----------------------------------------------------------
  age_gender <- tmp %>% 
      group_by(AgeGroup, Gender) %>% 
      summarise(Cases = sum(Number), .groups = "keep") %>% 
      ggbarplot(x = "AgeGroup", y = "Cases", fill = "Gender", palette = "startrek", facet.by = "Gender")  + 
    theme(
      legend.position = "none"
    ) + 
      my_com
  
  tbl <- tmp %>% group_by(Region) %>% 
    summarise(
      Cases = sum(Number)
      ) %>% 
    mutate(
      Cases = str_glue( "{Cases} ({round(Cases/sum(Cases) * 100,1)}%)")
    ) %>% 
    flextable()%>%
    theme_tron() %>%
    autofit() %>%
    htmltools_value()
  return(list(ag = age_gender, agm = age_gen_mon, mg =mon_gen, g = gens, t = tbl))
}
# 
# 
# 
# # Month-year trend --------------------------------------------------------
# 
# bites %>% 
#   group_by(Month, Year) %>% 
#   summarise(Number = sum(Number)) %>% 
#   mutate(
#     Month = factor(Month, labels = month.abb, levels = 1:12),
#     Year = as.factor(Year)
#     ) %>% 
#   ggline(x = "Month", y="Number", color = "Year", palette = palette_pander(n = 5)) +
#   my_com
#      




# Bites by sector ---------------------------------------------------------
belt <- reactive({
bites %>% 
  group_by(Belt, Gender) %>% 
  summarise(Cases =  sum(Number)) %>% 
  ggbarplot(x = "Belt", y = "Cases", fill = "Gender", position = position_dodge(),  palette = palette_pander(n = 2)) + my_com
  })

# bites %>% 
#   group_by(Belt, AgeGroup) %>% 
#   summarise(Cases =  sum(Number)) %>% 
#   ggbarplot(x = "Belt", y = "Cases", fill = "AgeGroup", position = position_dodge(),  palette = palette_pander(n = 5)) + my_com
# 
# 
# bites %>% 
#   group_by(Belt, AgeGroup, Gender) %>% 
#   summarise(Cases =  sum(Number)) %>% 
#   ggbarplot(x = "Belt", y = "Cases", fill = "Gender", position = position_dodge(),  palette = palette_pander(n = 2), facet.by = "AgeGroup") + my_com
# 

# setDems <- function(regs, years = c(2016:2020)){
#   print(regs)
#   print(years)
# }
