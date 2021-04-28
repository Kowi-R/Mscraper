#install.packages("rvest")
#install.packages("glue")
#install.packages("stringr")
#install.packages("lubridate")
#install.packages("knitr")
#install.packages("kableExtra")
#install.packages("dplyr")
#############
library(tidyverse)
library(rvest)
library(glue)
library(stringr)
library(lubridate)
library(knitr)
library(kableExtra)
library(dplyr)
################

#Main link
link_g = "https://en.wikipedia.org/wiki/Category:Polish_footballers"
main = read_html(link_g)
name = main %>% html_nodes(".mw-category-group a")%>% 
  html_text

#player links maker
player_links = main %>% html_nodes(".mw-category-group a")%>% 
  html_attr("href") %>% paste("https://en.wikipedia.org", .,sep = "")
player_links


#Table-vcard scraping function


get_table = function(player_link) {
  player_page = read_html(player_link)
  #data urodzenia
  table = player_page %>% html_nodes(".vcard")%>% html_text %>% paste(collapse = ",")
  return(table)
}

table = sapply(player_links, FUN = get_table)
jajo<-data.frame(name, table, stringsAsFactors = FALSE)

#install.packages("xlsx")
library("xlsx")
write.xlsx(jajo, file = "C:/Users/dom/Desktop/PRACA MAGISTERSKA/Baza Danych/jajo3.xlsx")
