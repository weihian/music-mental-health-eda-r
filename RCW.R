#load data
#start
library(dplyr)
library(skimr)
library(DataExplorer)
library(Hmisc)
library(ggplot2)
library(plotly)
library(corrplot)

setwd("D:/End User/Documents/RData")
data <- read.csv("music.csv")
#end

#preprocess
data_clean <- data %>%
  select(-Timestamp, -Permissions)
categories <- cut(data_clean$Age, breaks = c(0, 18, 30, 60, Inf),
                  labels = c("Adolescents", "Early Adulthood", "Middle Adulthood", "Late Adulthood"))


data_new <- data.frame(data_clean, categories)

#overview of the data
summary(data)
skim(data)
describe(data)
DataExplorer::create_report(data)

#q1
#data processing
#start
#delete null data
df = data_new[data_new$Primary.streaming.service != "", ]

#get the data in primary streaming service and age categories
table = table(df$Primary.streaming.service, df$categories)
df_new = as.data.frame(table)
View(df_new)

#use stack to see frequency of different primary streaming service
df_new %>%
  ggplot(aes(Var1,Freq)) +
  geom_col(aes(fill = Var2), position = "stack") +
  coord_flip() +
  labs(title="Frequency of primary streaming service", x="Primary Streaming Service", y="Frequency", fill="Age categories")

ggplotly(df_new %>%
           ggplot(aes(Var1,Freq)) +
           geom_col(aes(fill = Var2), position = "stack") +
           coord_flip() +
           labs(title="Frequency of primary streaming service", x="Primary Streaming Service", y="Frequency", fill="Age categories"))

#use fill to see the which primary streaming service is the most popular in different age categories
df_new %>%
  ggplot(aes(Var2,Freq)) +
  geom_col(aes(fill = Var1), position = "fill") +
  labs(title="Primary Streming Service used by different age categories", x="Age categories", y="Probability", fill="Primary Streaming Service")

ggplotly(df_new %>%
           ggplot(aes(Var2,Freq)) +
           geom_col(aes(fill = Var1), position = "fill") +
           labs(title="Primary Streming Service used by different age categories", x="Age categories", y="Probability", fill="Primary Streaming Service"))

#q2
#basic information of anxiety column
summary(data_new$Anxiety)

#select high anxiety rows
df <- data_new[data_new$Anxiety > 8, ]

#get the frequency of favorite genre
table = table(df$Fav.genre)
df_new = as.data.frame(table)

#plot bar chart
df_new %>%
  ggplot(aes(x=Var1, y=Freq)) +
  geom_bar(stat="identity", fill="steelblue")+
  coord_flip() +
  labs(title="Favorite genre of high anxiety respondents", x="Favorite Genre", y="Frequency") +
  theme_minimal()

ggplotly(df_new %>%
           ggplot(aes(x=Var1, y=Freq)) +
           geom_bar(stat="identity", fill="steelblue")+
           coord_flip() +
           labs(title="Favorite genre of high anxiety respondents", x="Favorite Genre", y="Frequency") +
           theme_minimal())

#select respondents who love rock
df <- data_new[data_new$Fav.genre == "Rock", ]

#remove row with null value in music effect column
df_new <- df[df$Music.effects != "", ]

#get the count of music effect
table = table(df_new$Music.effects)
df_new = as.data.frame(table)

#plot bar chart
df_new %>%
  ggplot(aes(x=Var1, y=Freq)) +
  geom_bar(stat="identity", fill="steelblue")+
  labs(title="Music effect on mental health", x="Mental health", y="Count") +
  theme_minimal()

ggplotly(df_new %>%
           ggplot(aes(x=Var1, y=Freq)) +
           geom_bar(stat="identity", fill="steelblue")+
           labs(title="Music effect on mental health", x="Mental health", y="Count") +
           theme_minimal())

#q3
df_mental <- data_new %>%
  select(Anxiety, Depression, Insomnia, OCD)
cor_pearson = cor(df_mental, method = 'pearson')
corrplot(cor_pearson)

#q4
#basic information of hours per day column
summary(data_new$Hours.per.day)

#select long hour and short hour data
df_hour_short = data_new[data_new$Hours.per.day<2, ]
df_hour_long =data_new[data_new$Hours.per.day>5, ]

#calculate mean of mental health
anxiety_short = mean(df_hour_short$Anxiety)
depression_short = mean(df_hour_short$Depression)
insomnia_short = mean(df_hour_short$Insomnia)
ocd_short = mean(df_hour_short$OCD)

anxiety_long = mean(df_hour_long$Anxiety)
depression_long = mean(df_hour_long$Depression)
insomnia_long = mean(df_hour_long$Insomnia)
ocd_long = mean(df_hour_long$OCD)

mental_health <- c('Anxiety','Depression','Insomnia','OCD','Anxiety','Depression','Insomnia','OCD')
mean_mh <- c(anxiety_short,depression_short,insomnia_short,ocd_short,anxiety_long,depression_long,insomnia_long,ocd_long)
categories_mh <- c('Short','Short','Short','Short','Long','Long','Long','Long')

# Join the variables to create a data frame
df <- data.frame(mental_health,mean_mh,categories_mh)

#plot dodge bar chart
df %>%
  ggplot(aes(mental_health,mean_mh)) +
  geom_col(aes(fill = categories_mh), position = "dodge") +
  labs(title="Comparison of mental health between long hour respondents\nand short hour respondents", x="Mental health", y="Mean", fill="Mental Health \nCategories")

ggplotly(df %>%
           ggplot(aes(mental_health,mean_mh)) +
           geom_col(aes(fill = categories_mh), position = "dodge") +
           labs(title="Comparison of mental health between long hour respondents\nand short hour respondents", x="Mental health", y="Mean", fill="Mental Health \nCategories"))

#q5
table = table(data_new$Fav.genre, data_new$categories)
df_new = as.data.frame(table)

#plot fill bar chart
df_new %>%
  ggplot(aes(Var2,Freq)) +
  geom_col(aes(fill = Var1), position = "fill")+
  labs(title="Probability of favourite genre in different age categories", x="Age Categories", y="Probability", fill="Music Genres")


ggplotly(df_new %>%
           ggplot(aes(Var2,Freq)) +
           geom_col(aes(fill = Var1), position = "fill")+
           labs(title="Probability of favourite genre in different age categories", x="Age Categories", y="Probability", fill="Music Genres"))

#select respondents who loves pop
df_pop = data_new[data_new$Fav.genre == "Pop", ]

#boxplot
summary(df_pop$Age)
boxplot(df_pop$Age)

#q6
#calculate mean
mean_anxiety = mean(df_pop$Anxiety)
mean_depression = mean(df_pop$Depression)
mean_insomnia = mean(df_pop$Insomnia)
mean_ocd = mean(df_pop$OCD)

mental_health <- c('Anxiety','Depression','Insomnia','OCD')
mean_mh <- c(mean_anxiety,mean_depression,mean_insomnia,mean_ocd)

# Join the variables to create a data frame
df <- data.frame(mental_health,mean_mh)

#plot bar chart
df %>%
  ggplot(aes(mental_health,mean_mh)) +
  geom_bar(stat="identity", fill="steelblue")+
  labs(title="Mental health of poppers", x="Mental health", y="Mean")

ggplotly(df %>%
           ggplot(aes(mental_health,mean_mh)) +
           geom_bar(stat="identity", fill="steelblue")+
           labs(title="Mental health of poppers", x="Mental health", y="Mean"))

df_pop_mental <- df_pop %>%
  select(Anxiety, Depression, Insomnia, OCD)
cor_pearson = cor(df_pop_mental, method = 'pearson')
corrplot(cor_pearson)

#q7
#instrumentalist
table = table(df_pop$Instrumentalist, df_pop$categories)
new_data = as.data.frame(table)

new_data %>%
  ggplot(aes(Var1,Freq)) +
  geom_col(aes(fill = Var2), position = "fill")+
  labs(title="Probability of instrumentalist in different age categories", x="Instrumentalist", y="Probability", fill="Age Categories")


ggplotly(new_data %>%
           ggplot(aes(Var1,Freq)) +
           geom_col(aes(fill = Var2), position = "fill")+
           labs(title="Probability of instrumentalist in different age categories", x="Instrumentalist", y="Probability", fill="Age Categories"))
         

#composer
table = table(df_pop$Composer, df_pop$categories)
new_data = as.data.frame(table)

new_data %>%
  ggplot(aes(Var1,Freq)) +
  geom_col(aes(fill = Var2), position = "fill")+
  labs(title="Probability of composer in different age categories", x="Composer", y="Probability", fill="Age Categories")

ggplotly(new_data %>%
           ggplot(aes(Var1,Freq)) +
           geom_col(aes(fill = Var2), position = "fill")+
           labs(title="Probability of composer in different age categories", x="Composer", y="Probability", fill="Age Categories"))


#q8
df_pop_classic = df_pop[df_pop$Frequency..Classical. == "Very frequently", ]
count_classic = nrow(df_pop_classic)

df_pop_country = df_pop[df_pop$Frequency..Country. == "Very frequently", ]
count_country = nrow(df_pop_country)

df_pop_edm = df_pop[df_pop$Frequency..EDM. == "Very frequently", ]
count_edm = nrow(df_pop_edm)

df_pop_folk = df_pop[df_pop$Frequency..Folk. == "Very frequently", ]
count_folk = nrow(df_pop_folk)

df_pop_gospel = df_pop[df_pop$Frequency..Gospel. == "Very frequently", ]
count_gospel = nrow(df_pop_gospel)

df_pop_hh = df_pop[df_pop$Frequency..Hip.hop. == "Very frequently", ]
count_hh = nrow(df_pop_hh)

df_pop_jazz = df_pop[df_pop$Frequency..Jazz. == "Very frequently", ]
count_jazz = nrow(df_pop_jazz)

df_pop_kpop = df_pop[df_pop$Frequency..K.pop. == "Very frequently", ]
count_kpop = nrow(df_pop_kpop)

df_pop_latin = df_pop[df_pop$Frequency..Latin. == "Very frequently", ]
count_latin = nrow(df_pop_latin)

df_pop_lofi = df_pop[df_pop$Frequency..Lofi. == "Very frequently", ]
count_lofi = nrow(df_pop_lofi)

df_pop_metal = df_pop[df_pop$Frequency..Metal. == "Very frequently", ]
count_metal = nrow(df_pop_metal)

df_pop_rnb = df_pop[df_pop$Frequency..R.B. == "Very frequently", ]
count_rnb = nrow(df_pop_rnb)

df_pop_rap = df_pop[df_pop$Frequency..Rap. == "Very frequently", ]
count_rap = nrow(df_pop_rap)

df_pop_rock = df_pop[df_pop$Frequency..Rock. == "Very frequently", ]
count_rock = nrow(df_pop_rock)

df_pop_vgm = df_pop[df_pop$Frequency..Video.game.music. == "Very frequently", ]
count_vgm = nrow(df_pop_vgm)

genre <- c('Classic', 'Country', 'EDM', 'Folk', 'Gospel', 'Hip-hop', 'Jazz', 'Kpop', 'Latin', 'Lofi', 'Metal', 'R&B', 'Rap', 'Rock', 'Video Game Music')
count <- c(count_classic, count_country, count_edm, count_folk, count_gospel, count_hh, count_jazz, count_kpop, count_latin, count_lofi, count_metal, count_rap, count_rnb, count_rock, count_vgm)

# Join the variables to create a data frame
df <- data.frame(genre,count)

plot_ly(x = df$count, y = df$genre, type = 'bar', orientation = 'h')

#q9
mean_pop_time = mean(df_pop$Hours.per.day)
mean_all_time = mean(data_new$Hours.per.day)

a <- c('Pop', 'All')
hours_per_day <- c(mean_pop_time, mean_all_time)

# Join the variables to create a data frame
df <- data.frame(a,hours_per_day)

plot_ly(x = df$hours_per_day, y = df$a, type = 'bar', orientation = 'h')
