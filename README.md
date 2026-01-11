# music-mental-health-eda-r
Exploratory data analysis of music preferences and listening behavior to understand their relationship with mental health indicators using R.

# Music Preferences and Mental Health Analysis (R)

## 📊 Project Overview

This project explores the relationship between **music preferences, listening behavior, and mental health indicators** using R.  
The analysis is based on a survey dataset (`music.csv`) and investigates how factors such as age, favorite genres, listening duration, and musical engagement relate to mental health conditions including **anxiety, depression, insomnia, and OCD**.

The project applies **data preprocessing, exploratory data analysis (EDA), visualization, and correlation analysis**, with both static and interactive visual outputs.

---

## 🎯 Objectives

The main goals of this project are to:

- Analyze music streaming service usage across different age groups
- Examine music preferences among individuals with high anxiety
- Explore the relationship between listening duration and mental health
- Investigate correlations among mental health indicators
- Compare genre preferences across age categories
- Focus specifically on Pop music listeners and their mental health patterns
- Visualize results using both static (`ggplot2`) and interactive (`plotly`) charts

---

## 📂 Project Structure

```text
.
├── RCW.R          # Main R script containing all analysis and visualizations
├── music.csv     # Dataset (not included in repo if restricted)
└── README.md     # Project documentation

##Methodology & Analysis
###1. Data Loading & Preprocessing

Imported survey data using read.csv

Removed irrelevant columns (e.g., timestamps and permissions)

Categorized respondents into age groups:

Adolescents

Early Adulthood

Middle Adulthood

Late Adulthood

Handled missing and empty values

###2. Exploratory Data Analysis (EDA)

Summary statistics using summary()

Data profiling with:

skimr

Hmisc

DataExplorer

###3. Streaming Service Usage by Age Group

Stacked and proportional bar charts

Identified dominant streaming platforms across age categories

###4. Anxiety and Music Preferences

Focused on respondents with high anxiety scores (Anxiety > 8)

Analyzed favorite music genres

Examined perceived effects of music on mental health among Rock listeners

###5. Mental Health Correlation Analysis

Pearson correlation analysis among:

Anxiety

Depression

Insomnia

OCD

Visualized correlation matrices using corrplot

###6. Listening Duration and Mental Health

Compared mental health scores between:

Short listeners (< 2 hours/day)

Long listeners (> 5 hours/day)

Visualized mean differences using grouped bar charts

###7. Genre Preferences and Age Categories

Analyzed probability distributions of favorite genres across age groups

Conducted age distribution analysis for Pop music listeners

###8. Musical Engagement

Examined likelihood of being an instrumentalist or composer by age group

Analyzed frequency of listening to various sub-genres among Pop listeners

###9. Listening Time Comparison

Compared average daily listening time between:

Pop music listeners

Overall respondent population

##Visualizations

Static visualizations using ggplot2

Interactive charts using plotly

Correlation heatmaps using corrplot

##Technologies & Libraries

Language: R

Libraries Used:

dplyr

ggplot2

plotly

corrplot

DataExplorer

skimr

Hmisc

##How to Run the Project

Clone the repository:

git clone https://github.com/your-username/music-mental-health-analysis-r.git


Open the project in RStudio

Install the required packages:

install.packages(c(
  "dplyr", "ggplot2", "plotly",
  "corrplot", "DataExplorer",
  "skimr", "Hmisc"
))


Place music.csv in the working directory

Run the script RCW.R sequentially
