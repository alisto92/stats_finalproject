Lab 3: Stage 2
================
Priscilla Burity, Oscar Linares, Alissa Stover
Due: April 7th, 2020

# Stage 2: Peer Feedback - Due at Live Session 13

In Stage 2, you will provide feedback on another team’s draft report. We
will ask you to comment separately on different sections. The following
list is very similar to the rubric we will use when grading your final
report.

## 1.0 Introduction.

  - *Is the introduction clear?* Introduction is clear - the team gives
    a good overview of the data and what types of questions could be
    addressed with it. The portion where they discuss its limits with
    respect to time and what would happen if there were large policy
    changes was especially clear and gave a good grounding for the
    questions explored later on.

  - *Is the research question specific and well defined?* Yes, this
    group is looking at the relationship between crime rate and the
    probability of punishment.

  - *Does the introduction motivate a specific concept to be measured
    and explain how it will be operationalized?* Yes, the authors give
    broad categories of concepts that are of interest and identify
    specific variables they will use to operationalize these.

  - *Does it do a good job of preparing the reader to understand the
    model specifications?* Yes, as they identify the variable of
    interest and its key predictors, along with the main covariate of
    interest.

## 2.0 The Initial Data Loading and Cleaning.

  - *Did the team notice any anomalous values? Is there a sufficient
    justification for any data points that are removed? Did the report
    note any coding features that affect the meaning of variables
    (e.g. top-coding or bottom-coding)?*
    
      - The team did not catch the one exactly duplicated row.
      - For some yes, for others no. This team eliminated all rows for
        which the “probability” variables are above 1. If these were
        truly probability variables this elimination would be valid.
        However, according to the data dictionary these were more
        accurately interpreted as ratios - which could have values over
        1. For this reason, there was not sufficient justification for
        the 10 rows removed with “probability” variables that had values
        over 1. This could also risk skewing the data used for modeling.
        With only 90 valid rows, removing 10 means that ~11% of the data
        were removed. Those removed have a clear pattern of higher
        probability of punishment for every crime committed, which could
        influence model output quite a bit.
      - The team also coded wage variables as logged at the front of
        their report. This is a reasonable thing to do, however the
        arguments around this is missing discussion of model fit - yes,
        these are valid variables to transform into logged variables,
        but it would be good to see this transformation happening with
        some discussion of the impact on model fit. This creates an
        issue because there were some anamolous values in the wage
        variables that were not spotted since they were logged.

  - *Overall, does the report demonstrate a thorough understanding of
    the data?*
    
      - Somewhat. The team did understand many of the variables, but
        misinterpreted some of the “probability” variables (noted
        above). Also, in the introduction they stated that all variables
        were collected in 1987 - this is true for most but not all. Some
        data are from the 1980 Census (the % young male & % minority;
        see data dictionary).

## 3.0 The Model Building Process.

  - *Overall, is each step in the model building process supported by
    EDA?*
    
      - Yes and no. EDA on the dependent variable (crime rate) was
        excellent. More exploration of untransformed predictor variables
        would have been helpful in folliwng the team’s logic. There were
        figures in the appendix to support some of the EDA but the
        output was not explained so it is hard to follow the logic in
        some cases. It’s unclear if the overall validity of the data in
        these variables was ever evaluated.

  - *Is the outcome variable (or variables) appropriate? Is there a
    thorough univariate analysis of the outcome variable?*
    
      - Yes, the outcome variable is appropriate.
      - The team very clearly pointed out one very good indicator of
        outliers - that the mean was similar to the median for this
        variable. They also reported its min and max values.
      - They also showed a histogram of this variable and explained this
        figure, which was helpful.

  - *Did the team identify one, or a few, explanatory variables and
    perform a thorough univariate analysis of each one? Did the team
    clearly state why they chose these explanatory variables, does this
    explanation make sense in term of their research question?*
    
      - They identified these straightaway in the introduction and made
        some excellent points around why they included some
        “probability” values and not others. The discussion around
        `prpris` was especially excellent. \]
      - Additional univariate analyses would have been helpful. The team
        has an excellent figure showing the logged wage variables - it
        would help to see univariate analyses of the *unlogged*
        variables - especially with an eye towards data quality (are
        there value that are out of range? or at the very extremes of
        the distribution? log transform limits the effect of outliers
        and can mask this).
      - The discussion of categorical variables was especially clear and
        helpful.
      - More figures showing the distribution of predictor variables
        would help (along the lines of what was shown for crime rate).
      - One note on density: Wages are typically higher in places that
        have higher density not because living costs are higher in
        regions of higher density. Beyond the minimum wage, wages are
        higher for workers that add more value, and they are typically
        engaged in activities typically concentrated in regions of
        higher density – federal workers maybe a valid exception.

  - *Did the team consider available variable transformations and select
    them with an eye towards model plausibility and interperability?*
    
      - Somewhat. They logged the wage variables, which was a good call.
        They explained these in terms of interpretatability. However,
        the report could be improved by adding some discussion of model
        fit (for example by showing scatterplots of crmrte ~ predictors
        and showing that logging either or both sides of this transforms
        variables such that linear fits are appropriate).

  - *Are transformations used to expose linear relationships in
    scatterplots?*
    
      - It would help to see these linear relationships both before and
        after the transformations, to better justify these transforms.
        The matrix showing correlations was excellent - and could be
        further improved by adding more interpretation around it. What
        are some takeaways from this figure? Anything surprising? What
        is the comparison when variables are not transformed?

  - *Is there enough explanation in the text to understand the meaning
    of each visualization?*
    
      - Generally, yes. Pulling out more insights around these figures
        would be a further improvement (for example, around the matrix
        as stated above).

## 4.0 Regression Models: Base Model.

  - *Does this model only include key explanatory variables? Do the
    variables make sense given the measurement goals?*
    
      - Yes, although it was somewhat sparse - the team used 2 variables
        (density & prarr) to predict crime. These were appropriate and
        made sense. They could have perhaps improved this model with the
        addition of a variable or two but it wouldn’t be 100% necessary
        at this stage. The reasoning behind their inclusion of these
        variables was reasonable.

  - *Did the team apply reasonable transformations to these variables,
    to capture the nature of the relationships?*
    
      - There were no transformations applied. There was a scatterplot
        in the matrix they used that seemed to represent the
        relationship between crmrte & prbarr (first column, 4th
        scatterplot down) - it doesn’t seem especially linear (it looks
        borderline exponential); taking the log of crmrte may have been
        an improvement on this model.

## 4.1 Regression Model: Second Model.

  - *Does this model represent a balanced approach, including variables
    that advance modeling goals without causing major issues?*
    
      - This section was really excellent. Linking each model to
        specific hypotheses made the logic very clear and easy to
        follow. Justification was made for each step. However, this
        could be improved with additional EDA or at least more explicit
        references to the matrix produced towards the beginning of the
        report.
      - One consideration could the directionality of influence of
        certain variables - for example, could the police per capita be
        influenced by the crime rate (and vice versa)? What would this
        mean for the model? Acknowledging this type of issue would help
        strengthen the arguments throughout this section.

  - *Does the model suceed in reducing standard errors of the key
    variables compared to the base model? Does it capture major
    nonlinearities in the joint distribution of the variables?*
    
      - Yes, these models were an improved fit compared to the base,
        minimal model.
      - Generally, the use of statistical tests for hypotheses were very
        appropriate and interesting. More could be added in the text to
        explain each test, what would be expected if the null versus
        alternative hypotheses were true, and what occurred.

## 4.2 Regression Model: Third Model.

  - *Does this model represent a maximalist approach, erring on the side
    of including most variables? Is it still a reasonable model? Are
    there any variables that are outcomes, and should therefore still be
    excluded? Is there too much multicolinearity, to the point that the
    key causal effects cannot be measured?*
    
      - Yes, it certainly does represent a maximalist approach\! It
        included almost every other variable.
      - The police per capita variable could be interpreted as an
        outcome, and was included in the second stage of modeling in
        addition to this one. It would be good to discuss this and
        provide justification.
      - All of the wage variables were included - this could perhaps
        introduce some issues in the model. Perhaps only some of these
        should be used, even at this maximalist stage.

## 4.3 Assessment of the CLM.

  - *Has the team assessed each of the CLM assumptions (including random
    sampling)? Did they use visual tools or statistical tests, as
    appropriate? Did they respond appropriately to any violations?*
    
      - Yes. This is one of the strongest pieces of the report. Visual
        checks along with statistical tests were used throughout and
        each portion was explained very well.
      - However, removing the 10 counties with “probability” variables
        over 1 hurts on the count of the random sampling assumption and
        this issue was not acknowleged.

## 4.4 The Regression Table.

  - *Are the model specifications properly chosen to outline the
    boundary of reasonable choices? Is it easy to find key coefficients
    in the regression table? Does the text include a discussion of
    practical significance for key effects?*
    
      - Yes, the model specifications seem reasonable. The regression
        table (created with stargazer) was excellent. More could have
        been explained here regarding practical significance.
        Statistical significance was explained and a lot of the
        practical significance was explained in the conclusion but it
        might be an improvement to see some of that side by side. E.g.,
        X was statistically significant and so this means Y
      - About the sentence: “The key coefficient of -0.059 for prbarr
        suggests that increasing the probability of arrest by 10
        percentage points would be associated with about 5.9 fewer
        crimes per 1,000 people, holding other factors constant.” –\> It
        should be “10%” instead of “10 percentage points” (for the math
        on the log of prbarr work, you should multiply prbarr by 1.1,
        not add 0.1 to it).

## 5.0 The Omitted Variables Discussion.

  - *Did the report miss any important sources of omitted variable bias?
    Are the estimated directions of bias correct? Was their explanation
    clear? Is the discussion connected to whether the key effects are
    real or whether they may be solely an artifact of omitted variable
    bias?*
    
      - This was another very strong aspect of the report. The process
        was clearly explained so that the supporting text was easily
        interpretable. The connection to the model was clear. The
        connection to whether the key effect (prarr) was real is clear.
        The directions appear to be correct - in that the reasoning
        seems accurate enough.
      - However, only one key effect was examining (prarr). Since this
        was the main effect evaluated, that could be fair. However,
        there was a lot of discussion of density and its relationship to
        other variables so the explanation leaves me wondering what
        omitted variable bias could mean for that effect as well\!

## 6.0 Conclusion.

  - *Does the conclusion address the high-level concerns of a political
    campaign? Does it raise interesting points beyond numerical
    estimates? Does it place relevant context around the results?*
    Absolutely. The conclusion was another strong part of this report.
    There is a lot of context and the bigger picture is taken into
    account (e.g., the contentious nature of policing policy).

## 7.0 Conclusion: Other aspects.

  - *Can you find any other errors, faulty logic, unclear or
    unpersuasive writing, or other elements that leave you less
    convinced by the conclusions?* The biggest piece in this category is
    the overall evaluation of data quality. the arguments throughout
    would be much stronger if the basis for them - the data - was more
    thoroughly shown to be reliable.

**Very nice job overall\! We were thoroughly impressed, especially with
your evaluation of your models.**

Please be thorough and read the report critically, actively trying to
find weaknesses. Your comments will directly help your peers get the
most value out of the project.
