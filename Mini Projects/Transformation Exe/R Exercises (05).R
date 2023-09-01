#R Exercises (05)

#1 Install the NHANES package and load it into your environment. The dataset we will use for these exercises is also called NHANES (use capital letters for both).
install.packages('NHANES')
library(NHANES)
library(ggplot2)
library(dplyr)
data('NHANES')

#2 Using ggplot, create a scatterplot of BMI vs. Total Cholesterol (BMI and TotChol from the NHANES dataset).
ggplot(NHANES , aes(BMI, TotChol)) + 
  geom_point(size=0.5,color='red')

#3 Run the following code. What has gone wrong? Why are the points not blue
ggplot(data = NHANES) + 
geom_point(mapping = aes(x = Height, y = Weight, color = "blue"))

#The color = "blue" declaration is included in the mapping arguments, indicating that it is viewed as aesthetic.
#instead, we can correct this code with the following change:

ggplot(data = NHANES) + 
  geom_point(mapping = aes(x = Height, y = Weight), color = "blue")

#4 Find and map a continuous variable to color, size, and shape (use ?NHANES for more info about variables). How do these aesthetics behave differently for categorical vs. continuous variables?

?NHANES

ggplot(data = NHANES) + 
  geom_point(mapping = aes(x = Height, y = Weight, color = age))

#Here, age is a continuous variable represented by a gradient from dark to light blue representing different ages.

ggplot(data = NHANES) + 
  geom_point(mapping = aes(x = Height, y = Weight, color = HHIncome))

#Here, HHIncome is a categorical variable and instead of a scale , different categories are represented by each different color.

#5 What does the stroke aesthetic do? What shapes does it work with? (Hint: use ?geom_point)
?geom_point
ggplot(data = NHANES) + 
  geom_point(mapping = aes(x = Height, y = Weight, stroke = 3,color=Age))

#The stroke argument is used to change the size of the border of the points/shape in the plot.

#6 Create a single plot that shows the relationship between Height and Weight for all pairs of Gender and Race1.
ggplot(data = NHANES) + 
  geom_point(mapping = aes(x = Height, y = Weight,color=Gender,shape=Race1))

#Several colors and forms are used to represent the distinguished genders and races.

#7 Modifying your code from part 6, make a plot that show the relationship between Height and Weight for each gender, and a plot that shows the relationship between Height and Weight for each race (using Race1).
install.packages("gridExtra")               
library("gridExtra")  
p1<-ggplot(data = NHANES) + 
  geom_point(mapping = aes(x = Height, y = Weight,color=Gender)) 
p2<-ggplot(data = NHANES) + 
  geom_point(mapping = aes(x = Height, y = Weight,color=Race1))
grid.arrange(p1, p2, ncol = 2)

#8 Recreate the following graph and submit your code.

ggplot(data = NHANES) +
  ggtitle("Blood pressure vs gender vs smoking status")+
  geom_point(mapping = aes(x = BPSysAve, y = TotChol,color=Gender))+
  geom_smooth(mapping = aes(x = BPSysAve, y = TotChol))+
  facet_grid(SmokeNow~ Gender)+
  xlab("Blood pressure (mm Hg)") +
  ylab("Total cholesterol (mg/dl)")
  
