#Lab 3 EDA drafts

setwd("/Users/priscillaburity/Documents/Berkeley/w203/Lab3")

library(tidyverse)
library(stargazer) 

crime_data = read.csv("crime_v2.csv")
head(crime_data)

crime_data <- na.omit(crime_data)

load("data_clean.rda")

av_wage <- log(rowMeans(crime_data$wcon, crime_data$wtuc, crime_data$wtrd, crime_data$wfir, crime_data$wser, crime_data$wmfg, crime_data$wfed, crime_data$wsta, crime_data$wloc))

crime_data$av_wage = rowMeans(crime_data[,c("wcon", "wtuc", "wtrd", "wfir", "wser", "wmfg", "wfed", "wsta", "wloc")], na.rm=TRUE)

hist(crime_data$crmrte, main = "Histogram of crmrte (Crimes committed per person)", xlab = "Crimes committed per person")

hist(crime_data$polpc, breaks=50, main = "Histogram of polpc (Police per capita)", xlab = "Police per capita")

hist(crime_data$prbarr, breaks=50, main = "Histogram of prbarr (Probability of arrest)", xlab = "Probability of arrest")

ggplot(crime_data, aes(x=crmrte, y=polpc)) + geom_point()

lm(crmrte ~ polpc +  prbpris + prbarr + avgsen + density + west + central + pctymle + pctmin80, data = crime_data)

ggplot(crime_data, aes(x=crmrte, y=prbarr)) + geom_point()

ggplot(crime_data, aes(x=log(polpc), y=prbarr)) + geom_point()


stargazer(crime_data, type = "text", title="Descriptive statistics", digits=1, out="descr_stats.txt")

#mydata$fast <- as.numeric((mydata$mpg > 20.1)) #Creating a dummy variable 1 = fast car 
m1 <- lm(log(crmrte) ~ prbarr, data = crime_data) #only prob arrest
#here there are obvious ommited vars, as the presence of police 
m2 <- lm(log(crmrte) ~ prbarr + log(polpc) + mix, data = crime_data) #also controlling for # of police p/c and offence mix
m3 <- lm(log(crmrte) ~  prbarr +  log(polpc) + mix + prbpris + log(avgsen), data = crime_data) #adding other law enforcement vars
m4 <- lm(log(crmrte) ~  prbarr +  log(polpc) + mix + prbpris + log(avgsen) + log(density) + 
           pctymle + pctmin80, data = crime_data) #adding demographic vars
m5 <- lm(log(crmrte) ~  prbarr +  log(polpc) + mix + prbpris + log(avgsen) + log(density) + 
           pctymle + pctmin80 + west + central + urban, data = crime_data) # adding geographic data
m6 <- lm(log(crmrte) ~  prbarr +  log(polpc) + mix + prbpris + log(avgsen) + log(density) + 
           pctymle + pctmin80 + west + central + urban + av_wage + log(taxpc), data = crime_data) # adding economic data
#m4 <- glm(fast ~ hp + drat + am, family=binomial(link="logit"), data=mydata) stargazer(m1, m2, m3, m4, type="text",
                                                                                       #dep.var.labels=c("Miles/(US) gallon","Fast car (=1)"), covariate.labels=c("Gross horsepower","Rear axle ratio","Four foward gears",
stargazer(m1, m2, m3, m4, m5, m6, type="text",
          dep.var.labels=c("ln(Crimes committed per person)"), covariate.labels=c("'Probability' of arrest", "ln(Police per capita)", 
                                                                              "Offense mix: face-to-face/other", "'Probability' of prison sentence",  
                                                                              "ln(Avg. sentence, days)",  "ln(People per sq. mile)", 
                                                                              "Percent young male", "Perc. minority, 1980",
                                                                              "=1 if in western N.C.", "=1 if in central N.C.", 
                                                                              "=1 if in SMSA", "ln(Average sector wkly wage)",
                                                                              "ln(Tax revenue per capita)"), out="models.txt")




