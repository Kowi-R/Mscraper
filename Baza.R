install.packages("rvest")
install.packages("glue")
install.packages("stringr")
install.packages("lubridate")
install.packages("knitr")
install.packages("kableExtra")
install.packages("dplyr")
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


link_g = "https://en.wikipedia.org/wiki/Category:Polish_footballers"
main = read_html(link_g)
name = main %>% html_nodes(".mw-category-group a")%>% 
  html_text

#LISTA LINKOW DO KAZDEGO KOLEJNEGO
player_links = main %>% html_nodes(".mw-category-group a")%>% 
  html_attr("href") %>% paste("https://en.wikipedia.org", .,sep = "")
player_links


#FUNKCJA ZBIERAJACA TABELE


get_table = function(player_link) {
  player_page = read_html(player_link)
  #data urodzenia
  table = player_page %>% html_nodes(".vcard")%>% html_text %>% paste(collapse = ",")
  return(table)
}
#FUNKCJA ZBIERAJACA URODZINY


get_birth = function(player_link) {
  player_page = read_html(player_link)
  #data urodzenia
  birth = player_page %>% html_nodes(".vcard tr:nth-child(4) td")%>% html_text()
  return(birth)
}

#FUNKCJA ZBIERAJACA MIEJSCA URODZIN

get_place = function(player_link) {
  player_page = read_html(player_link)
  #miejsce urodzenia
  place = player_page %>% html_nodes(".birthplace")%>% html_text
  return(place)
}


#FUNKCJA ZBIERAJACA DATE DEBIUTU


get_debutdate = function(player_link) {
  player_page = read_html(player_link)
  #data debiutu
  debutdata = player_page %>% html_nodes("tr:nth-child(15) span")%>% html_text()
  return(debutdata)
  }

#FUNKCJA ZBIERAJACA KLUB DEBIUTU

get_debutclub = function(player_link) {
  player_page = read_html(player_link)
  #data debiutu
  debutclub = player_page %>% html_nodes(".vcard tr:nth-child(15) a")%>% html_text()
  return(debutclub)
}
birth = sapply(player_links, FUN = get_birth)
place = sapply(player_links, FUN = get_place)
data.debiutu = sapply(player_links, FUN = get_debutdate)
klub.debiutu = sapply(player_links, FUN = get_debutclub)
table = sapply(player_links, FUN = get_table)
jajo<-data.frame(name, table, stringsAsFactors = FALSE)

write.table(jajo, file = "C:/Users/dom/Desktop/PRACA MAGISTERSKA/Baza Danych/jajo2.xlsx")
install.packages("xlsx")
library("xlsx")
write.xlsx(jajo, file = "C:/Users/dom/Desktop/PRACA MAGISTERSKA/Baza Danych/jajo3.xlsx")
