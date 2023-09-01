library(ggplot2)
library(scales)
library(dplyr)
library(readxl)
library(ggthemes)
hotdogs <- read.csv("http://datasets.flowingdata.com/hot-dog-contest-winners.csv")
hotdogs <- hotdogs %>% 
  mutate(mycolor = ifelse(Country=='United States', "Yes",'No'))
barplot<-ggplot(data=hotdogs,aes(x=Year, y=Dogs.eaten,fill=mycolor)) +
  geom_bar( stat="identity")+
  scale_fill_manual( values = c("Yes" = "#821122", 'No'=NA ))+
  theme_classic()+
  theme(legend.position = "none")+
  labs(x="Year",y="Hot dogs and buns(HDB) eaten")+
  scale_x_continuous(breaks = seq(1980, 2008, 4), limits = c(1979, 2011))+
  scale_y_continuous(breaks = c(0, 10, 30, 50), limits = c(0,80))
barplot
