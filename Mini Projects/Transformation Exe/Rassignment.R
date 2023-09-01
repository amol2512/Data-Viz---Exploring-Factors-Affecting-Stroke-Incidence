## Module 1: R Exercises ##

## If you are reading this, then you successfully downloaded, saved, and opened
## the R script! Nice Job!

## Please complete the following exercises by typing your code under each question.
## When finished, Click File -> save As.. and include your name in the filename.
## Upload the file you saved back to Canvas as your submission.

# 1) We are going to use the runif() function to complete some tasks.
# Open the help documentation for the function named runif.
# After writing and running your code below, first use the # symbol, and then
# explain what this function does.

#Answer 1: The runif() function generates a uniform random distribution of 
#integers within a specified range. This information may then be assembled 
#into an object and shown as required. It is specified by n 
#(the number of deviations to be acquired), min (the lower bound of the range), 
#and max (the upper bound of the range) (the upper bound of the range).


# 2) Draw 20 random numbers (n = 20) from the Uniform distribution 
# with the arguments min = 0 and max = 10.

runif(20, min=0, max=10)


# 3) Repeat step 2, except this time store your 20 numbers in an object called numbers.

numbers<-runif(20, min=0, max=10)

# 4) Use what you know or use Google to complete the following on your numbers object:
# Find the mean of the 20 numbers, find the median of the 20 numbers
# find the minimum value in your set, and the maximum value in your set.

numbers.mean<-mean(numbers)
print(numbers.mean)

numbers.min<-min(numbers)
print(numbers.min)
numbers.max<-max(numbers)
print(numbers.max)


# 5) Try to use the function called summary on your numbers object. What does it do?

summary(numbers)

#Answer 5: The summary function shows sub statistics for the parametric object.
#Here, we observe that it shows data such as the minimum value, value of first quartile,
#the value of the median, the value of the mean, the value of the third quartile, 
#and the maximum value of the object.

# 6) Run the following code: numbers < 10
# What did this do? What is the result telling you?

numbers<10

#Answer 6: Here, we notice that the console outputs twenty "TRUE" messages. 
#This is because the preceding code utilizes the comparator to test the provided
# condition (here, if the object elements are fewer than 10) and returns true or false 
#for each object element based on whether the condition is met. Since all integers are less than 10, the function returns TRUE for each value.

# 7) Instead, try running the following: numbers < 5
# What did this do? What is the result telling you?

numbers<5

#Answer 7: Here, we observe that the output is a mixed assortment of "TRUE" and "FALSE"
#outputs. This highlights the difference between the random numbers below the value 5
#(which will display TRUE) and numbers above the value 5 (which will display FALSE).


# 8) The data type "logical" is equivalent to the binary 0 (FALSE) and 1 (TRUE).
# Try to take the sum of your result from step 7, what is the result? What does it mean?

tf.result=numbers<5
print(sum(tf.result))

#Answer 8: The result ends up being the number of TRUE statements that have been returned. 
#We observe that all the FALSE statements amount to 0, and all the TRUE statements amount
#to 1.

# 9) Install the package named palmerpenguins by using the install.packages() function.
# Alternatively, use Tools -> Install Packages.
# Then, load the package by running the following code: library(palmerpenguins).
# Open the help documentation for the dataset called penguins by using the ? symbol.
# Run the summary function on the dataset called penguins.

install.packages("palmerpenguins")
library(palmerpenguins)
summary(penguins)

# 10) Install the package named tidyverse. This package will be useful throughout the
# course for visualizations and data manipulation. 
# Try removing the comments from the following code (check the Code menu above next to Edit)
# to get a sneak preview at some of what we will learn this semester.
# Once you see the graph, answer the following question:
# Are we able to differentiate penguin species by their body mass and flipper length?

library(tidyverse)
ggplot(data = penguins,
       aes(x = flipper_length_mm,
           y = body_mass_g)) +
  geom_point(aes(color = island,
                 shape = species),
             size = 3,
             alpha = 0.8) +
  scale_color_manual(values = c("darkorange","purple","cyan4")) +
  labs(title = "Penguin size, Palmer Station LTER",
       subtitle = "Flipper length and body mass for each island",
       x = "Flipper length (mm)",
       y = "Body mass (g)",
       color = "Penguin island",
       shape = "Penguin species") +
  theme_minimal()

#Answer 10: We immediately observe that the body mass and flipper length 
#of Gentoo penguins on Biscoe island are much greater than those of other 
#species on other islands. Closer investigation reveals that the Chinstrap 
#penguins of Dream Island are second to the Gentoo penguins, but are in no 
#way close. They exhibit features similar to those of Adelie penguins from 
#Dream island and Torgersen island. Simultaneously, we detect certain anomalies,
#such as the rare Chinstrap and Adelie penguins with traits similar to those of 
#Gentoo penguins, but their frequency is insufficient to alter any averages shown by this visualization.
