# Exploring Factors Affecting Stroke Incidence in R

## Overview
The exploring factors affecting stroke incidence project is a comprehensive exploration into the various factors and their relationships to the incidence of stroke. Utilizing the R programming language, this project provides a deep dive into visual and analytical explorations to comprehend the different dynamics at play.

## Dataset Description

### Source
This dataset is available on Kaggle.

### Context
Stroke is a leading cause of morbidity and mortality worldwide. As per the World Health Organization (WHO), it ranks as the second most common cause of death globally, accounting for nearly 11% of all fatalities. The objective of this dataset is to facilitate predictive analytics, determining the likelihood of a stroke based on a series of patient attributes.

### Attribute Information:

- **id**: A unique identifier for each patient.
- **gender**: Categorical variable indicating the gender of the patient. It can be "Male", "Female", or "Other".
- **age**: A numerical attribute denoting the age of the patient.
- **hypertension**: Binary variable. It is set to 0 if the patient doesn't suffer from hypertension and 1 otherwise.
- **heart_disease**: Binary variable. 0 indicates the absence of heart diseases in the patient, while 1 indicates the presence of heart disease.
- **ever_married**: Categorical variable indicating marital status. Possible values are "No" or "Yes".
- **work_type**: Describes the type of employment/job of the patient. It can be one of the following: "children", "Govt_job", "Never_worked", "Private", or "Self-employed".
- **Residence_type**: Categorical attribute indicating the type of residence. It can be either "Rural" or "Urban".
- **avg_glucose_level**: A numerical value representing the average glucose level in the patient's blood.
- **bmi**: Represents the body mass index of the patient.
- **smoking_status**: Categorical variable that describes the smoking habits of the patient. It can be "formerly smoked", "never smoked", "smokes", or "Unknown". The "Unknown" category implies that the smoking habits of the patient are not known.
- **stroke**: Binary outcome variable. It is set to 1 if the patient has previously suffered a stroke and 0 otherwise.

## Key Features

- **Exploratory Data Analysis (EDA):** Multiple plots are generated using the `ggplot2` package to understand the distribution and relationships in the data.
  
- **Data Cleaning:** The dataset is transformed to ensure the data types and values are conducive for analysis. For instance, missing BMI values are imputed with the mean BMI.
  
- **Statistical Analysis:** Various statistical calculations like standard deviation, mean, and probabilities are carried out, especially focusing on the relationship between age and stroke incidence.
  
- **Data Grouping:** Data is grouped based on different categorical variables to understand the distribution and average of stroke incidences among different groups.
  
- **Visualization:** Various types of plots including density plots, histograms, bar charts, and boxplots are used to represent data in a meaningful way. The project places a particular emphasis on visual aesthetics, ensuring clarity and easy interpretability.

### Visual Highlights

- **Distribution of Stroke by Age:** This scatter plot showcases the distribution of stroke incidences by age.
  
- **Density Distribution of Stroke by Age:** A density plot demonstrating the frequency of stroke incidences according to different age brackets.
  
- **Distribution of Stroke by BMI:** Visual representation of stroke patients categorized by their BMI, such as Underweight, Healthy, Overweight, and Obesity.

- **Density Relationship Between Glucose Levels and Stroke:** This density plot gives insights into the relationship between average glucose levels and the chances of having a stroke.

- **Effect of Smoking on Stroke:** Bar charts segregating stroke patients based on their smoking status.

- **Histogram of Avg. Glucose and BMI:** These histograms, overlaid with a normal distribution curve, offer insights into the distribution of average glucose levels and Body Mass Index in the dataset.

- **Boxplots:** Boxplots are utilized for various variables to understand their spread and outliers.

## Dependencies
The project extensively utilizes the following R packages:

- `ggplot2`: For all the visualizations
- `dplyr`: For data manipulation
- `gridExtra`: For arranging multiple ggplots on one page

## How to Run

1. Ensure you have R installed on your machine.
2. Install the necessary packages if not already present using `install.packages()`.
3. Load the dataset by adjusting the path if needed.
4. Execute the R code provided above in sequence.

## Conclusion
This project provides a comprehensive exploration into the factors affecting stroke incidence. With a combination of visualizations and statistical calculations, it aids in understanding the intricacies of stroke incidences in relation to factors like age, BMI, average glucose levels, smoking status, and more.

**Feedback and contributions are always welcome!**
