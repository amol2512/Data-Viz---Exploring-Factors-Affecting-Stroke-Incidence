# Installation of packages
install.packages(c("GGally", "psych", "skimr", "janitor", "gridExtra"))

# Loading necessary libraries
library(tidyverse)
library(psych)
library(dplyr)
library(GGally)
library(lubridate)
library(skimr)
library(janitor)
library(readr)
library(ggplot2)
library(gridExtra)

# List available files in the input directory
list.files(path = "../input")

# Reading dataset
df <- read.csv("D:/healthcare-dataset-stroke-data.csv")

# Viewing the first few rows
head(df)

# Structure of the dataset
str(df)

# Handle missing values and type conversions
df$bmi <- ifelse(df$bmi == 'N/A', NA, df$bmi)
df$bmi <- as.numeric(df$bmi)

# Factor conversions and value labeling
df$stroke_t <- factor(ifelse(df$stroke == 1, 'stroke', 'no stroke'))
df$hypertension <- factor(ifelse(df$hypertension == 1, 'hypertension', 'no hypertension'))
df$heart_disease <- factor(ifelse(df$heart_disease == 1, 'heart disease', 'no heart disease'))

df <- transform(df, bmi= as.double(bmi))
df$stroke <- as.factor(df$stroke)

# Clean column names
df <- clean_names(df)
names(df)

# Grouping and summarization
for (col_name in colnames(df[sapply(df, function(x) !(is.numeric(x)))])){
  output <- df %>%
    group_by(!!sym(col_name)) %>%
    summarise(
      stroke_share = round(mean(stroke), 3),
      n = n(),
      n_strokes = sum(stroke == 1)
    )
  View(output)
}

n_unique(df$id)

# Set figure dimensions
fig <- function(width, heigth){
  options(repr.plot.width = width, repr.plot.height = heigth)
}

# Various plots for EDA
# ... (This section contains multiple ggplot() commands from your code, which I've not replicated here due to space constraints.)

# Example:
ggplot(df) + geom_point(mapping = aes(y = age, x = stroke, color = stroke ), alpha =0.9 )+ 
  labs(title = "Distribution of Stroke status by age" ) +
  theme( plot.title = element_text(size = 14, face = "bold"), legend.position = "none", axis.line = element_line(size = 1), axis.ticks = element_line() )

# Calculations for age and stroke relationship
s_dev <- sd(df$age)
mean_stroke <- mean(df$age)

lower_limit <- (mean_stroke - s_dev)
upper_limit <- (mean_stroke + s_dev)
prob_under_lower <- pnorm(q = -lower_limit, mean = mean_stroke, sd = s_dev)

# Graphical Code Misc


str(df)

df <- transform(df, bmi= as.double(bmi))

df$stroke <- as.factor(df$stroke)
df$hypertension <- as.factor(df$hypertension)
df$heart_disease <-factor(df$heart_disease)

for (col_name in colnames(df[sapply(df, function(x) !(is.numeric(x)))])){
  output <- df %>%
    group_by(!!sym(col_name)) %>%
    summarise(
      stroke_share = round(mean(stroke), 3),
      n = n(),
      n_strokes = sum(stroke == 1)
    )
  View(output)
}

n_unique(df$id)
df <- clean_names(df)
names(df)

df %>% group_by(stroke) %>% summarise(patients = n()) %>%  
  mutate(total = sum(patients), percent = scales::percent(patients/total))

df %>%
  select(age, avg_glucose_level, bmi, smoking_status, heart_disease) %>%
  drop_na() %>%
  ggpairs()

s_dev <- sd(df$age)
mean_stroke <- mean(df$age)

View(s_dev)
View(mean_stroke)

lower_limit <- (mean_stroke - s_dev)
upper_limit <- (mean_stroke + s_dev)
View(lower_limit)
View(upper_limit)

prob_under_lower <- pnorm(
  q = -lower_limit, 
  mean = mean_stroke, 
  sd = s_dev)
View(prob_under_lower)


prob_over_upper <- pnorm(
  q = upper_limit, 
  mean = mean_stroke, 
  sd = s_dev)
View(prob_over_upper)

between_prob <- 1-(prob_under_lower+prob_over_upper)
View(between_prob)

df %>% 
  group_by(gender, smoking_status) %>% 
  summarise(n = n()) %>% 
  ggplot(aes(x = gender, y = n, fill = smoking_status)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Gender-wise Smoking Distribution", 
       x = "Gender", y = "Number of Patients", 
       fill = "Smoking Status")


ggplot(df, aes(age, color = gender)) + geom_blank() + stat_function(fun = dnorm, args = c(mean = mean_stroke, sd = s_dev)) + facet_wrap(~gender)

ggplot(data = df, mapping = aes(x = stroke)) +
  geom_bar(aes(fill = stroke)) + 
  theme(  axis.ticks = element_blank(), panel.grid = element_blank(), ) + 
  scale_fill_manual(values = c("lightblue", "lightpink")) 
  labs(title = "Distribution of stroke among patients", x = "stroke", y = "count" ) +
  theme( plot.title = element_text(size = 14, face = "bold"), legend.position = "none", axis.line = element_line(size = 1), axis.ticks = element_line() ) + scale_fill_viridis_d()

  ggplot(data = df, aes(x = stroke)) +
    geom_bar(aes(fill = stroke)) +
    theme(axis.ticks = element_blank(), panel.grid = element_blank()) + 
    scale_fill_manual(values = c("lightblue", "lightpink")) +
    labs(title = "Distribution of stroke among patients", x = "stroke", y = "count") +
    theme(plot.title = element_text(size = 14, face = "bold"), 
          legend.position = "none", 
          axis.line = element_line(size = 1), 
          axis.ticks = element_line()) + 
    scale_fill_viridis_d() +
    geom_text(stat = 'count', aes(label = paste0(round(..count../sum(..count..)*100), "%\n", "(" , ..count.., ")")),
              position = position_stack(vjust = 0.5), color = "white")
  
 
  ggplot(data = df, aes(x = stroke)) +
    geom_bar(aes(fill = stroke), position = "dodge") +
    scale_fill_manual(values = c("lightblue", "lightpink")) +
    labs(title = "Distribution of Stroke Among Patients", x = "Stroke", y = "Count") +
    theme_minimal() +
    theme(
      plot.title = element_text(size = 14, face = "bold"),
      axis.line = element_line(size = 1),
      axis.ticks = element_line(),
      legend.position = "bottom"
    ) +
    geom_text(aes(label = paste0(round((..count..)/sum(..count..)*100), "%"), y = ..count..), 
              stat = "count", 
              position = position_stack(vjust = 0.5), 
              size = 4, 
              color = "white") +
    coord_flip()
  
  
  
    
ggplot(df) + geom_density(mapping = aes(x = age, fill = stroke, color = stroke ), alpha =0.5 )+ 
    theme(  axis.ticks = element_blank(), panel.grid = element_blank(), ) + 
    labs(title = "Density distribution of stroke cases by age") +
    theme( plot.title = element_text(size = 14, face = "bold"), axis.line = element_line(size = 1), axis.ticks = element_line() )
  
  
ggplot(df) + geom_point(mapping = aes(y = age, x = stroke, color = stroke ), alpha =0.9 )+ 
    labs(title = "Distribution of Stroke status by age" ) +
    theme( plot.title = element_text(size = 14, face = "bold"), legend.position = "none", axis.line = element_line(size = 1), axis.ticks = element_line() ) 


stroke_bmi <- df %>% filter(!is.na(bmi), stroke == 1) %>%  mutate(bmi_category = case_when(bmi < 18.5 ~ "Underweight", 
                                                                                                 bmi >= 18.5 & bmi < 25 ~ "Healthy", 
                                                                                                 bmi >= 25 & bmi < 30 ~ 'Overweight' , bmi >= 30 ~ "Obesity")) %>% 
  group_by(bmi_category) %>% summarise(people = n()) %>%  mutate(total = sum(people), percent = people / total) %>% 
  ggplot() + geom_col(mapping = aes(x= bmi_category, y = percent, fill = bmi_category)) + scale_y_continuous(labels =  scales::percent_format(accuracy = 1)) +
  labs(title = "Stroke Patients by Bmi Category") + 
  theme(axis.title  = element_blank(), axis.text.x = element_blank() ) +
  scale_fill_brewer(palette = "Dark2")+
  theme( plot.title = element_text(size = 14, face = "bold"),  axis.line = element_line(size = 1), axis.ticks = element_line() )

nstroke_bmi <- df %>% filter(!is.na(bmi), stroke == 0) %>%  mutate(bmi_category = case_when(bmi < 18.5 ~ "Underweight", 
                                                                                                 bmi >= 18.5 & bmi < 25 ~ "Healthy", 
                                                                                                 bmi >= 25 & bmi < 30 ~ 'Overweight' , bmi >= 30 ~ "Obesity")) %>% 
  group_by(bmi_category) %>% summarise(people = n()) %>%  mutate(total = sum(people), percent = people / total) %>% 
  ggplot() + geom_col(mapping = aes(x= bmi_category, y = percent, fill = bmi_category)) + scale_y_continuous(labels =  scales::percent_format(accuracy = 1)) +
  labs(title = "Non_Stroke Patients by Bmi Category") + 
  theme(axis.title  = element_blank(),  axis.text.x = element_blank(), legend.position = "None" ) +
  scale_fill_brewer(palette = "Dark2")+
  theme( plot.title = element_text(size = 14, face = "bold"),  axis.line = element_line(size = 1), axis.ticks = element_line() )

grid.arrange(stroke_bmi, nstroke_bmi, ncol = 1)


ggplot(df) + geom_density(mapping = aes(x = avg_glucose_level, fill = stroke, color = stroke ), alpha =0.5)+ 
  theme(  axis.line =  element_line(size = 1), panel.grid = element_blank(),plot.title = element_text(size = 14, face = "bold"))  +
  labs(title = "Density Relationship Between Glucose Levels and Stroke chances") 


df %>% 
  filter(!smoking_status == "Unknown") %>%  
  ggplot(mapping = aes(x = smoking_status, fill = smoking_status)) + 
  geom_bar() + 
  facet_wrap(~stroke, switch = "x") + 
  theme_minimal() +
  theme(axis.text.x = element_blank(), 
        axis.ticks.x  = element_blank(), 
        panel.border = element_blank(), 
        panel.grid = element_blank(), 
        axis.line = element_line(size = 1.2)) +
  labs(title = 'Effect of smoking on stroke',x = "Stroke") + 
  scale_y_continuous(breaks = seq(0, 2000, 250)) +
  theme(strip.placement = "outside", plot.title = element_text(size = 14, face = "bold")) +
  geom_text(aes(label = scales::percent(..count../sum(..count..)), y = ..count..), 
            stat = "count", 
            position = position_stack(vjust = 0.5), 
            size = 4, 
            color = "white")


ggplot(df, aes(age))+
  geom_density(col = "black")+
  geom_histogram(aes(y=..density..), alpha = .3, fill = "blue")+
  facet_grid(as.factor(stroke)~.)


cat_cols = c(
  'gender', 'hypertension', 'heart_disease', 
  'ever_married', 'work_type', 
  'smoking_status', 'stroke_t'
)
for (col in cat_cols){
  print(ggplot(df, aes(x=!!sym(col), y=age, fill = !!sym(col))) + 
          geom_boxplot())
}

histglucose <- hist(df$avg_glucose_level,xlim=c(0,300),
                    main="Histogram of Avg. Glucose - Normal Distribution",
                    xlab="Avg. Glucose",las=1)
xfit <- seq(min(df$avg_glucose_level),max(df$avg_glucose_level))
yfit <- dnorm(xfit,mean=mean(df$avg_glucose_level),sd=sd(df$avg_glucose_level))
yfit <- yfit*diff(histglucose$mids[1:2])*length(df$avg_glucose_level)
lines(xfit,yfit,col="red",lwd=2)


df$bmi <- as.numeric(df$bmi)
df$bmi[is.na(df$bmi)] <- mean(df$bmi,na.rm=TRUE)



histbmi <- hist(df$bmi,xlim=c(0,100),
                main="Histogram of BMI - Normal Distribution",
                xlab="Body Mass Index",las=1)
xfit <- seq(min(df$bmi),max(df$bmi))
yfit <- dnorm(xfit,mean=mean(df$bmi),sd=sd(df$bmi))
yfit <- yfit*diff(histbmi$mids[1:2])*length(df$bmi)
lines(xfit,yfit,col="red",lwd=2)


boxplot(Yes$avg_glucose_level,No$avg_glucose_level,
        main="Boxplot of Average Glucose by Stroke Status",
        ylab="Age",las=1,names=c("Stroke","No Stroke"))



heartcounts <- as.data.frame(table(df$heart_disease))

ggplot(heartcounts, aes(x = Var1, y = Freq, fill = Var1)) +
  geom_bar(stat = "identity") + theme(legend.position="none") +
  geom_text(aes(label = Freq), vjust = 0) +
  labs(title="Heart Disease Status of Patients",x ="Heart Disease", y = "Frequency") +
  theme(plot.title = element_text(hjust = 0.5))

gendercounts <- as.data.frame(table(df$gender))

ggplot(gendercounts, aes(x = Var1, y = Freq, fill = Var1)) +
  geom_bar(stat = "identity") + theme(legend.position="none") +
  geom_text(aes(label = Freq), vjust = 0) +
  labs(title="Gender of Patients",x ="Heart Disease", y = "Frequency") +
  theme(plot.title = element_text(hjust = 0.5))


boxplot(df$age,main="Boxplot of Patient Age",ylab="Age",las=1)
boxplot(df$bmi,main="Boxplot of Patient Body Mass Index",ylab="BMI",las=1)


df %>%
  group_by(gender, stroke) %>%
  summarise(count = n()) %>%
  ggplot(aes(x = stroke, y = count, fill = gender)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Number of Men and Women with and without Stroke",
       x = "Stroke",
       y = "Count",
       fill = "Gender") +
  theme_minimal()


temp <- df
temp$stroke <- ifelse(temp$stroke == 0, "No", 'Yes')


ggplot(temp, aes(x=stroke, y=age, fill = stroke)) +
  geom_violin(trim=FALSE, fill='#A4A4A4', color="darkred")+
  geom_boxplot(width=0.1) + theme_minimal()

temp$heart_disease <- ifelse(temp$heart_disease == 0, "No", 'Yes')
ggplot(temp, aes(x=heart_disease, y=age, fill = heart_disease)) +
  geom_violin(trim=FALSE, fill='#A4A4A4', color="darkred")+
  geom_boxplot(width=0.1) + theme_minimal()


library(ggplot2)
df$heart_disease_glucose <- ifelse(df$heart_disease == 1 & df$avg_glucose_level > 140, "Heart Disease and High Glucose",
                                   ifelse(df$heart_disease == 1 & df$avg_glucose_level <= 140, "Heart Disease and Normal/Low Glucose",
                                          ifelse(df$heart_disease == 0 & df$avg_glucose_level > 140, "No Heart Disease and High Glucose", 
                                                 ifelse(df$heart_disease == 0 & df$avg_glucose_level <= 140, "No Heart Disease and Normal/Low Glucose", NA))))


df <- na.omit(df)

ggplot(df, aes(x = heart_disease_glucose, fill = stroke)) +
  geom_bar() +
  scale_fill_manual(values = c("lightblue", "lightpink")) +
  labs(title = "Relationship between Heart Disease and Glucose Levels and Stroke Chance", x = "Heart Disease and Glucose Levels", y = "Count") +
  theme(plot.title = element_text(size = 14, face = "bold"), legend.position = "bottom", legend.title = element_blank(), 
        axis.line = element_line(size = 1), axis.ticks = element_line()) +
  geom_text(aes(label = scales::percent(..count../sum(..count..)), y = ..count..), 
            stat = "count", 
            position = position_stack(vjust = 0.5), 
            size = 4, 
            color = "white")


value <- df %>% count(smoking_status)

value$percent <- round(value$n / sum(value$n) * 100, 1)

ggplot(value, aes(x = "", y = n, fill = smoking_status)) +
  geom_bar(width = 1, stat = "identity") +
  coord_polar(theta = "y") +
  ggtitle("Smoking Status of People") +
  theme_void() +
  theme(legend.position = "bottom") +
  scale_fill_manual(values = c("#F8766D", "#00BFC4", "#C77CFF", "#7CAE00")) +
  geom_label(aes(label = paste(smoking_status, percent, "%", sep = " ")), 
             position = position_stack(vjust = 0.5)) +
  theme(legend.position = "bottom")

df_smoking_stroke <- df %>% group_by(smoking_status, stroke) %>% summarise(count = n())

df_smoking_stroke_percent <- df_smoking_stroke %>% group_by(smoking_status) %>% mutate(percent = count / sum(count))

ggplot(df_smoking_stroke_percent, aes(x = smoking_status, y = percent, fill = stroke)) +
  geom_bar(stat = "identity") +
  scale_y_continuous(labels = scales::percent_format()) +
  labs(title = "Effect of Smoking on Stroke", x = "Smoking Status", y = "Percentage") +
  theme_classic()



library(ggplot2)
df_clean <- df[df$smoking_status != "Unknown",]


value <- df_clean %>% 
  group_by(stroke, smoking_status) %>% 
  summarise(count = n()) %>% 
  mutate(perc = count/sum(count)*100)

ggplot(value, aes(x = stroke, y = perc, fill = smoking_status)) +
  geom_col(position = "fill") +
  scale_fill_manual(values = c("#F8766D", "#00BFC4", "#C77CFF", "#7CAE00")) +
  labs(title = "Effect of Smoking on Stroke", x = "Stroke Status", y = "Percentage") +
  theme_minimal() +
  geom_text(aes(label = paste0(round(perc), "%")), position = position_fill(vjust = 0.5))


value <- df %>% 
  group_by(stroke, smoking_status) %>% 
  summarise(count = n()) %>% 
  mutate(perc = count/sum(count)*100)


ggplot(value, aes(x = stroke, y = perc, fill = smoking_status)) +
  geom_col(position = "fill") +
  scale_fill_manual(values = c("#F8766D", "#00BFC4", "#C77CFF", "#7CAE00")) +
  labs(title = "Effect of Smoking on Stroke", x = "Stroke Status", y = "Percentage") +
  theme_minimal()

