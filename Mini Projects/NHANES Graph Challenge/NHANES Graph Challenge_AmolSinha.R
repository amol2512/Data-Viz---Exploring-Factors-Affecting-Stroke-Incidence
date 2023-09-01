#NHANES Graph Challenge 

rm(list=ls())
library(NHANES)
library(ggplot2)
x<-NHANES[!is.na(NHANES$Education), ]
x<-x[!is.na(x$TotChol), ]
x<-x[!is.na(x$Gender), ]
x<-x[!is.na(x$Poverty), ]
x<-x[!is.na(x$BMI), ]

#1
d<-ggplot(x,aes(x=Poverty, y=BMI, color=Diabetes))+ geom_point()
e<-d + geom_smooth(method=lm) 
e+ facet_grid(Gender ~ SurveyYr)+scale_colour_discrete(na.translate = F)+ 
scale_color_manual(values = c("No" = "indianred1", "Yes"="chartreuse1"))

#2
?NHANES
b<-ggplot(x)+ geom_boxplot(aes(x=TotChol, y=Education, colour=Diabetes))
b + facet_grid(. ~ Gender) +scale_colour_discrete(na.translate = F)+
  scale_color_manual(values = c("No" = "aquamarine4", "Yes"="khaki3"))
