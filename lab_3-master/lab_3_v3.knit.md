---
title: 'Lab 3 Report'
author: "Priscilla Burity, Oscar Linares, Alissa Stover"
date: "Due: 4/14/2020"
output: html_document
---



# Introduction

**Which policies are most promising in reducing crime rate: those that target punishing crimes (criminal justice policy) or reducing the need to commit crimes (economic policy)? What is the influence of contextual factors (e.g., characteristics of a population) on these relationships?** 

To answer these questions, we use a cross-section of data on crime statistics and related factors (e.g., economic indicators) for a selection of counties in North Carolina. Most of the data are from 1987, except for some demographic variables from the 1980 Census. Our task is to examine the data to help a political campaign understand the determinants of crime and generate policy suggestions that are applicable to local government. As such, we focus primarily on variables that can be influenced by policy.

We also include a range of contextual variables that control for local characteristics influencing crime and the efficacy of these policies. In contrast to our variables of main focus, these are generally not actionable (for example, demographic and geographic indicators). We produced a model robust to these, that can help guide policy decisions and help reduce crime across these counties. 

These data were limited in two major ways: (1) they only have one year of cross-sectional data and (2) omitted variables and lack of variation in policy variables. Issue (1) limits the causal claims we can make, since we cannot use time to observe how different policies could lead to different outcomes. In addition, having data from one year alone means that the context of that specific year is an uncontrolled factor. One specific event that could have affected both crime and economic variables was the Black Monday crash in October of that year (https://en.wikipedia.org/wiki/Black_Monday_(1987)). Issue (2) made it difficult to isolate different economic policies. Omitted variables like unemployment would likely affect crime (e.g., people are more likely to commit theft if they lack income). You also cannot compare different policies if there is not enough variation (e.g., if you want to measure the effect of different minimum wages, you must have different ones to compare) and North Carolina was largely similar across the state on policies like minimum wage and tax levels in the 1980s. 

We found that acting on crime deterrents within the criminal justice system (like arrests and convictions) is important when it comes to preventing crime. In fact, for a 10% rise in the probability of arrests and convictions individually, the negative impact on crime rate hovers between 5-7% for arrests and between 4-5% for convictions.

Even though we could not find much support for the importance of economic policy variables to prevent crimes, this could be due to the lack of a good measure of this kind of policy available in the data. 

## Actionable Variables

### Criminal Justice Policy

Many of these criminal justice policies are used as deterrents of crime, with the assumption being that people will be less likely to commit crimes because they understand and want to avoid the awaiting punishment.

The 3 variables below are dubbed "probabilities". However, this is a misnomer as these variables are truly ratios. We interpret these as measures of the assertiveness of the criminal justice system in a county.

*Probability of arrest* 

If we find that the assertiveness of arrest is associated with crime rate (with higher punishment associated with lower crime), we may consider stricter policies around police practice that encourage more arrests. 

- `prbarr`: number of convictions for every crime reported

*Probability of conviction* 

If we find that the assertiveness of conviction is associated with crime rate (with higher conviction rates associated with lower crime), we may consider stricter policies around court practices so that more arrests lead to convictions.

- `prbconv`: number of convictions for every arrest made

*Probability of sentencing* 

If we find that the assertiveness of sentencing is associated with crime rate (with higher sentencing rates associated with lower crime), we may consider stricter policies around judicial practices so that more convictions lead to sentencing. However, whether or not a given conviction carries a prison sentence depends on the severity of the crime. Counties with more severe crime would see elevated numbers for this variable (and vice versa). 

This variable may be more limited in its explanatory power than arrests and convictions and will not be a prime candidate for our model. 

- `prbpris`: number of prison sentences for every conviction

*Severity of punishment* 

If we find that the severity of punishment is associated with crime rate (with greater severity associated with lower crime), we may consider stricter policies around judicial practices so that people receive more severe punishments if sentenced with a crime. Similarly to conviction rate, the length of someone's sentence depends on the severity of the crime.  

This variable may also be more limited in its explanatory power than arrests and convictions and will not be a prime candidate for our model. 

- `avgsen`:	average sentence in days 

*Number of police officers per capita*

The number of police officers per capita (`polpc`) is a very intuitive example of crime deterrent, as it in theory increases the likelihood of being caught in the act of the crime and is also a measure of the capacity of the State to enforce the law.

As our job is to advise a policy maker, it’s very important that we feel safe about the causal interpretation of our findings. Thus, for statistical rigor, we need to make sure that causal effects go one way (that we have reason to believe that our independent variables have causal effects on our dependent variables, and not the reverse). 

The cross-section of data available to us are limited in this respect, as they do not allow us to link police presence to crime rates with a causal interpretation. This is because one can expect the counties with larger crime rates in a year *t* would consider necessary to have a larger number of police officers on the streets in year *t*, which can imply a positive correlation between presence of police and crime rates that couldn't be read as police presence leading to *higher* crime rates. In fact, an increase in crime could result in an increase in the number of police officers *and* an increase in police officers could result in a decrease in crime. 

Thus, in this exercise we opted not to include police per capita as a candidate policy variable or covariate. 

### Economic Policy

These variables describe things we could affect with economic policy. For example, if increased wages are found to be related significantly to crime, our candidate could consider strategies such as raising the minimum wage in an attempt to lower crime. However, given that North Carolina does not have a wide range of minimum wage policies, it is questionable how much we can test such policies with these data.

We will use these variables to operationalize wage policy as they are our best available proxy. Omitting these could introduce a bias that would affect the other relationships we measure (for example, one could imagine that being very tough on crime would not serve as much of a deterrent if people are not making a living wage and are desperate to get by). We strike a balance between these issues by including these variables as covariates to test the robustness of other relationships, but are cautious about drawing any strong conclusions from them. 

The following are weekly wages in different sectors:

- `wcon`:	construction
- `wtuc`:	transportation, utilities, communication
- `wtrd`:	wholesale and retail trade
- `wfir`:	finance, insurance, real estate
- `wser`: services
- `wmfg`:	manufacturing
- `wsta`:	state employees
- `wloc`: local government employees

The federal wage variable will be grouped with other wages in much of our analyses for easier comparison in terms of data quality, however it is not related to minimum wage policy but rather to cost of living. Federal employee wages are controlled by the federal government and are adjusted by cost of living in a locality (https://www.opm.gov/policy-data-oversight/pay-leave/salaries-wages/fact-sheets/). If we find a relationship between federal wages and crime, one could predict that changing the cost of living may affect crime.

Policy recommendations that could be made from this variable are limited by the fact that we are missing important economic variables such as inequality. Raising the cost of living alone would not have the intended effect on crime without a combined effort to address inequality. For example, areas with high cost of living and high rates of inequality would expect to see more crime, as those who are *in need* would find more reason to take from those who have *more than they need*. 

Although it may be complicated to interpret our quantification of the relationship between crime and this variable, we imagine that omitting this variable could introduce bias in other relationships. 

Thus, it is important to attempt to measure the relationship between federal wages and crime to test the robustness of other variables, but we will not attempt to make any causal interpretation about these relationships. 

- `wfed`:	federal employees

The following variable represents tax revenue per capita, but does not differentiate between different revenue streams (income, sales, property, or businesses). Many taxes are set at the state and federal level; the level of variation at the county-level may be limited for a small state like North Carolina. Since this variable could represent a mix of effects, the causal relationship would be difficult to interpret. We will include this variable as an important covariate in testing other relationships. 

- `taxpc`:	tax revenue per capita 

## Contextual Variables

The following variables describe county characteristics that provide important information about how policies could work across different county contexts and although they are not actionable, strengthen our ability to make causal inferences. 

### Types of Crime 

If an area has mostly petty crimes, one would imagine that some of the punishment could be more discrete than arresting people (e.g., fines). The consequences are real, but less visible and perhaps less of a deterrent. This could change the relationship between our crime policy variables like number of arrests per crime (an area with less face-to-face crimes would see less arrests). It could also affect overall number of crimes (if localities are punishing the crimes they can with arrests, but don't have many of those face-to-face crimes to punish, the punishments would not be as visible and so people would have less of a clear deterrent - so they might end up committing a lot of petty crimes). 

- `mix`:	offense mix: face-to-face/other

### Demographics 

*Urban/rural dwellers* 

Higher density areas would see more interaction between people, which could drive up crime. It could also affect the amount of punishment and the measurement of crime - it might be easier to get away with crime in less dense areas since less people are around. 

- `density`:	people per square mile 

*Minority status*

It is well known that people of minority status (compared to whites) are more likely to be involved in the criminal justice system (this doesn't mean they actually commit more crimes, just that they are caught for more crimes) and as such this is a key covariate in our analysis.

- `pctmin80`:	percent minority, 1980 

*Gender & Age* 

Young males are more likely to enter the criminal justice system so this is another demographic variable that we would expect to see related to crime. 

- `pctymle`:	percent young male, 1980 


### Geography

The following variables identify which region of the state each county is in, with the assumption that counties cluster geographically in terms of their culture and other characteristics we are not explicitly measuring. Western North Carolina is along the Appalachian mountains and qualitatively different from the rest of the state. For example, it has fewer universities (you can see this through Google Maps). Thus, we will lean towards using `west` over the other geographical variables (especially since `urban` could be highly related to `density`). 

- `west`:	=1 if in western N.C.
- `central`:	=1 if in central N.C.
- `urban`:	=1 if in SMSA

# A Model Building Process

## Data Cleaning & Exploratory Data Analysis


```r
# import libraries 
library(tidyverse) # for data import, manipulation, viz
library(corrplot) # for correlation matix
library(stargazer) # visualize model fit
library(skimr) # generate summary statistics
library(car) # statistics 
library(lmtest) # linear modeling
library(olsrr) # evaluating OLS regression 
library(sandwich) # correcting heteroskedasticity violation
library(grid) # to arrange ggplot figures into a grid 
library(gridExtra) # to arrange ggplot figures into a grid 
```


```r
# import data
data <- read_csv("crime_v2.csv", n_max = 91)
```

#### File-level data checks

We have 91 observations and 25 columns in the raw data. All 25 columns were read in as numeric columns. 


```r
print(paste("Number of records:", dim(data)[1]))
```

```
## [1] "Number of records: 91"
```

```r
print(paste("Number of variables:", dim(data)[2]))
```

```
## [1] "Number of variables: 25"
```

##### The Where & When of these data 

It looks like we have 1 observation for each of the counties -- except for county #193. We noticed that these rows appear to be exact duplicates. 


```r
data %>% filter(county == 193)
```

```
## # A tibble: 2 x 25
##   county  year crmrte prbarr prbconv prbpris avgsen   polpc density taxpc
##    <dbl> <dbl>  <dbl>  <dbl>   <dbl>   <dbl>  <dbl>   <dbl>   <dbl> <dbl>
## 1    193    87 0.0235  0.266   0.589   0.423   5.86 0.00118   0.814  28.5
## 2    193    87 0.0235  0.266   0.589   0.423   5.86 0.00118   0.814  28.5
## # … with 15 more variables: west <dbl>, central <dbl>, urban <dbl>,
## #   pctmin80 <dbl>, wcon <dbl>, wtuc <dbl>, wtrd <dbl>, wfir <dbl>,
## #   wser <dbl>, wmfg <dbl>, wfed <dbl>, wsta <dbl>, wloc <dbl>, mix <dbl>,
## #   pctymle <dbl>
```

It appears as though these county IDs could be county FIPS codes (https://www.lib.ncsu.edu/gis/countfips). We will not make such a strong assumption, however we can try to supplement some of our data quality checks to see if anything seems to align between the IDs and FIPS codes. 

The `year` column is an expected constant (1987). We can drop this column in future data processing steps. 


```r
table(data$year, useNA = "always")
```

```
## 
##   87 <NA> 
##   91    0
```

We create a new data frame dropping our superfluous column (`year`) and row (duplicate of county 193). Now we have 90 rows and 24 numeric variables. Since we have one row per county, we appear to be missing information from 10 of the 100 counties in North Carolina.


```r
data2 <- data %>% distinct() %>% select(-c("year", "polpc"))
```

##### Missingness & Data Validity

We can see from the following table that we don't have any missing data.

However, that we appear to have a few values that are extremely high based on maximum values (p100). For example, one county has weekly wages in the service sector reported to be \$2177 (almost 10x the median of \$253). 

Note that `pctmin80` values are not in the [0,1] scale despite being a percentage of total metric. The scale for this variable does not match the other percentage metric in our data set (`pctymle`) and will be adjusted to facilitate coefficient interpretation.


```r
#generate skim table
data2_skim <- skim(data2)
data2_skim
```

```
## Skim summary statistics
##  n obs: 90 
##  n variables: 23 
## 
## ── Variable type:numeric ──────────────────────────────────────────────────────────────────────────
##  variable missing complete  n    mean      sd         p0     p25     p50
##    avgsen       0       90 90   9.69    2.83      5.38     7.38    9.11 
##   central       0       90 90   0.38    0.49      0        0       0    
##    county       0       90 90 100.6    58.32      1       51.5   103    
##    crmrte       0       90 90   0.034   0.019     0.0055   0.021   0.03 
##   density       0       90 90   1.44    1.52  2e-05        0.55    0.98 
##       mix       0       90 90   0.13    0.082     0.02     0.081   0.1  
##  pctmin80       0       90 90  25.71   16.98      1.28    10.02   24.85 
##   pctymle       0       90 90   0.084   0.023     0.062    0.074   0.078
##    prbarr       0       90 90   0.3     0.14      0.093    0.2     0.27 
##   prbconv       0       90 90   0.55    0.35      0.068    0.34    0.45 
##   prbpris       0       90 90   0.41    0.081     0.15     0.36    0.42 
##     taxpc       0       90 90  38.16   13.11     25.69    30.73   34.92 
##     urban       0       90 90   0.089   0.29      0        0       0    
##      wcon       0       90 90 285.35   47.75    193.64   250.75  281.16 
##      west       0       90 90   0.24    0.43      0        0       0    
##      wfed       0       90 90 442.62   59.95    326.1    398.78  448.85 
##      wfir       0       90 90 321.62   54       170.94   285.56  317.13 
##      wloc       0       90 90 312.28   28.13    239.17   297.23  307.65 
##      wmfg       0       90 90 336.03   88.23    157.41   288.6   321.05 
##      wser       0       90 90 275.34  207.4     133.04   229.34  253.12 
##      wsta       0       90 90 357.74   43.29    258.33   329.27  358.4  
##      wtrd       0       90 90 210.92   33.87    154.21   190.71  202.99 
##      wtuc       0       90 90 410.91   77.36    187.62   374.33  404.78 
##      p75     p100     hist
##   11.47    20.7   ▆▇▅▅▂▁▁▁
##    1        1     ▇▁▁▁▁▁▁▅
##  150.5    197     ▇▆▇▇▆▇▇▇
##    0.04     0.099 ▆▇▇▃▂▁▁▁
##    1.57     8.83  ▇▃▁▁▁▁▁▁
##    0.15     0.47  ▃▇▂▁▁▁▁▁
##   38.18    64.35  ▇▅▅▅▆▃▁▂
##    0.084    0.25  ▇▁▁▁▁▁▁▁
##    0.34     1.09  ▆▇▃▁▁▁▁▁
##    0.59     2.12  ▃▇▂▁▁▁▁▁
##    0.46     0.6   ▁▁▂▅▇▇▂▁
##   41.01   119.76  ▇▃▁▁▁▁▁▁
##    0        1     ▇▁▁▁▁▁▁▁
##  314.98   436.77  ▂▇▇▇▅▃▁▁
##    0        1     ▇▁▁▁▁▁▁▂
##  478.26   597.95  ▃▅▅▇▆▃▂▁
##  342.63   509.47  ▁▁▅▇▃▁▁▁
##  328.78   388.09  ▁▁▃▇▅▂▁▁
##  359.89   646.85  ▁▃▇▅▁▁▁▁
##  277.65  2177.07  ▇▁▁▁▁▁▁▁
##  383.15   499.59  ▂▃▆▇▆▂▁▁
##  224.28   354.68  ▃▇▆▂▂▁▁▁
##  440.68   613.23  ▁▁▂▆▇▂▂▁
```


```r
# convert % minority variable
data2$pctmin80 <- data2$pctmin80 * 0.01
```


```r
# save clean data file 
save(data2, file = "data_clean.rda")
```

## Variable-level data checks & Exploratory Data Analysis

### Dependent Variable: Crime Rate

From the histogram, we can see that `crmrte` is unimodal and approximately normal (with a slight skew).

From our boxplot we can see that most values are between 0.02 - 0.04, however we do have a range of values including some that are close to 0.10. We don't appear to have any spurious values. 


```r
p1 <- ggplot(data2, aes(crmrte)) +
  geom_histogram(bins = 35) +
  theme_minimal() +
  xlab("Crime Rate") +
  ylab("Count") +
  ggtitle("Histogram")

p2 <- ggplot(data2, aes(y = crmrte)) +
  geom_boxplot() +
  theme_minimal() +
  ylab("Crime Rate") +
  ggtitle("Box plot")

grid.arrange(p1, p2, ncol = 2, top = "Candidate Dependent Variable: Crime Rate")
```

<img src="lab_3_v3_files/figure-html/unnamed-chunk-10-1.png" width="576" style="display: block; margin: auto;" />

### Independent Variables 

#### Actionable Variables

##### Criminal Justice Policy

We can see that we have different distributions for the 3 core criminal justice policy variables (`prbarr`, `prbconv`, `prbpris`), but that they all could be considered unimodal, with different levels of skew. 


```r
# format data for subplots 
data_cj_long <- data2 %>% select(prbarr, prbconv, prbpris) %>%
  gather(key = var, value = value)

# convert to factor for subplot labelling 
data_cj_long$var <- factor(data_cj_long$var, labels = c("Prob Arrest", "Prob Convicted", "Prob Sentenced"))
```


```r
# plot hist subplots
ggplot(data_cj_long, aes(value)) +
  geom_histogram(bins = 50) +
  facet_grid(~var) +
  theme_minimal() +
  ggtitle("Histogram of Criminal Justice Policy Variables: Assertiveness Variables")
```

<img src="lab_3_v3_files/figure-html/unnamed-chunk-12-1.png" width="672" />

From our boxplots we can see that we have some extreme values for conviction rate, with multiple counties having a rate above 1. They imply that for each arrest, there could be multiple convictions - one county has over 2 convictions for every arrest. Only 1 county has more than 1 arrest per crime committed - most counties in fact have a much lower rate (and only put someone under arrest for ~one-quarter of crimes). When it comes to sentencing, counties show a much lower spread and cluster around 1 conviction resulting in a prison sentence for every 1 conviction that does not. 


```r
# plot boxplot subplots 
ggplot(data_cj_long, aes(x = var, y = value)) +
  geom_boxplot() +
  theme_minimal() +
  xlab("") +
  ylab("Ratio") + 
  ggtitle("Boxplot of Criminal Justice Policy Variables: Assertiveness Variables")
```

<img src="lab_3_v3_files/figure-html/unnamed-chunk-13-1.png" width="672" />

Which county had the highest conviction rate? This is a county in central North Carolina. It has the highest percentage of minorities. It also has the maximum wages in the service industry. 


```r
data2 %>% filter(prbconv == max(prbconv))
```

```
## # A tibble: 1 x 23
##   county crmrte prbarr prbconv prbpris avgsen density taxpc  west central
##    <dbl>  <dbl>  <dbl>   <dbl>   <dbl>  <dbl>   <dbl> <dbl> <dbl>   <dbl>
## 1    185 0.0109  0.195    2.12   0.443   5.38   0.389  40.8     0       1
## # … with 13 more variables: urban <dbl>, pctmin80 <dbl>, wcon <dbl>,
## #   wtuc <dbl>, wtrd <dbl>, wfir <dbl>, wser <dbl>, wmfg <dbl>,
## #   wfed <dbl>, wsta <dbl>, wloc <dbl>, mix <dbl>, pctymle <dbl>
```

The fact that the conviction rate is so high seems odd for county #185. The other measures of assertiveness (for arrest and sentencing) seem close to their medians. 


```r
data_prb <- data2 %>% as_tibble() %>% select(prbarr, prbconv, prbpris) %>% summarise_all(median) %>% 
  gather(var, value) %>% mutate(Group = "Median")

data_ep_long <- data2 %>% 
  select(wcon, wtuc, wtrd, wfir, wser, wmfg, wfed, wsta, wloc) %>%
  gather(key = var, value = value)

prb_185 <- data2 %>%  as_tibble() %>% filter(county == 185) %>% select(prbarr, prbconv, prbpris) %>% 
  gather(var, value) %>% mutate(Group = "County #185")

prbs <- bind_rows(data_prb, prb_185)

ggplot(data = prbs, aes(x = var, y = value, color = Group)) + 
  geom_point() +
  xlab('Criminal Justice Assertiveness Category') +
  ylab('Assertiveness') +
  theme_minimal() +
  ggtitle("Comparing Criminal Justice Assertiveness between County 185 and Other Counties")
```

<img src="lab_3_v3_files/figure-html/unnamed-chunk-15-1.png" width="672" />

According to the FIPS codes, #185 stands for Warren County. During the 1980s, its citizens conducted a series of demonstrations against a newly built landfill (https://en.wikipedia.org/wiki/Warren_County_PCB_Landfill), which led to multiple arrests and convictions associated with disobedience (not crime). This was an extraordinary event outside the process of interest, so we will remove this county.

Average sentence length follows an approximately normal distribution with one extremely high value, corresponding to Madison County (according to the FIPS code). 


```r
p1 <- ggplot(data2, aes(avgsen)) +
  geom_histogram(bins = 35) +
  theme_minimal() +
  xlab("Days of Imprisonment") +
  ylab("Count") +
  ggtitle("Histogram")

p2 <- ggplot(data2, aes(y = avgsen)) +
  geom_boxplot() +
  theme_minimal() +
  ylab("Days of Imprisonment") +
  ggtitle("Box plot")

grid.arrange(p1, p2, ncol = 2, top = "Criminal Justice Indicator: Average Sentence")
```

<img src="lab_3_v3_files/figure-html/unnamed-chunk-16-1.png" width="576" style="display: block; margin: auto;" />

This western county is the home to the state's oldest jail, still in operation in 1987 (https://mountainx.com/news/murky-future-for-madisons-historic-jailhouse/). The fact that this county is in one of the less prosperous areas of the USA and home to this jail could explain its average sentence length. We retain this outlier in the data since it probably doesn't indicate spurious data and would be an interesting edge case to study.  


```r
# show counties with highest average sentence
data2 %>% arrange(desc(avgsen)) %>% select(county, avgsen) %>% head(5)
```

```
## # A tibble: 5 x 2
##   county avgsen
##    <dbl>  <dbl>
## 1    115   20.7
## 2     41   17.4
## 3    127   16.0
## 4     99   14.8
## 5    149   14.6
```

##### Economic Policy

One of the things one can affect with state/local economic policy is minimum wage. In North Carolina in 1987, the minimum hourly wage was \$3.35 (\$134 per week, given a 40 hour week).

In the plots below, we plot weekly wage by sector with a red vertical line indicating this minimum weekly wage. Most wages are approximately normally distributed.

Wholesale & Retail Trade wages are closest to the minimum wage - suggesting that wages in this sector are most under the influence of minimum wage policy. The next sector that would be influenced is Services. Services may be a messier measure of income because many in this sector work in restaurants and make (often unreported) additional income through tips. Thus, `wtrd` would be a better measure of low-income wages. 

Another aspect of wage our candidate could influence are state and local employee wages. Raising the wages of government employees could be a tactic for reducing crime (although it would also cut into budgets for other crime-cutting efforts and may not be ideal). We will include these in our models in order to test this policy, but implementation may be challenging. 


```r
# format data for subplots 
data_ep_long <- data2 %>% 
  select(wcon, wtuc, wtrd, wfir, wser, wmfg, wfed, wsta, wloc) %>%
  gather(key = var, value = value)
# convert to factor for better labeling 
data_ep_long$var <- factor(data_ep_long$var,
                           levels = c("wcon", "wtuc", "wtrd", "wfir",
                                      "wser", "wmfg", "wfed", "wsta", "wloc"),
                           labels = c("Construction", 
                                      "Utilities/Transport", 
                                      "Wholesale & Retail Trade",
                                      "Finance/Insurance/Real Estate",
                                      "Services",
                                      "Manufacturing",
                                      "Federal Emp",
                                      "State Emp",
                                      "Local/State Emp"))
```


```r
# plot hist subplots
ggplot(data_ep_long, aes(value)) +
  geom_histogram(bins = 50) +
  facet_wrap(~var) +
  theme_minimal() +
  ggtitle("Histogram of Economic Policy Variables: Wages by Sector") +
  geom_vline(aes(xintercept = 134, color = "red")) +
  theme(legend.position = "none")
```

<img src="lab_3_v3_files/figure-html/unnamed-chunk-19-1.png" width="672" />


```r
# plot boxplot subplots 
ggplot(data_ep_long, aes(x = var, y = value)) +
  geom_boxplot() +
  coord_flip() + 
  theme_minimal() +
  xlab("") + 
  ylab("Weekly Wage") +
  ggtitle("Boxplot of Economic Policy Variables: Wages by Sector")+
  geom_hline(aes(yintercept = 134, color = "red")) +
  theme(legend.position = "none")
```

<img src="lab_3_v3_files/figure-html/unnamed-chunk-20-1.png" width="672" />

Another variable influenced by economic policy is tax revenue per capita. The distribution of `taxpc` is skewed. This distribution coupled with the fact that `taxpc` is measured in dollars makes the variable a top candidate for a log transformation.


```r
# plot histogram & boxplot
tax1 <- ggplot(data2, aes(taxpc)) +
  geom_histogram(bins = 25) +
  theme_minimal() +
  xlab("Tax Revenue Per Capita") +
  ylab("Count") +
  ggtitle("Histogram")

tax2 <- ggplot(data2, aes(y = taxpc)) +
  geom_boxplot() +
  theme_minimal() +
  ylab("Tax Revenue Per Capita") +
  ggtitle("Boxplot")

grid.arrange(tax1, tax2, ncol = 2, top = "Tax Revenue Per Capita")
```

<img src="lab_3_v3_files/figure-html/unnamed-chunk-21-1.png" width="576" style="display: block; margin: auto;" />

We appear to have an extreme value at \$119.76, which is for county #55. This is likely Dare County according to its FIPS code, a small island that is a popular vacation spot. 


```r
# filter for only #55
data2 %>% filter(taxpc == max(taxpc))
```

```
## # A tibble: 1 x 23
##   county crmrte prbarr prbconv prbpris avgsen density taxpc  west central
##    <dbl>  <dbl>  <dbl>   <dbl>   <dbl>  <dbl>   <dbl> <dbl> <dbl>   <dbl>
## 1     55 0.0790  0.225   0.208   0.304   13.6   0.512  120.     0       0
## # … with 13 more variables: urban <dbl>, pctmin80 <dbl>, wcon <dbl>,
## #   wtuc <dbl>, wtrd <dbl>, wfir <dbl>, wser <dbl>, wmfg <dbl>,
## #   wfed <dbl>, wsta <dbl>, wloc <dbl>, mix <dbl>, pctymle <dbl>
```

With such high tax revenue, one would expect that this county had higher wages. This county has federal employee wages well below North Carolina's median. It is also below the median for:

* `wfir`
* `wmfg`
* `wser`
* `wtrd`

Wealthier people are more likely to have a vacation residence and would probably contribute to higher tax revenue. Given that this row probably does not have a data quality issue but rather is an interesting edge case, we will retain it.


```r
# reformat data for plotting
data_tax <- data2 %>% as_tibble() %>% select(taxpc, wcon, wtuc, wtrd, wfir, wser, wmfg, wfed, wsta, wloc) %>% summarise_all(median) %>% 
  gather(var, value) %>% mutate(Group = "Median")
taxes_55 <- data2 %>%  as_tibble() %>% filter(county == 55) %>% select(taxpc, wcon, wtuc, wtrd, wfir, wser, wmfg, wfed, wsta, wloc) %>% 
  gather(var, value)%>% mutate(Group = "County #55")
taxes <- bind_rows(data_tax, taxes_55)

# plot
ggplot(data = taxes, aes(x = var, y = value, color = Group)) + 
  geom_point() +
  xlab('Category') +
  ylab('$') +
  theme_minimal() +
  ggtitle("Comparing Tax Revenue and Wages between County 55 and Other Counties")
```

<img src="lab_3_v3_files/figure-html/unnamed-chunk-23-1.png" width="672" />


#### Contextual Variables

##### Types of Crime 


```r
# plot hist
p5 <- ggplot(data2, aes(mix)) +
  geom_histogram(bins = 35) +
  theme_minimal() +
  ggtitle("Histogram") +
  xlab("offense mix: face-to-face/other")

# plot boxplot
p6 <- ggplot(data2, aes(y = mix)) +
  geom_boxplot() +
  theme_minimal() +
  ggtitle("Boxplot") +
  ylab("offense mix")



grid.arrange(p5, p6, ncol = 2,  top = "Contextual Variables: Type of Crime")
```

<img src="lab_3_v3_files/figure-html/unnamed-chunk-24-1.png" width="672" style="display: block; margin: auto;" />

##### Demographics 

The distributions for `density` and `pctymle` approximate a normal distribution but the that of `pctmin80` approximates a uniform distribution. Minorities seems to be present in most counties on a similar properties.


```r
# hist
p7 <- ggplot(data2, aes(density)) +
  geom_histogram(bins = 35) +
  theme_minimal() +
  xlab("Density") +
  ylab("Count") +
  ggtitle("Population Density")

# plot boxplot
p8 <- ggplot(data2, aes(y = density)) +
  geom_boxplot() +
  theme_minimal() +
  ggtitle("Population Density") +
  ylab("Density")

p9 <- ggplot(data2, aes(pctmin80)) +
  geom_histogram(bins = 40) +
  theme_minimal() +
  xlab("% Minority") +
  ylab("Count") +
  ggtitle("Percentage Minority (1980)")

p10 <- ggplot(data2, aes(y = pctmin80)) +
  geom_boxplot() +
  theme_minimal() +
  ylab("% Minority") +
  ggtitle("Percentage Minority (1980)")

p11 <- ggplot(data2, aes(pctymle)) +
  geom_histogram(bins = 25) +
  theme_minimal() +
  xlab("% Young Males") +
  ylab("Count") +
  ggtitle("Percentage Young Male (1980)")

p12 <- ggplot(data2, aes(y = pctymle)) +
  geom_boxplot() +
  theme_minimal() +
  ylab("% Young Males") +
  ggtitle("Percentage Young Male (1980)")

grid.arrange(p7, p8, p9, p10, p11, p12, ncol = 2, nrow = 3,  top = "Contextual Variables: Demographics")
```

<img src="lab_3_v3_files/figure-html/unnamed-chunk-25-1.png" width="672" style="display: block; margin: auto;" />

In terms of density outliers, we discovered that the county #119 has the highest density. This county probably is Mecklenburg County, home to city of Charlotte (the state capital and one of the more populated cities). 


```r
data2 %>% filter(density == max(density))
```

```
## # A tibble: 1 x 23
##   county crmrte prbarr prbconv prbpris avgsen density taxpc  west central
##    <dbl>  <dbl>  <dbl>   <dbl>   <dbl>  <dbl>   <dbl> <dbl> <dbl>   <dbl>
## 1    119 0.0990  0.149   0.348   0.486   7.13    8.83  75.7     0       1
## # … with 13 more variables: urban <dbl>, pctmin80 <dbl>, wcon <dbl>,
## #   wtuc <dbl>, wtrd <dbl>, wfir <dbl>, wser <dbl>, wmfg <dbl>,
## #   wfed <dbl>, wsta <dbl>, wloc <dbl>, mix <dbl>, pctymle <dbl>
```

The smallest county would correspond to Swain County, a very rural county in the Western part of the state. It straddles two national parks/forests, which would explain why it has low density. 


```r
data2 %>% filter(density == min(density))
```

```
## # A tibble: 1 x 23
##   county crmrte prbarr prbconv prbpris avgsen density taxpc  west central
##    <dbl>  <dbl>  <dbl>   <dbl>   <dbl>  <dbl>   <dbl> <dbl> <dbl>   <dbl>
## 1    173 0.0140  0.530   0.328   0.150   6.64 2.03e-5  37.7     1       0
## # … with 13 more variables: urban <dbl>, pctmin80 <dbl>, wcon <dbl>,
## #   wtuc <dbl>, wtrd <dbl>, wfir <dbl>, wser <dbl>, wmfg <dbl>,
## #   wfed <dbl>, wsta <dbl>, wloc <dbl>, mix <dbl>, pctymle <dbl>
```

We retain these rows - which don't have data quality issues and are edge cases of interest. 

County #133 (Onslow County based on FIPS code) is the main outlier for `pctymle`. The deviation in percent of young males could be due to Camp Lejeune, a marine corps base. Most recruits are young males and so this base would impact the percent of young males in the population, especially because the density of Onslow county is low. Contrary to our expected relationship, the percent of young males would have a negative impact on crime because recruits would most likely not commit crimes. However, this is not the only county in North Carolina with a military base, so we will keep this observation.


```r
data2 %>% filter(pctymle == max(pctymle))
```

```
## # A tibble: 1 x 23
##   county crmrte prbarr prbconv prbpris avgsen density taxpc  west central
##    <dbl>  <dbl>  <dbl>   <dbl>   <dbl>  <dbl>   <dbl> <dbl> <dbl>   <dbl>
## 1    133 0.0551  0.267   0.272   0.335   8.99    1.65  27.5     0       0
## # … with 13 more variables: urban <dbl>, pctmin80 <dbl>, wcon <dbl>,
## #   wtuc <dbl>, wtrd <dbl>, wfir <dbl>, wser <dbl>, wmfg <dbl>,
## #   wfed <dbl>, wsta <dbl>, wloc <dbl>, mix <dbl>, pctymle <dbl>
```

##### Geography

We were given 3 variables to track geography. These are dummy variables that code for west versus central versus east and urban versus rural. 


```r
# create new east variable
geo_supp <- data2 %>% mutate(east = ifelse(west == 0 & central == 0, 1, 0), rural = ifelse(urban == 0, 1, 0))
```

Eastern counties represent `` 38.89% `` of the 89 counties; central `` 37.78% ``; and western `` 24.44% ``. These sum to 100% so this dummy variable has likely been correctly coded. 

Urban counties represent `` 8.89% `` of the 89 counties. Rural counties represent `` 91.11% ``. These also sum to 100%.


```r
# reformat data for plotting
geo_long <- geo_supp %>%
  mutate_at(vars(west, central, east, rural, urban), ~ ifelse(. == 0, NA, .)) %>%
  gather("location", "present1", west, central, east, na.rm = TRUE) %>%
  gather("type", "present2", rural, urban, na.rm = TRUE) %>%
  select(-present1, -present2)
```

We can see that the vast number of counties are rural across central, western, and eastern counties. Central counties have the largest share of urban geographies. 


```r
# plot barplots
ggplot(geo_long, aes(x = location, fill = type)) +
  geom_bar(position = "fill") +
  theme_minimal() +
  ggtitle("Barplot of Contextual Variables: Geography") +
  xlab("")
```

<img src="lab_3_v3_files/figure-html/unnamed-chunk-31-1.png" width="672" />

As mentioned in our introduction to the variables, we will prioritize `west` in our model. It has the least number of rural counties and represents the least number of counties overall.

### Relationships between Variables


```r
# remove row with erroneous values (#185) before investigating relationships 
data2 <- data2 %>% filter(county != 185)
print(paste("Number of records:", dim(data2)[1]))
```

```
## [1] "Number of records: 89"
```

This is a correlation matrix of all of our variables, using Spearman's due to the fact that not all variables follow a normal distribution. One would expect variables within each of the above groups to be correlated to each other and we can see this is generally the case. 

As expected, `prbarr` and `prbconv`show a negative correlation with `crmrte`. However, `prbpris` and `avgsen` do not show a strong correlation with `cmrte`. The fact that in general the number of imprisonments is low likely weakens the relationship between `prbpris` and `cmrte`. Given that most crimes committed are petty crimes with relatively low sentence lengths, average sentence length might not be a strong deterrent of crimes. 

Additionally, `mix` does not seem to have a strong correlation with `cmrte`. Its values are very low, indicating that face-to-face crimes are almost non-existent across counties. Thus, the low variability of `mix` does not allow for a material relationship between it and crime rate.

Wages are all positively correlated with crime, opposite our prediction. This unexpected direction could be explained in part by the strong positive relationship between the wage variables and `density` and between `crmrte` and `density`. It could also be due to our points above about inequality - if inequality is strongly correlated both to crime and higher wages, it could be a hidden factor that is driving this relationship. Thus, we will not include the wage variables in early models and when we do include it, it's crucial to include additional controls. 

As expected, population density has a strong positive relationship with crime rate. It is also positively correlated with other geographical variables. For example, `urban` and `density` are positively correlated because cities will have higher density. We will pay special attention to these strongly correlated variables as they can increase the variance of models' residuals if they are cast as independent variables in the same equation.

All wages as well as `taxpc` are positively correlated to each other. This behavior is expected as wages and taxable income are both determined by economic factors. Similarly as above, we will need to pay close attention as the joint impact of including multiple variables that are highly correlated in models. 


```r
# omit county to create correlation matrix 
data_corr <- data2 %>% select(-county) 
# create matrix of correlations
matrix_corr <- round(cor(data_corr, method = "spearman"), 1)
```


```r
# visualize correlation matrix 
corrplot(matrix_corr, type = "lower", method = "ellipse", order = "alphabet")
```

<img src="lab_3_v3_files/figure-html/unnamed-chunk-34-1.png" width="672" />

## Model Results

In order select the optimal model in a certain range of model specification options, we will rely on information criteria. Two popular IC are AIC (Akaike information criterion) and and BIC (Bayesian information criterion). AIC and BIC for a model is usually written in the form $-2logL + kp$, where $L$ is the likelihood function, $p$ is the number of parameters in the model, and $k$ is $2$ for AIC and $log(n)$ for BIC ($n$=number of observations). Despite subtle theoretical differences, their only difference in practice is the size of the penalty: BIC penalizes model complexity more heavily. To maintain parsimony of our models, we opted to use BIC for model selection.  

### Model set #1

For our first model, we aimed to evaluate the relationship between crime policy and crime. We expect that more assertive crime policies will be associated with lower crime rates. 

We used the following independent variables: 

(1) log(`prbarr`)

(2) log(`prbconv`) 

(3) log(`prbpris`) 

(4) log(`avg_sen`)


#### Data Transformations

We log transformed crime policy measures and `crmrte` to improve our model fit and interpretability. With these variables logged, they can be interpreted as relative increases in crime rate and assertiveness of the criminal justice system (rather than their absolute value).

#### Discussion

In the previous section, we found that `prbarr` and `prbconv`have a strong negative correlation with `crmrte`, but `prbpris` and `avgsen` don't.  With that in mind, in the table below we compare the output of a model featuring only arrest and conviction rates with the output of a model featuring all the crime policy variables.


```r
# create models
mod1_1 <- lm(log(crmrte) ~ log(prbarr) + log(prbconv) + log(prbpris) + log(avgsen), data = data2)
mod1_2 <- lm(log(crmrte) ~ log(prbarr) + log(prbconv) + log(prbpris) , data = data2)
mod1 <- lm(log(crmrte) ~ log(prbarr) + log(prbconv) , data = data2)

# generate robust standard errors
se_mod1_1 <- sqrt(diag(vcovHC(mod1_1)))
se_mod1_2 <- sqrt(diag(vcovHC(mod1_2)))
se_mod1 <- sqrt(diag(vcovHC(mod1)))

# produce regression table
stargazer(
  mod1_1
  , mod1_2
  , mod1
  , type = "text"
  , se = list(se_mod1_1, se_mod1_2, se_mod1)
  , add.lines=list(c("BIC", round(BIC(mod1_1),1), round(BIC(mod1_2),1), round(BIC(mod1),1)))
  , notes = "Robust SE"
  , star.cutoffs = c(0.05, 0.01, 0.001)
)
```

```
## 
## ========================================================================================
##                                             Dependent variable:                         
##                     --------------------------------------------------------------------
##                                                 log(crmrte)                             
##                              (1)                    (2)                    (3)          
## ----------------------------------------------------------------------------------------
## log(prbarr)               -0.728***              -0.728***              -0.730***       
##                            (0.121)                (0.118)                (0.115)        
##                                                                                         
## log(prbconv)               -0.443**               -0.441**               -0.442**       
##                            (0.151)                (0.144)                (0.140)        
##                                                                                         
## log(prbpris)                0.164                  0.160                                
##                            (0.241)                (0.239)                               
##                                                                                         
## log(avgsen)                 0.033                                                       
##                            (0.195)                                                      
##                                                                                         
## Constant                  -4.743***              -4.673***              -4.822***       
##                            (0.525)                (0.289)                (0.176)        
##                                                                                         
## ----------------------------------------------------------------------------------------
## BIC                         123.2                  118.8                  114.9         
## Observations                  89                     89                     89          
## R2                          0.405                  0.404                  0.400         
## Adjusted R2                 0.376                  0.383                  0.386         
## Residual Std. Error    0.428 (df = 84)        0.425 (df = 85)        0.424 (df = 86)    
## F Statistic         14.271*** (df = 4; 84) 19.234*** (df = 3; 85) 28.671*** (df = 2; 86)
## ========================================================================================
## Note:                                                      *p<0.05; **p<0.01; ***p<0.001
##                                                                                Robust SE
```

The table above shows that approximately 38-40% of the variation in log(crime rate) can be explained by the criminal justice policy variables. Coefficients on log(`prbpris`)  and log(`avg_sen`) were not statistically significant in equation (1). Also note that excluding criminal justice indicators that are weakly related to crime - log(`av_sen`) in equation 2 and log(`av_sen`)/log(`prbpris`) in equation 3 - did not affect R2 nor changed the estimated coefficients on the criminal justice indicators that are strongly related to crime - log(`prbarr`) and log(`prbconv`) - in a material way. Finally, BIC is smaller for the most parsimonious model (equation 3). 

Thus simple models featuring only criminal justice policies as independent variables suggest that, ceteris paribus, a 10% increase in `prbarr` would lead to a ~7% decrease in crime rate, while a 10% increase in `prbconv` would lead to a ~5% decrease in crime rate. This figures have  important practical meaning as well, as a 5-7% change in crime rate may have material impact on people's lives.  

At this point, we believe we have enough information to conclude that log(`prbpris`)  and log(`avg_sen`) do not have explanatory power over log(`crmrte`) that goes beyond that of log(`prbarr`) and log(`prbconv`). Thus, our preferred specification at this stage is that of equation 3, and log(`prbpris`) and log(`avg_sen`) will be removed from future modeling exercises to avoid over fitting. This decision is bolstered by the fact of our concerns regarding the dependency between the type of crime someone commits and whether they are imprisoned and for how long. 

##### Conclusion

Politicians could probably leverage criminal justice policies to curb crime rate. In fact, this first model set featuring only criminal justice policies as independent variables suggest that, ceteris paribus, a 10% increase in `prbarr` would lead to a ~7% decrease in crime rate, while a 10% increase in `prbconv` would lead to a ~5% decrease in crime rate. These estimated effects are statistically significant and have important practical meaning.  

### Model set #2

For our second model, we aimed to evaluate the relationship between crime and a county's economic policies and context. An important economic variable that state and local politicians control is minimum wage. As such, we include wages of industries whose average wage is close to the minimum wage (`wtrd` followed by `wser`). We include `wloc` and `wsta` as a test of policies related to local and state government employees, with the caveat that implementing this policy in an attempt to reduce crime would be difficult (as mentioned in our EDA). For reasons discussed at the EDA section of this project, `wfed` and `taxpc` will be included as important covariates related to the economy.

We are aware that there are several determinants of wages that go beyond political interference, so wages are only proxies of economic policies. As such, conclusions from these exercises should be taken as hints for future research rather than strong evidence. For example, better research on minimum wage policy, such as [this](https://evans.uw.edu/policy-impact/minimum-wage-study), exists and should also be drawn upon when making decisions on minimum wage policy. We carry out hypothesis testing from these but will interpret the outcomes cautiously. 

We used the following independent variables to predict crime: 

*Crime policy* 

(1) log(`prbarr`) 

(2) log(`prbconv`)

*Economic policy* 

(3) log(`wtrd`) 

(4) log(`wser`)

(5) log(`wloc`)

(6) log(`wsta`)

*Economic context*

(7) log(`wfed`) 

(8) log(`taxpc`)


#### Data Transformations

We decided to take the log of our wage variables to show the relationship between relative changes in these to crime (rather than the absolute number). This improves our interpretability since we are making policy recommendations around changing these relative to the existing levels in these counties. 

*Economic policy* 

We can see that we have a fairly linear relationship between trade industry wages and crime. 


```r
ggplot(data = data2, aes(x = log(wtrd), y = log(crmrte))) +
  geom_point() +
  theme_minimal() +
  ggtitle("Relationship between Crime Rate and Wholesale & Retail Trade Wages") + 
  xlab("Average Weekly Wage") + ylab("Log Crime Rate") +
  geom_smooth(method='lm', formula= y~x)
```

<img src="lab_3_v3_files/figure-html/unnamed-chunk-36-1.png" width="672" />

The relationship between the log of Service Wages and Crime Rate seems fairly linear as well, though there are some outliers that seems to have strong leverage on the relationship.


```r
ggplot(data = data2, aes(x = log(wser), log(crmrte))) +
  geom_point() +
  theme_minimal() +
  ggtitle("Relationship between Crime Rate and Log Service Wages") + 
  xlab("Log Average Weekly Wage") + ylab("Log Crime Rate") +
  geom_smooth(method='lm', formula= y~x)
```

<img src="lab_3_v3_files/figure-html/unnamed-chunk-37-1.png" width="672" />

We can see that we have a relatively clear linear relationship between federal wages and crime. 

```r
ggplot(data = data2, aes(x = wfed, log(crmrte))) +
  geom_point() +
  theme_minimal() +
  ggtitle("Relationship between Crime Rate and Federal Employee Wages") + 
   xlab("Average Weekly Wage") + ylab("Log Crime Rate") +
  geom_smooth(method='lm', formula= y~x)
```

<img src="lab_3_v3_files/figure-html/unnamed-chunk-38-1.png" width="672" />

Log transforming `wfed` does not turn the relationship closer to a linear one. We will model `wfed` with a log transformation because we are utilizing the variable as a proxy for living expenses. Log transforming would make the interpretation of the variable's coefficient more intuitive.


```r
ggplot(data = data2, aes(x = log(wfed), log(crmrte))) +
  geom_point() +
  theme_minimal() +
  ggtitle("Relationship between Crime Rate and Federal Employee Wages") + 
   xlab("Log Average Weekly Wage") + ylab("Log Crime Rate") +
  geom_smooth(method='lm', formula= y~x)
```

<img src="lab_3_v3_files/figure-html/unnamed-chunk-39-1.png" width="672" />

We can see that we do not have a very linear relationship between tax per capita and crime. Many of the points cluster together, leaving little variability with which to predict crime. In order to address this cluster, we also apply a log transformation to `taxpc`.


```r
ggplot(data = data2, aes(x = taxpc, log(crmrte))) +
  geom_point() +
  theme_minimal() +
  ggtitle("Relationship between Crime Rate and Tax Per Capita") + 
  xlab("Tax Per Capita") + ylab("Log Crime Rate") +
  geom_smooth(method='lm', formula= y~x)
```

<img src="lab_3_v3_files/figure-html/unnamed-chunk-40-1.png" width="672" />

The fit appears slightly improved after logging tax per capita but the data seems to still be clustered. The variable will be log-transformed because it is a covariate representing the money available to the government, and for that purpose the interpretation would be simpler.


```r
ggplot(data = data2, aes(x = log(taxpc), log(crmrte))) +
  geom_point() +
  theme_minimal() +
  ggtitle("Relationship between Crime Rate and Log Tax Per Capita") + 
  xlab("Log Tax Per Capita") + ylab("Log Crime Rate") +
  geom_smooth(method='lm', formula= y~x)
```

<img src="lab_3_v3_files/figure-html/unnamed-chunk-41-1.png" width="672" />

#### Discussion

The first iteration of this model includes all crime justice variable as well as all key economic variables. In this specification, none of the economic policy variables had statistically significant relationships to crime. The estimates for key economic covariates (`taxpc` and `wfed`) were statistically significant and positive. This indicates that crime rate is larger in counties with more tax revenue and higher cost of living. At this point, these variables could be capturing part of the crime rate variation that should be captured by demographic variables such as `density`. We expect the estimated coefficients for these variables to fluctuate as we add more variables.

We also conducted an F-test to determine if the economic policy variables were jointly statistically significant at explaining variation on crime rate. In this test, the null hypothesis was that economic policies, proxied by average wages at lower paying industries and at local administrations, do not have explanatory power over crime rate. The p-value of this test was well over our alpha of .05 and thus we could not reject the hypothesis, which reinforces that the model is not able to capture the impact of economic policy on crime.  

The elimination of wage variables from our models is advisable also according to BIC, which is smaller for the most parsimonious model (equation 2). Notice though that we decided to keep one proxy for wage policy, Wholesale & Retail Trade sector wages - as discussed at the EDA section of this project, these wages are closest to the minimum wage and most likely to be affected by minimum wage policy. Keeping it will give it a chance to be tested with other covariates, such as density and percentage of minority, in our later model specifications.

After adding economic policy and context to the model, the estimated impact of criminal justice policies reduces slightly. The current set of model specifications suggest that, ceteris paribus, a 10% increase in `prbarr` would lead to a ~6% decrease in crime rate, while a 10% increase in `prbconv` would lead to a ~4% decrease in crime rate (vs. an estimated impact of ~7% and ~5% for the first set of models presented in the previous section). Either way, these figures still have important practical meaning, as a 4-6% change in crime rate may have material impact on people's lives.  



```r
mod2_1 <- lm(log(crmrte) ~ log(prbarr) + log(prbconv) + log(wtrd) + log(wser) + log(wloc) + log(wsta) + log(wfed) + log(taxpc), data = data2)
# fit models
#mod2_2 <- lm(log(crmrte) ~ log(prbarr) + log(prbconv) + log(wfed) + log(taxpc), data = data2)  # no economic policy variables
#mod2_3 <- lm(log(crmrte) ~ log(prbarr)*log(wfed) + log(prbconv)*log(wfed) + log(wser)*log(wfed) + log(wsta)*log(wfed) + log(taxpc), data = data2)  # taxpc interactions
#mod2_4 <- lm(log(crmrte) ~ log(prbarr)*log(taxpc) + log(prbconv)*log(taxpc) + log(wser)*log(taxpc) + log(wsta)*log(taxpc) + wfed, data = data2)  # wfed interactions
mod2 <- lm(log(crmrte) ~ log(prbarr) + log(prbconv) + log(wtrd)  + log(wfed) + log(taxpc), data = data2)   # some economic policy variables, no interactions

# generate robust standard errors
se_mod2_1 <- sqrt(diag(vcovHC(mod2_1)))
se_mod2 <- sqrt(diag(vcovHC(mod2)))

# produce regression table
stargazer(
    mod2_1
  , mod2
  , type = "text"
  , se = list(se_mod2_1, se_mod2)
  , add.lines=list(c("BIC", round(BIC(mod2_1),1), round(BIC(mod2))))
  , notes = "Robust SE"
  , star.cutoffs = c(0.05, 0.01, 0.001)
  )
```

```
## 
## =================================================================
##                                  Dependent variable:             
##                     ---------------------------------------------
##                                      log(crmrte)                 
##                              (1)                    (2)          
## -----------------------------------------------------------------
## log(prbarr)               -0.615***              -0.567***       
##                            (0.130)                (0.119)        
##                                                                  
## log(prbconv)              -0.427***              -0.402***       
##                            (0.123)                (0.121)        
##                                                                  
## log(wtrd)                   0.007                  0.074         
##                            (0.420)                (0.417)        
##                                                                  
## log(wser)                   -0.512                               
##                            (0.315)                               
##                                                                  
## log(wloc)                   0.640                                
##                            (0.699)                               
##                                                                  
## log(wsta)                   -0.266                               
##                            (0.313)                               
##                                                                  
## log(wfed)                  1.769**                1.559**        
##                            (0.573)                (0.539)        
##                                                                  
## log(taxpc)                  0.404                  0.374         
##                            (0.207)                (0.202)        
##                                                                  
## Constant                  -16.205***             -15.810***      
##                            (3.414)                (2.360)        
##                                                                  
## -----------------------------------------------------------------
## BIC                         102.7                    93          
## Observations                  89                     89          
## R2                          0.614                  0.597         
## Adjusted R2                 0.575                  0.573         
## Residual Std. Error    0.353 (df = 80)        0.354 (df = 83)    
## F Statistic         15.875*** (df = 8; 80) 24.614*** (df = 5; 83)
## =================================================================
## Note:                               *p<0.05; **p<0.01; ***p<0.001
##                                                         Robust SE
```


```r
# F-test: joint significance of economic policy variables
print("F-test results for joint significance of economic policies") 
```

```
## [1] "F-test results for joint significance of economic policies"
```

```r
linearHypothesis(mod2_1, c("log(wser)=0", "log(wsta)=0", "log(wtrd)=0", "log(wloc)=0"), vcov=vcovHC)
```

```
## Linear hypothesis test
## 
## Hypothesis:
## log(wser) = 0
## log(wsta) = 0
## log(wtrd) = 0
## log(wloc) = 0
## 
## Model 1: restricted model
## Model 2: log(crmrte) ~ log(prbarr) + log(prbconv) + log(wtrd) + log(wser) + 
##     log(wloc) + log(wsta) + log(wfed) + log(taxpc)
## 
## Note: Coefficient covariance matrix supplied.
## 
##   Res.Df Df      F Pr(>F)
## 1     84                 
## 2     80  4 0.7892 0.5356
```

##### Conclusion

We fail to reject hypothesis that economic policy variables have no impact on crime rate. It seems that politicians might not be able to use economic policy variables to impact crime rate, at least as captured by the available dataset.

The previous section's finding that that politicians could leverage criminal justice policies to curb crime rate was robust to the inclusion of economic variables to the model. In fact, this second model set featuring criminal justice and economic policies as well as economic context as independent variables suggests that, ceteris paribus, a 10% increase in `prbarr` would lead to a ~6% decrease in crime rate, while a 10% increase in `prbconv` would lead to a ~4% decrease in crime rate. These estimated effects are statistically significant and have important practical meaning.

### Model set #3

For our third model, we added demographic control variables to evaluate the robustness of the relationship between crime policy, economic policy, and crime rate when controlling for key demographic contexts (in addition to the economic context we already included). We retained the one wage variable we thought was the best proxy for minimum wage (`wtrd`) so that we can confirm that the lack of relationship was not due to omitted variables biasing our estimates (at least when it comes to those available in the data). We limit wage variables to one to avoid overfitting.

We used the following independent variables to predict crime: 

*Crime policy* 

(1) log(`prbarr`) 

(2) log(`prbconv`)

*Economic policy* 

(3) log(`wtrd`)

*Economic context*

(4) log(`wfed`) 

(5) log(`taxpc`)

*Demographic* 

(6) `density` 

(7) `pctymle`

(8) `pctmin80` 


#### Data Transformations

Many counties had similar demographics (`density`, `mix`, `pctymle`). This may be due to the fact that North Carolina is a small state that may have limited demographic variation. Logarithmic transformation is a convenient means of transforming a highly skewed variable into a more normalized dataset. When modeling variables with non-linear relationships, errors may also be skewed negatively. Still, plotting the log of demographic versus the log of crime rate didn't seem to improve our fitting and we decided not to log-transform these variables. 

##### Density

Taking the log of density does not improve its fit to crime rate. 


```r
ggplot(data = data2, aes(x = density, log(crmrte))) +
  geom_point() +
  theme_minimal() +
  ggtitle("Relationship between log(Crime Rate) and Density") + 
  ylab("Log Crime Rate") + xlab("People per Sq. Mile") +
  geom_smooth(method='lm', formula= y~x)
```

<img src="lab_3_v3_files/figure-html/unnamed-chunk-44-1.png" width="672" />


```r
ggplot(data = data2, aes(x = log(density), log(crmrte))) +
  geom_point() +
  theme_minimal() +
  ggtitle("Relationship between log(Crime Rate) and Log (Density)") + 
  ylab("Log Crime Rate") + xlab("Log People per Sq. Mile") +
  geom_smooth(method='lm', formula= y~x)
```

<img src="lab_3_v3_files/figure-html/unnamed-chunk-45-1.png" width="672" />

##### Percent Young Male in 1980

Percent Young Male does not seem to have a linear relationship with crime rate. Log-transforming Percent Young Male did not solve the issue. 


```r
ggplot(data = data2, aes(x = pctymle, log(crmrte))) +
  geom_point() +
  theme_minimal() +
  ggtitle("Relationship between log(Crime Rate) and Percent Young Male") + 
  ylab("Log Crime Rate") + xlab("% Young Male") +
  geom_smooth(method='lm', formula= y~x)
```

<img src="lab_3_v3_files/figure-html/unnamed-chunk-46-1.png" width="672" />


```r
ggplot(data = data2, aes(x = log(pctymle), log(crmrte))) +
  geom_point() +
  theme_minimal() +
  ggtitle("Relationship between log(Crime Rate) and Log Percent Young Male") + 
  ylab("Log Crime Rate") + xlab("Log % Young Male") +
  geom_smooth(method='lm', formula= y~x)
```

<img src="lab_3_v3_files/figure-html/unnamed-chunk-47-1.png" width="672" />

##### Percent Minority

The percent minority in 1980 does not have a strong relationship with crime rate. Counties appear to have a wide range of this variable and there is only a slight positive correlation with crime rate. We noticed a slight concave form on the scatterplot so we tried a quadratic transformation. 


```r
ggplot(data = data2, aes(x = pctmin80, log(crmrte))) +
  geom_point() +
  theme_minimal() +
  ggtitle("Relationship between log(Crime Rate) and Percent Minority") + 
  ylab("Log Crime Rate") + xlab("% Minority") +
  geom_smooth(method='lm', formula= y~x)
```

<img src="lab_3_v3_files/figure-html/unnamed-chunk-48-1.png" width="672" />


```r
ggplot(data = data2, aes(x = pctmin80*pctmin80, log(crmrte))) +
  geom_point() +
  theme_minimal() +
  ggtitle("Relationship between log(Crime Rate) and Percent Minority^2") + 
  ylab("Log Crime Rate") + xlab("Minority^2") +
  geom_smooth(method='lm', formula= y ~x + I(x^2))
```

<img src="lab_3_v3_files/figure-html/unnamed-chunk-49-1.png" width="672" />


#### Discussion

The first iteration (equation  1) of this set of models includes all the variables listed above. The model fit increased dramatically in comparison to model #2. Among all demographic variables included, only `pctymle` is not individually significant. An F-test was conducted with results leading us to reject the null that the demographic variables are not jointly significant. 

In the following iteration (equation  2), we added a quadratic transformation of percent minority, in an attempt to capture the seemingly concave relationship of this variable with log(`crmrte`) discussed above. The coefficient on the quadratic transformation of percent minority is not statistically significant and the model's BIC is slightly larger in equation 1.   
In equation 3, we dropped `pctymle` to test its impact on the model. It was not statistically significant. However, it is an important control for crime rate so we decided to keep it. 

Given the above, our preferred equation in the model set #3 is equation 1.  

Our economic policy proxy does not seem to be statistically significant in explaining variation in crime rate when modeled with or without the addition of control variables. We would need to do more external research on the economic policies in North Carolina around 1987 to determine why these proxies are not significant. As we noted above, there are also issues of omitted variable bias. 

Including factors related to the demographics of an area (density; percent young males; and percent minorities) increases our ability to predict crime (lower BIC and larger adjusted R2 vs. model set #2, with only criminal and economic variables). Thus, demographic factors should be part of of our model. Higher rates of any of these are related to higher levels of crime.

Finally, when we added demographics to the model the estimated impact of probability of arrest on crime reduces further versus model #2. The current set of model specifications suggest that, ceteris paribus, a 10% increase in `prbarr` would lead to a ~5% decrease in crime rate, while a 10% increase in `prbconv` would lead to a ~4% decrease in crime rate (vs. an estimated impact of ~6% and ~4% for the first set of models #2 presented in the previous section). Either way, this figures still have important practical meaning, as a 4-5% change in crime rate may have material impact on people's lives.  



```r
data2$pctmin802 = data2$pctmin80*data2$pctmin80

# fit models
mod3_1 <- lm(log(crmrte) ~ log(prbarr) + log(prbconv) + log(wtrd)  + log(wfed) + log(taxpc) + density + pctmin80 + pctymle, data = data2)  # all vars
mod3_2 <- lm(log(crmrte) ~ log(prbarr) + log(prbconv) + log(wtrd) + log(wfed) + log(taxpc) + density + pctmin80 + pctmin802 + pctymle, data = data2)  # pctmin80 quadratic transform
mod3_3 <- lm(log(crmrte) ~ log(prbarr) + log(prbconv) + log(wtrd) + log(wfed) + log(taxpc) + density + pctmin80 , data = data2)  # no pctymle
#mod3_4 <- lm(log(crmrte) ~ log(prbarr) + log(prbconv) + log(wfed) + log(taxpc) + density + pctmin80 + pctymle, data = data2)  # no wages

# generate robust standard errors
se_mod3_1 <- sqrt(diag(vcovHC(mod3_1)))
se_mod3_2 <- sqrt(diag(vcovHC(mod3_2)))
se_mod3_3 <- sqrt(diag(vcovHC(mod3_3)))
#se_mod3_4 <- sqrt(diag(vcovHC(mod3_4)))

# produce regression table
stargazer(
    mod3_1
  , mod3_2
  , mod3_3
  #, mod3_4
  , type = "text"
  , se = list(se_mod3_1, se_mod3_2, se_mod3_3)
  , star.cutoffs = c(0.05, 0.01, 0.001)
  , notes = c("Robust SE")
  , add.lines=list(c("BIC", round(BIC(mod3_1),1), round(BIC(mod3_2),1) , round(BIC(mod3_3),1) 
                     #, round(BIC(mod3_4),1)
                     )
                   )
  )
```

```
## 
## ========================================================================================
##                                             Dependent variable:                         
##                     --------------------------------------------------------------------
##                                                 log(crmrte)                             
##                              (1)                    (2)                    (3)          
## ----------------------------------------------------------------------------------------
## log(prbarr)               -0.504***              -0.478***              -0.559***       
##                            (0.110)                (0.126)                (0.089)        
##                                                                                         
## log(prbconv)               -0.329**               -0.326**              -0.363***       
##                            (0.100)                (0.101)                (0.094)        
##                                                                                         
## log(wtrd)                   0.075                  0.032                  -0.008        
##                            (0.373)                (0.376)                (0.341)        
##                                                                                         
## log(wfed)                   1.072*                 1.096*                 1.002*        
##                            (0.427)                (0.431)                (0.444)        
##                                                                                         
## log(taxpc)                  0.289                  0.269                  0.230         
##                            (0.317)                (0.362)                (0.322)        
##                                                                                         
## density                     0.079                  0.077                  0.089*        
##                            (0.043)                (0.043)                (0.045)        
##                                                                                         
## pctmin80                   1.127***                1.841                 1.153***       
##                            (0.214)                (0.978)                (0.210)        
##                                                                                         
## pctmin802                                          -1.295                               
##                                                   (1.551)                               
##                                                                                         
## pctymle                     3.087                  3.008                                
##                            (3.491)                (3.279)                               
##                                                                                         
## Constant                  -13.064***             -12.921***             -11.835***      
##                            (2.256)                (2.283)                (2.650)        
##                                                                                         
## ----------------------------------------------------------------------------------------
## BIC                          62.6                   65.7                   63.1         
## Observations                  89                     89                     89          
## R2                          0.754                  0.758                  0.740         
## Adjusted R2                 0.729                  0.730                  0.717         
## Residual Std. Error    0.282 (df = 80)        0.282 (df = 79)        0.288 (df = 81)    
## F Statistic         30.642*** (df = 8; 80) 27.426*** (df = 9; 79) 32.863*** (df = 7; 81)
## ========================================================================================
## Note:                                                      *p<0.05; **p<0.01; ***p<0.001
##                                                                                Robust SE
```

```r
mod3 <- mod3_1
se_mod3 <- se_mod3_1
```


```r
# F-test: joint significance of demographic variables
print("F-test results for joint significance of demographic variables") 
```

```
## [1] "F-test results for joint significance of demographic variables"
```

```r
linearHypothesis(mod3_1, c("density=0", "pctmin80=0", "pctymle=0"), vcov=vcovHC)
```

```
## Linear hypothesis test
## 
## Hypothesis:
## density = 0
## pctmin80 = 0
## pctymle = 0
## 
## Model 1: restricted model
## Model 2: log(crmrte) ~ log(prbarr) + log(prbconv) + log(wtrd) + log(wfed) + 
##     log(taxpc) + density + pctmin80 + pctymle
## 
## Note: Coefficient covariance matrix supplied.
## 
##   Res.Df Df      F    Pr(>F)    
## 1     83                        
## 2     80  3 9.6385 1.673e-05 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

##### Outliers

There are 5 observations labeled as outliers. These labels correspond to the row numbers but we list their county numbers below:

* 6 - county 11 (leverage; at an extreme of a predictor and we already determined to retain it during EDA)
* 24 - county 53
* 25 - county 55 (leverage; at an extreme of a predictor and we already determined to retain it during EDA)
* 32 - county 69 
* 50 - county 113


```r
ols_plot_resid_lev(mod3)
```

<img src="lab_3_v3_files/figure-html/unnamed-chunk-52-1.png" width="672" />

We already determined that we would retain counties 11 and 55 for modeling, since these represent edge cases rather than erroneous data. However, for the others we may have missed data quality issues. Nothing stands out when we examine the distributions of the variables in the model, except that many have overall lower crime rates as well as low probabilities of arrest. This does not suggest a data quality issue as much as that these are unusual counties in that respect (since generally lower rates of crime were found to be associated with high probabilities of arrest). 

The table below shows the distribution of our model variables for these 3 counties. 


```r
outs <- data2 %>% filter(county %in% c(53, 69, 113)) %>% select(crmrte, prbarr, prbconv, wtrd, wfed, taxpc, density, pctmin80, pctymle)
skim(outs)
```

```
## Skim summary statistics
##  n obs: 3 
##  n variables: 9 
## 
## ── Variable type:numeric ──────────────────────────────────────────────────────────────────────────
##  variable missing complete n    mean      sd      p0     p25     p50
##    crmrte       0        3 3   0.015  0.0018   0.014   0.014   0.014
##   density       0        3 3   0.57   0.13     0.45    0.49    0.54 
##  pctmin80       0        3 3   0.21   0.2      0.024   0.1     0.18 
##   pctymle       0        3 3   0.086  0.0051   0.082   0.083   0.085
##    prbarr       0        3 3   0.26   0.066    0.18    0.23    0.28 
##   prbconv       0        3 3   0.37   0.33     0.14    0.18    0.22 
##     taxpc       0        3 3  42.19   7.6     35.38   38.09   40.8  
##      wfed       0        3 3 408.31  94.9    337.09  354.44  371.79 
##      wtrd       0        3 3 213.59  56.54   154.21  186.99  219.78 
##      p75    p100     hist
##    0.016   0.017 ▇▁▁▁▁▁▁▃
##    0.62    0.71  ▇▁▇▁▁▁▁▇
##    0.3     0.42  ▇▁▁▇▁▁▁▇
##    0.088   0.092 ▇▁▇▁▁▁▁▇
##    0.29    0.3   ▇▁▁▁▁▁▇▇
##    0.48    0.74  ▇▇▁▁▁▁▁▇
##   45.59   50.38  ▇▁▇▁▁▁▁▇
##  443.92  516.05  ▇▇▁▁▁▁▁▇
##  243.28  266.78  ▇▁▁▁▇▁▁▇
```

This table is the distribution of these variables in the rest of the data. 


```r
without_outs <- data2 %>% filter(county != 53 & county != 69 & county != 113) %>% select(crmrte, prbarr, prbconv, wtrd, wfed, taxpc, density, pctmin80, pctymle)
skim(without_outs)
```

```
## Skim summary statistics
##  n obs: 86 
##  n variables: 9 
## 
## ── Variable type:numeric ──────────────────────────────────────────────────────────────────────────
##  variable missing complete  n    mean     sd         p0     p25     p50
##    crmrte       0       86 86   0.034  0.019     0.0055   0.023   0.03 
##   density       0       86 86   1.48   1.54  2e-05        0.57    1.02 
##  pctmin80       0       86 86   0.25   0.17      0.013    0.1     0.25 
##   pctymle       0       86 86   0.084  0.024     0.062    0.074   0.078
##    prbarr       0       86 86   0.3    0.14      0.093    0.21    0.27 
##   prbconv       0       86 86   0.54   0.31      0.068    0.35    0.45 
##     taxpc       0       86 86  37.99  13.34     25.69    30.65   34.77 
##      wfed       0       86 86 444.53  58.84    326.1    407.42  450.06 
##      wtrd       0       86 86 211.33  33.21    161.38   191.19  202.99 
##      p75    p100     hist
##    0.041   0.099 ▅▇▇▃▂▁▁▁
##    1.59    8.83  ▇▅▁▁▁▁▁▁
##    0.38    0.62  ▇▅▅▅▆▅▁▂
##    0.083   0.25  ▇▁▁▁▁▁▁▁
##    0.35    1.09  ▆▇▃▂▁▁▁▁
##    0.57    1.67  ▂▇▅▁▁▁▁▁
##   40.7   119.76  ▇▃▁▁▁▁▁▁
##  478.26  597.95  ▃▃▅▇▆▃▂▁
##  224.28  354.68  ▃▇▅▂▁▁▁▁
```

Do these three counties influence our model fits? We can see that without these observations, we now explain a bit more of the variation. Although eliminating these have improved our fit, we do not have any reason to suspect that they have data quality issues. Dropping any of these do not change our conclusions around our main predictor variables. Thus, we appear to have minimized the effect of outliers for the most part in our model (probably via log transformations). 


```r
# county 53
mod3_out53 <- lm(log(crmrte) ~ log(prbarr) + log(prbconv) + log(wtrd)  + log(wfed) + log(taxpc) + density + pctmin80 + pctymle, data = filter(data2, county != 53)) 

se_mod3_out53 <- sqrt(diag(vcovHC(mod3_out53)))

# county 69
mod3_out69 <- lm(log(crmrte) ~ log(prbarr) + log(prbconv) + log(wtrd)  + log(wfed) + log(taxpc) + density + pctmin80 + pctymle, data = filter(data2, county != 69)) 

se_mod3_out69 <- sqrt(diag(vcovHC(mod3_out69)))

# county 113
mod3_out113 <- lm(log(crmrte) ~ log(prbarr) + log(prbconv) + log(wtrd)  + log(wfed) + log(taxpc) + density + pctmin80 + pctymle, data = filter(data2, county != 113)) 

se_mod3_out113 <- sqrt(diag(vcovHC(mod3_out113)))

stargazer(
    mod3
  , mod3_out53
  , mod3_out69
  , mod3_out113
  , type = "text"
  , se = list(se_mod3, se_mod3_out53, se_mod3_out69, se_mod3_out113)
  , star.cutoffs = c(0.05, 0.01, 0.001)
  , column.labels = c("With", "Omit 53", "Omit 69", "Omit 113") 
  , notes = c("Robust SE")
)
```

```
## 
## ===============================================================================================================
##                                                         Dependent variable:                                    
##                     -------------------------------------------------------------------------------------------
##                                                             log(crmrte)                                        
##                              With                 Omit 53                Omit 69                Omit 113       
##                              (1)                    (2)                    (3)                    (4)          
## ---------------------------------------------------------------------------------------------------------------
## log(prbarr)               -0.504***              -0.529***              -0.505***              -0.541***       
##                            (0.110)                (0.103)                (0.110)                (0.105)        
##                                                                                                                
## log(prbconv)               -0.329**              -0.377***               -0.318**              -0.356***       
##                            (0.100)                (0.102)                (0.099)                (0.107)        
##                                                                                                                
## log(wtrd)                   0.075                  0.215                  0.222                  -0.020        
##                            (0.373)                (0.349)                (0.351)                (0.357)        
##                                                                                                                
## log(wfed)                   1.072*                 0.964*                1.121**                 1.013*        
##                            (0.427)                (0.403)                (0.421)                (0.423)        
##                                                                                                                
## log(taxpc)                  0.289                  0.332                  0.302                  0.294         
##                            (0.317)                (0.286)                (0.319)                (0.301)        
##                                                                                                                
## density                     0.079                  0.064                  0.066                  0.078         
##                            (0.043)                (0.041)                (0.042)                (0.041)        
##                                                                                                                
## pctmin80                   1.127***               1.111***               1.174***               1.075***       
##                            (0.214)                (0.215)                (0.211)                (0.217)        
##                                                                                                                
## pctymle                     3.087                  2.995                  3.351                  2.815         
##                            (3.491)                (3.287)                (3.432)                (3.423)        
##                                                                                                                
## Constant                  -13.064***             -13.332***             -14.196***             -12.239***      
##                            (2.256)                (2.264)                (2.060)                (2.088)        
##                                                                                                                
## ---------------------------------------------------------------------------------------------------------------
## Observations                  89                     88                     88                     88          
## R2                          0.754                  0.780                  0.770                  0.765         
## Adjusted R2                 0.729                  0.758                  0.747                  0.741         
## Residual Std. Error    0.282 (df = 80)        0.265 (df = 79)        0.273 (df = 79)        0.275 (df = 79)    
## F Statistic         30.642*** (df = 8; 80) 35.044*** (df = 8; 79) 33.081*** (df = 8; 79) 32.094*** (df = 8; 79)
## ===============================================================================================================
## Note:                                                                             *p<0.05; **p<0.01; ***p<0.001
##                                                                                                       Robust SE
```

##### Conclusion

The most important takeaways from model set #3 are (1) the estimated effect of criminal justice policies on crime rate is robust to the inclusion of demographic controls, and (2) even controlling for demographics, the coefficient on our proxy for economic policy (log(`wtrd`)) remains statistically not significant. Also importantly, we rejected the null hypothesis that demographic  covariates are not related to crime rate. 

To summarize, this third model set featuring criminal justice, economic policies, economic context as well demographic variables as independent variables suggests that, ceteris paribus, a 10% increase in `prbarr` would lead to a ~5% decrease in crime rate, while a 10% increase in `prbconv` would lead to a ~4% decrease in crime rate. These estimated effects are statistically significant and have important practical meaning.


### Model set #4

For our fourth model, we aimed to evaluate the robustness of the relationship between crime policy and crime when controlling for economic, demographic, and geographic context variables. In addition, we will also re-test the impact of economic policy on crime rate. We will also test the hypothesis that geographical characteristics of a county is not related to crime rate.

We used the following independent variables to predict crime: 

*Crime policy* 

(1) log(`prbarr`) 

(2) log(`prbconv`)

*Economic policy* 

(3) log(`wtrd`) 

*Economic context*

(4) log(`wfed`) 

(5) log(`taxpc`)

*Demographic* 

(6) `density` 

(7) `pctymle` 

(8) `pctmin80` 

*Geographic*

(9) `west` 

Although `west` is our main variable of interest and we expect it to drive most of the effect in terms of geography, we will also use the following variables to check that our suspicions about this variable are correct: 

(10) `central` 

(11) `urban` 

#### Discussion

Different geographies show the same pattern when it comes to urban versus rural: rural counties have a lower crime rate compared to urban ones (as expected). However, `urban` and `density` are highly correlated as seen early, so adding `urban` to the model may not improve fits. We can also see that central and eastern counties are more similar in terms of crime rate versus western counties (western counties have lower crime overall, especially in their urban regions). Thus, we don't expect the covariate for `central` to be significant. 


```r
# plot barplots
ggplot(geo_long, aes(x = location, y = crmrte, fill = type)) +
  geom_bar(position="dodge", stat="summary", fun.y = "mean") +
  theme_minimal() +
  ggtitle("Barplot of Contextual Variables: Geography") +
  xlab("")
```

<img src="lab_3_v3_files/figure-html/unnamed-chunk-56-1.png" width="672" />

*Statistics Interpretation*


```r
mod4_1 <- lm(log(crmrte) ~ log(prbarr) + log(prbconv) + log(wtrd)  + log(wfed) + log(taxpc) + density + pctmin80 + pctymle + west + central + urban, data = data2)
mod4_2 <- lm(log(crmrte) ~ log(prbarr)*west + log(prbconv)*west + log(prbarr)*central + log(prbconv)*central + log(wtrd) + log(wfed) + log(taxpc) + density + pctmin80 + pctymle, data = data2)   # west and central interaction
mod4_3 <- lm(log(crmrte) ~ log(prbarr)*urban + log(prbconv)*urban + log(`wtrd`) + log(wfed) + log(taxpc) + density + pctmin80 + pctymle, data = data2)  # urban interactions
mod4_4 <- lm(log(crmrte) ~ log(prbarr) + log(prbconv) + log(`wtrd`)  + log(wfed) + log(taxpc) + density + pctmin80 + pctymle +  west , data = data2)  # west only, no interactions
mod4_5 <- lm(log(crmrte) ~ log(prbarr)*west + log(prbconv)*west + log(`wtrd`)  + log(wfed) + log(taxpc) + density + pctmin80 + pctymle, data = data2)  # west only, interactions

# generate robust standard errors
se_mod4_1 <- sqrt(diag(vcovHC(mod4_1)))
se_mod4_2 <- sqrt(diag(vcovHC(mod4_2)))
se_mod4_3 <- sqrt(diag(vcovHC(mod4_3)))
se_mod4_4 <- sqrt(diag(vcovHC(mod4_4)))
se_mod4_5 <- sqrt(diag(vcovHC(mod4_5)))

# produce regression table
stargazer(
    mod4_1
  , mod4_2
  , mod4_3
  , mod4_4
  , mod4_5
  , type = "text"
  , se = list(se_mod4_1, se_mod4_2, se_mod4_3, se_mod4_4, se_mod4_5)
  , star.cutoffs = c(0.05, 0.01, 0.001)
  , notes= c("Robust SE")
  , add.lines=list(c("BIC", round(BIC(mod4_1),1), round(BIC(mod4_2),1) , round(BIC(mod4_3),1) , round(BIC(mod4_4),1) , round(BIC(mod4_5),1)
                     )
))
```

```
## 
## ===========================================================================================================================================
##                                                                       Dependent variable:                                                  
##                      ----------------------------------------------------------------------------------------------------------------------
##                                                                           log(crmrte)                                                      
##                                (1)                     (2)                     (3)                    (4)                     (5)          
## -------------------------------------------------------------------------------------------------------------------------------------------
## log(prbarr)                 -0.473***               -0.661***               -0.510***              -0.482***               -0.508***       
##                              (0.109)                 (0.127)                 (0.103)                (0.111)                 (0.147)        
##                                                                                                                                            
## log(prbconv)                -0.333**                 -0.354*                -0.321**                -0.327**               -0.408**        
##                              (0.104)                 (0.180)                 (0.099)                (0.100)                 (0.149)        
##                                                                                                                                            
## log(wtrd)                     0.020                  -0.043                   0.038                  0.009                   0.008         
##                              (0.368)                 (0.381)                 (0.368)                (0.366)                 (0.362)        
##                                                                                                                                            
## log(wfed)                    1.083**                 1.165**                 1.013*                  1.071*                 1.067*         
##                              (0.407)                 (0.405)                 (0.450)                (0.421)                 (0.421)        
##                                                                                                                                            
## log(taxpc)                    0.260                   0.183                   0.333                  0.260                   0.260         
##                              (0.291)                 (0.334)                 (0.328)                (0.302)                 (0.298)        
##                                                                                                                                            
## density                      0.136*                   0.084                  0.135*                  0.081*                  0.077         
##                              (0.060)                 (0.045)                 (0.066)                (0.041)                 (0.046)        
##                                                                                                                                            
## pctmin80                     0.837*                   0.862                 1.194***                0.931**                0.951***        
##                              (0.398)                 (0.442)                 (0.220)                (0.306)                 (0.289)        
##                                                                                                                                            
## pctymle                       2.667                   2.738                   3.214                  2.988                   2.790         
##                              (2.956)                 (3.152)                 (3.222)                (3.263)                 (3.230)        
##                                                                                                                                            
## log(prbarr):west                                      0.167                                                                  0.006         
##                                                      (0.219)                                                                (0.217)        
##                                                                                                                                            
## west:log(prbconv)                                     0.117                                                                  0.177         
##                                                      (0.238)                                                                (0.217)        
##                                                                                                                                            
## log(prbarr):central                                   0.317                                                                                
##                                                      (0.234)                                                                               
##                                                                                                                                            
## log(prbconv):central                                 -0.182                                                                                
##                                                      (0.214)                                                                               
##                                                                                                                                            
## west                         -0.175                   0.129                                          -0.113                  0.035         
##                              (0.157)                 (0.359)                                        (0.107)                 (0.342)        
##                                                                                                                                            
## central                      -0.112                   0.196                                                                                
##                              (0.106)                 (0.443)                                                                               
##                                                                                                                                            
## log(prbarr):urban                                                             0.418                                                        
##                                                                              (1.055)                                                       
##                                                                                                                                            
## urban:log(prbconv)                                                           -0.105                                                        
##                                                                              (0.987)                                                       
##                                                                                                                                            
## urban                        -0.290                                           0.231                                                        
##                              (0.232)                                         (2.432)                                                       
##                                                                                                                                            
## Constant                   -12.554***              -12.677***              -12.748***              -12.486***             -12.539***       
##                              (2.261)                 (2.320)                 (2.515)                (2.335)                 (2.350)        
##                                                                                                                                            
## -------------------------------------------------------------------------------------------------------------------------------------------
## BIC                           70.6                    77.9                    71.7                    65.6                   71.9          
## Observations                   89                      89                      89                      89                     89           
## R2                            0.769                   0.784                   0.765                  0.758                   0.765         
## Adjusted R2                   0.735                   0.743                   0.732                  0.730                   0.732         
## Residual Std. Error      0.279 (df = 77)         0.275 (df = 74)         0.280 (df = 77)        0.281 (df = 79)         0.281 (df = 77)    
## F Statistic          23.239*** (df = 11; 77) 19.185*** (df = 14; 74) 22.848*** (df = 11; 77) 27.487*** (df = 9; 79) 22.803*** (df = 11; 77)
## ===========================================================================================================================================
## Note:                                                                                                         *p<0.05; **p<0.01; ***p<0.001
##                                                                                                                                   Robust SE
```

```r
mod4 <- mod4_4
se_mod4 <- se_mod4_4
```

We can see that the addition of geographic variables did not reduce BIC nor improve our model fit. Further, we can conclude from the F-test that geographical variables are not jointly significant. 

Across equations of this model set, our preferred one is equation 4, which features only `west` as geographic variables. In fact, equation 4 has the lowest BIC, and our external research suggests that this area of the state is in fact different from the others (it has less cities and universities, for example). 

When we added geographic variables to the model, the point estimates of the impact of probability of arrest and probability of conviction on crime remains virtually unchanged versus model #3. In the current set of model specifications with geographic variables, our preferred equation (number 4) suggests that, ceteris paribus, a 10% increase in `prbarr` would lead to a ~5% decrease in crime rate, while a 10% increase in `prbconv` would lead to a ~4% decrease in crime rate - these figures are the same of model set #3 and in fact not much different from model sets #1 (only criminal justice system variables) and #2 (criminal justice system + economic variables). Again, it's fair to argue that this figures have important practical meaning, as a 4-5% change in crime rate may have material impact on people's lives.  


```r
# F-test: joint significance of geographic characteristics
print("F-test results for joint significance of geographic characteristics") 
```

```
## [1] "F-test results for joint significance of geographic characteristics"
```

```r
linearHypothesis(mod4_1, c("west=0", "central=0", "urban=0"), vcov=vcovHC)
```

```
## Linear hypothesis test
## 
## Hypothesis:
## west = 0
## central = 0
## urban = 0
## 
## Model 1: restricted model
## Model 2: log(crmrte) ~ log(prbarr) + log(prbconv) + log(wtrd) + log(wfed) + 
##     log(taxpc) + density + pctmin80 + pctymle + west + central + 
##     urban
## 
## Note: Coefficient covariance matrix supplied.
## 
##   Res.Df Df      F Pr(>F)
## 1     80                 
## 2     77  3 0.8147 0.4896
```




*Conclusion*

The most important takeaways from model set #4 are (1) the estimated effect of criminal justice policies on crime rate is robust to the inclusion of geographic controls, and (2) even controlling for demographics, the coefficient on our proxy for economic policy (log(`wtrd`)) remains statistically not significant. Also importantly, we fail to reject the null hypothesis that geographic covariates are not related to crime rate. 

The model featuring criminal justice, economic policies, economic context, demographic as well geographic variables as independent variables suggests that, ceteris paribus, a 10% increase in `prbarr` would lead to a ~5% decrease in crime rate, while a 10% increase in `prbconv` would lead to a ~4% decrease in crime rate. These estimated effects are statistically significant and have important practical meaning.

## Regression Table

Across all equations estimated, we prefer equation 3 in the table below. It's from model set #3, which uses criminal justice, economic policies, economic context and demographic variables (but not geographic variables) to predict crime rate. Equation 3 has the lowest BIC, which justifies our choice. 

The estimated impact of an increase in the probability of arrest and probability of conviction on crime remains virtually unchanged versus across model specifications. For a 10% rise in each probability individually, the negative impact on crime rate hovers between 5-7% for the probability arrest and between 4-5% for the probability of conviction. 

We could not find a significant impact of economic policies (proxied by wages in lower-paying industries) on crime. The main contextual variables around the economy - `wfed` and `taxpc` - show different patterns. The latter is not statistically significant across any of the models below. The former is, but its effects are partially absorbed when we add in covariates. This is aligned with our hunch that the relationship between this variable and crime rate would be greatly influenced by other factors and thus we shy away from any causal interpretation. 

Across demographic determinants, the percentage of minorities seems to be the most relevant, with a positive impact on crime. Geographic determinants explain little of the cross-county variation of crime rate, probably because North Carolina is a small state.     


```r
stargazer(
    mod1
  , mod2
  , mod3
  , mod4
  , type = "text"
  , se = list(se_mod4, se_mod4, se_mod4, se_mod4)
  , star.cutoffs = c(0.05, 0.01, 0.001)
  , notes = c("Robust SE")
  , add.lines=list(c("BIC", round(BIC(mod1),1), round(BIC(mod2),1) , round(BIC(mod3),1) , round(BIC(mod4),1)
                     )))
```

```
## 
## ===============================================================================================================
##                                                         Dependent variable:                                    
##                     -------------------------------------------------------------------------------------------
##                                                             log(crmrte)                                        
##                              (1)                    (2)                    (3)                    (4)          
## ---------------------------------------------------------------------------------------------------------------
## log(prbarr)               -0.730***              -0.567***              -0.504***              -0.482***       
##                            (0.111)                (0.111)                (0.111)                (0.111)        
##                                                                                                                
## log(prbconv)              -0.442***              -0.402***               -0.329**               -0.327**       
##                            (0.100)                (0.100)                (0.100)                (0.100)        
##                                                                                                                
## log(wtrd)                                          0.074                  0.075                  0.009         
##                                                   (0.366)                (0.366)                (0.366)        
##                                                                                                                
## log(wfed)                                         1.559***                1.072*                 1.071*        
##                                                   (0.421)                (0.421)                (0.421)        
##                                                                                                                
## log(taxpc)                                         0.374                  0.289                  0.260         
##                                                   (0.302)                (0.302)                (0.302)        
##                                                                                                                
## density                                                                   0.079                  0.081*        
##                                                                          (0.041)                (0.041)        
##                                                                                                                
## pctmin80                                                                 1.127***               0.931**        
##                                                                          (0.306)                (0.306)        
##                                                                                                                
## pctymle                                                                   3.087                  2.988         
##                                                                          (3.263)                (3.263)        
##                                                                                                                
## west                                                                                             -0.113        
##                                                                                                 (0.107)        
##                                                                                                                
## Constant                   -4.822*               -15.810***             -13.064***             -12.486***      
##                            (2.335)                (2.335)                (2.335)                (2.335)        
##                                                                                                                
## ---------------------------------------------------------------------------------------------------------------
## BIC                         114.9                   92.9                   62.6                   65.6         
## Observations                  89                     89                     89                     89          
## R2                          0.400                  0.597                  0.754                  0.758         
## Adjusted R2                 0.386                  0.573                  0.729                  0.730         
## Residual Std. Error    0.424 (df = 86)        0.354 (df = 83)        0.282 (df = 80)        0.281 (df = 79)    
## F Statistic         28.671*** (df = 2; 86) 24.614*** (df = 5; 83) 30.642*** (df = 8; 80) 27.487*** (df = 9; 79)
## ===============================================================================================================
## Note:                                                                             *p<0.05; **p<0.01; ***p<0.001
##                                                                                                       Robust SE
```

## Checking the 6 Classical Linear Model assumptions for our preferred model (Model #3) 

### Linear population model

This assumption is automatically fulfilled because we haven't constrained the error term, i.e we haven't required it to be normal. So there's nothing to check at this point.

## Random Sampling

North Carolina has 100 counties and this dataset has only 90. To check random sampling, we need more background knowledge of how why these remaining counties were omitted. In general, we are concerned about possible problems with independence. For example, maybe omitted counties are the poorest ones where it's more difficult to gather data. If these counties were included, we could perhaps capture better the effect of economic policy variables. 

## No perfect collinearity

There is no need to explicitly check for perfect collinearity, because R will alert us if this rare condition happens.

## Zero Conditional Mean

Let's take a look at the diagnostic plots:


```r
plot(mod3, which = 1)
```

<img src="lab_3_v3_files/figure-html/unnamed-chunk-61-1.png" width="672" />

Notice that there is only a slight deviation from zero conditional mean, indicated by a not perfectly flat curve. This means that our coefficients maybe be biased. Next section, we discuss some omitted variables candidates and the bias direction they would imply.  

## Homoskedasticity

Our residuals versus fitted values plot seems to indicate heteroskedasticity based on the scale location plot. We see a bump for values close to the mean and high end of the distribution. 


```r
plot(mod3, which = 3)
```

<img src="lab_3_v3_files/figure-html/unnamed-chunk-62-1.png" width="672" />

We used robust standard error to test all of our models, which is a common strategy in correcting for heteroskedasticity - we believe this satisfies this assumption.

## Normality of Errors

To check normality of errors, we can look at the qqplot that's part of R's standard diagnostics.


```r
plot(mod3, which = 2)
```

<img src="lab_3_v3_files/figure-html/unnamed-chunk-63-1.png" width="672" />

We can also visually look at the residuals directly.


```r
hist(mod3$residuals, breaks = 20, main = "Residuals from Linear Model Predicting log(Crime Rate)")
```

<img src="lab_3_v3_files/figure-html/unnamed-chunk-64-1.png" width="672" />

Both methods suggest we have a leftward skew. However, we have a large sample size, so the CLT tells us that our estimators will have a normal sampling distribution. The histogram confirms that we aren't in a situation with an extreme skew, so n=90 should be sufficient for the CLT.

# Discussion of Other Possible Omitted Variables

We lacked many variables that we expect relate to crime. Could any of these have affected the quantification of the relationships above? 

In order to access the direction of omitted variable bias (OVB) resulting from each of the variables, we analyze the product of two correlations:

- $\alpha$ = correlation between the omitted variable and `crmrte` 
- $\beta$ = correlation between the omitted variable and `prbarr`/`prbconv` 

As we assume the true relationship between `crmrte` and `prbarr`/`prbconv` is negative, a positive OVB biases the estimated effect of `prbarr`/`prbconv` on `crmrte` towards zero, while a negative OVB biases the estimated effect away from zero.

**Unemployment** ($\alpha > 0$ and $\beta > 0$ -> away from zero)
Unemployment rate is likely positively related to crime rate (so $\alpha > 0$), people in need are more prone to commit crimes. Unemployment rate is also arguably positively related to  `prbarr`/`prbconv` (so $\beta > 0$) due to the negative stigma that unemployment people have in society. Thus this OV should bias the estimated effect of `prbarr`/`prbconv` on `crmrte` away from zero.  


**Education levels of the populace** ($\alpha < 0$ and $\beta < 0$ -> away from zero)

Although we may be able to proxy education levels by looking at which region a county is in, we would not have a very good measure of overall education levels. A county can have a university, but still have low education levels overall. One would predict that education is negatively related to crime - the more educated, the less crime one would expect to commit. The relationship between education levels and `prbarr`/`prbconv` is arguably negative due to the negative stigma that less educated people have in society. 

**Public works & investments** ($\alpha < 0$ and $\beta < 0$ -> away from zero)

One would predict that the relationship between and public works and investments with crime would be negative. More nonprofits and community organizations could strengthen ties in communities, thus lowering crime rates. This factor would probably be inversely related to arrest and conviction rates, since a more punitive society may invest less in rewards to the community. 

**Individual Health (mental and physical)** ($\alpha < 0$ and $\beta < 0 $ -> away from zero)

Health - mental and physical - would likely be related to less crime. The healthier you are, the more mental and physical resources you have to solve problems in ways that do not necessitate committing a crime. The direction of the relationship to arrest or conviction rates is fuzzier but one could imagine that communities that have a focus on health may tend to be less punitive. 

**Community Health** ($\alpha < 0$ and $\beta < 0 $ -> away from zero)

Community health is about the cohesiveness of a community. If you have good supports in your community, you would be less likely to commit crime. This factor would probably be inversely related to arrest and conviction rates, since a more loving, cohesive community may be less likely to turn to punishment. 

**Inequality** ($\alpha > 0$ and $\beta < 0 $ -> towards zero)

With more inequality, one would expect to see more crime - more anger & therefore reason to commit crime combined with greater levels of deprivation and need to commit crime would naturally lead to more crime. A more egalitarian society may have less punitive practice, since people would see each other as closer to their own group. This can help humanize other people and make it harder to commit cruelties. 

Overall, most of these omitted variables likely inflated our estimate of the relationship between crime rate and these criminal justice policies. 

What about our targeted economic policy variables? We were hesitant about making any causal inferences regarding these variables since we identified many variables that could be biasing the effect.

- $\alpha$ = correlation between the omitted variable and `crmrte` 
- $\beta$ = correlation between the omitted variable and wage variables (e.g., `wtrd`)

**Unemployment** ($\alpha > 0$ and $\beta > 0$ -> away from zero)

Unemployment rate is likely positively related to crime rate, people in need are more prone to commit crimes. There has been mixed evidence around increases in minimum wage and unemployment, however many people believe that unemployment and wage increases are positively correlated so we will make that assumption here. 

**Education levels of the populace** ($\alpha < 0$ and $\beta > 0$ -> towards zero)

One would predict that education is negatively related to crime - the more educated, the less crime one would expect to commit. The relationship between education levels and wages is likely positive, since those who are more educated often make more money and also have the funds to then pay for their own or their children's education. 

**Public works & investments** ($\alpha < 0$ and $\beta > 0$ -> towards zero)

One would predict that, like education, the relationship between and public works and investments with crime would be negative. More nonprofits and community organizations could strengthen ties in communities, thus lowering crime rates. A community with higher wages would have more funds to put towards these, so beta is probably positive. 

**Individual Health (mental and physical)** ($\alpha < 0$ and $\beta > 0 $ -> towards zero)

Individual health - both mental and physical - would likely be related to less crime. The healthier you are, the more mental and physical resources you have to solve problems in ways that do not necessitate committing a crime. The direction of the relationship to a community's wages is probably positive since more money means more funds to invest in health. 

**Community Health** ($\alpha < 0$ and $\beta > 0 $ -> towards zero)

Community health is about the cohesiveness of a community. If you have good supports in your community, you would be less likely to commit crime. A community that is cohesive would likely be interested in policies that strengthen others' status in that community (like increasing the minimum wage), so the relationship would likely be positive. 

**Inequality** ($\alpha > 0$ and $\beta < 0 $ -> away from zero)

With more inequality, one would expect to see more crime - more anger & therefore reason to commit crime combined with greater levels of deprivation & need to commit crime would naturally lead to more crime. Places with higher minimum wages probably see less inequality, so the relationship is inversed.

We suspect these omitted variables are making the effect of our wage variable not statistically significant. This is not surprising given that we new this operationalization was flawed.

# Conclusion

Our analyses suggest that acting on crime deterrents within the criminal justice system (like arrests and convictions) is an important policy target for preventing crime. In fact, for a 10% rise in the probability of arrests and convictions individually, the negative impact on crime rate hovers between 5-7% for the arrests and between 4-5% for convictions.  Helpful follow-ups in this investigation would be to leverage variation across time and possibly test for large changes in policy that would help for example in designing a regression discontinuity model. However, our findings can be used to hone in on future policy changes that can be evaluated with more rigorous causal analyses. 

We could not find much support for the importance of economic policy variables to prevent crimes. We did find that the wages of federal employees appear positively correlated with crime - so one policy could be to try to drive up the cost of living by attracting higher-paying businesses. However, there are omitted factors (such as inequality) that would likely lead to important downstream consequences from this policy so it would be important to conduct follow-up research to test more details about implementation. These omitted factors may have also contributed to the lack of statistically significant effects in wage variabes as well as inflated the estimates for crime policy.

Real life variations in these counties lead to some extreme values - we did not remove these, as they were likely edge cases rather than erroneous data. Any policies should take the local context into consideration. A stronger follow-up study would control for more of these within-county factors to produce more robust causal findings. The distribution of minorities is a good example of one of these important contextual variable that is not (at least ethically) under the influence of a politician. Communities with higher rates of minorities or crime may require additional resources or different types of policies to prevent crime. For example, if the actual number of crimes is different from the number of reported crimes - for example, in a community with a lot of racial conflict where some groups over-report others to the police - we would see elevated measures of crime. If policies aim to reduce actual crime, we would need more nuanced measures to track these and would need to turn towards more nuanced ways to address this (e.g., hosting workshops to reduce racism). 

In conclusion, we recommend policies that increase arrests and convictions alongside those that help increase the cost of living in an area. However, the actual impact of changing these factors is not guaranteed because they likely depend on a county's specific context, which we were unable to rigorously study here due to data limitations. An important tactic for any politician would be to fund research that can more rigorously tease out these causal factors, so that policy changes are based on stronger findings not as influenced by variables omitted in this analysis (such as timing or inequality). 


