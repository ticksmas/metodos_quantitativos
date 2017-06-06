#--------------------------------------------------------------------------------
# Disciplina: Metodos Quantitativos em CC - 2017
# Professor : Luis Enrique Zarate
# Alunos    : Matheus Alcantara
#             Pedro Ruas
#             Marcos W. Rodrigues
# Abordagens: ANOVA e MANOVA
#             ANOVA - Analysis of Variance
#             MANOVA - Multivariate Analysis of Variance
#--------------------------------------------------------------------------------

#--------------------------------------------------------------------------------
#--------------------------------------------------------------------------------
# ANOVA E MANOVA
#--------------------------------------------------------------------------------
#--------------------------------------------------------------------------------

#----- 
#----- ANOVA - Analysis of Variance
#----- 

data <- read.table(header=TRUE, text='
 subject sex   age before after
                   1   F   old    9.5   7.1
                   2   M   old   10.3  11.0
                   3   M   old    7.5   5.8
                   4   F   old   12.4   8.8
                   5   M   old   10.2   8.6
                   6   M   old   11.0   8.0
                   7   M young    9.1   3.0
                   8   F young    7.9   5.2
                   9   F   old    6.6   3.4
                   10   M young    7.7   4.0
                   11   M young    9.4   5.3
                   12   M   old   11.6  11.3
                   13   M young    9.9   4.6
                   14   F young    8.6   6.4
                   15   F young   14.3  13.5
                   16   F   old    9.2   4.7
                   17   M young    9.8   5.1
                   18   F   old    9.9   7.3
                   19   F young   13.0   9.5
                   20   M young   10.2   5.4
                   21   M young    9.0   3.7
                   22   F young    7.9   6.2
                   23   M   old   10.1  10.0
                   24   M young    9.0   1.7
                   25   M young    8.6   2.9
                   26   M young    9.4   3.2
                   27   M young    9.7   4.7
                   28   M young    9.3   4.9
                   29   F young   10.7   9.8
                   30   M   old    9.3   9.4
                   ')

#One way between ANOVA

# One way between:
# IV: sex
# DV: before
aov1 <- aov(before ~ sex, data=data)
summary(aov1)
#>             Df Sum Sq Mean Sq F value Pr(>F)
#> sex          1   1.53   1.529   0.573  0.455
#> Residuals   28  74.70   2.668

# Show the means
model.tables(aov1, "means")
#> Tables of means
#> Grand mean
#>          
#> 9.703333 
#> 
#>  sex 
#>      F      M
#>     10  9.532
#> rep 11 19.000

#Two way between ANOVA

# 2x2 between:
# IV: sex
# IV: age
# DV: after
# These two calls are equivalent
aov2 <- aov(after ~ sex*age, data=data)
aov2 <- aov(after ~ sex + age + sex:age, data=data)
summary(aov2)
#>             Df Sum Sq Mean Sq F value  Pr(>F)    
#> sex          1  16.08   16.08   4.038  0.0550 .  
#> age          1  38.96   38.96   9.786  0.0043 ** 
#> sex:age      1  89.61   89.61  22.509 6.6e-05 ***
#> Residuals   26 103.51    3.98                    
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

# Show the means
model.tables(aov2, "means")
#> Tables of means
#> Grand mean
#>          
#> 6.483333 
#> 
#>  sex 
#>          F      M
#>      7.445  5.926
#> rep 11.000 19.000
#> 
#>  age 
#>        old  young
#>      7.874  5.556
#> rep 12.000 18.000
#> 
#>  sex:age 
#>      age
#> sex   old    young 
#>   F    6.260  8.433
#>   rep  5.000  6.000
#>   M    9.157  4.042
#>   rep  7.000 12.000

# Tukey HSD post-hoc test

TukeyHSD(aov2)

#>   Tukey multiple comparisons of means
#>     95% family-wise confidence level
#> 
#> Fit: aov(formula = after ~ sex + age + sex:age, data = data)
#> 
#> $sex
#>          diff       lwr        upr     p adj
#> M-F -1.519139 -3.073025 0.03474709 0.0549625
#> 
#> $age
#>               diff       lwr        upr     p adj
#> young-old -2.31785 -3.846349 -0.7893498 0.0044215
#> 
#> $`sex:age`
#>                       diff        lwr        upr     p adj
#> M:old-F:old      2.8971429 -0.3079526  6.1022384 0.0869856
#> F:young-F:old    2.1733333 -1.1411824  5.4878491 0.2966111
#> M:young-F:old   -2.2183333 -5.1319553  0.6952887 0.1832890
#> F:young-M:old   -0.7238095 -3.7691188  2.3214997 0.9138789
#> M:young-M:old   -5.1154762 -7.7187601 -2.5121923 0.0000676
#> M:young-F:young -4.3916667 -7.1285380 -1.6547953 0.0008841

#ANOVAs with within-subjects variables

library(tidyr)

# This is what the original (wide) data looks like
# subject sex   age before after
#       1   F   old    9.5   7.1
#       2   M   old   10.3  11.0
#       3   M   old    7.5   5.8

# Convert it to long format
data_long <- gather(data, time, value, before:after)
# Look at first few rows
head(data_long)
#>   subject sex age   time value
#> 1       1   F old before   9.5
#> 2       2   M old before  10.3
#> 3       3   M old before   7.5
#> 4       4   F old before  12.4
#> 5       5   M old before  10.2
#> 6       6   M old before  11.0


# Make sure subject column is a factor
data_long$subject <- factor(data_long$subject)

#One-way within ANOVA

# IV (within): time
# DV:          value
aov_time <- aov(value ~ time + Error(subject/time), data=data_long)
summary(aov_time)
#> 
#> Error: subject
#>           Df Sum Sq Mean Sq F value Pr(>F)
#> Residuals 29  261.2   9.009               
#> 
#> Error: subject:time
#>           Df Sum Sq Mean Sq F value   Pr(>F)    
#> time       1 155.53  155.53   71.43 2.59e-09 ***
#> Residuals 29  63.14    2.18                     
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1


# This won't work here for some reason (?)
model.tables(aov_time, "means")
#> Tables of means
#> Grand mean
#>          
#> 8.093333 
#> 
#>  time 
#> time
#>  after before 
#>  6.483  9.703

# Mixed design ANOVA

# 2x2 mixed:
# IV between: age
# IV within:  time
# DV:         value
aov_age_time <- aov(value ~ age*time + Error(subject/time), data=data_long)
summary(aov_age_time)
#> 
#> Error: subject
#>           Df Sum Sq Mean Sq F value Pr(>F)
#> age        1  24.44  24.440    2.89    0.1
#> Residuals 28 236.81   8.457               
#> 
#> Error: subject:time
#>           Df Sum Sq Mean Sq F value   Pr(>F)    
#> time       1 155.53  155.53   98.14 1.18e-10 ***
#> age:time   1  18.77   18.77   11.84  0.00184 ** 
#> Residuals 28  44.37    1.58                     
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

# This won't work here because the data is unbalanced
model.tables(aov_age_time, "means")
#> Tables of means
#> Grand mean
#>          
#> 8.093333 
#> 
#>  age 
#>        old  young
#>      8.875  7.572
#> rep 24.000 36.000
#> 
#>  time 
#>      after before
#>      6.483  9.703
#> rep 30.000 30.000
#> 
#>  age:time 
#>        time
#> age     after  before
#>   old    7.950  9.800
#>   rep   12.000 12.000
#>   young  5.506  9.639
#>   rep   18.000 18.000

#More ANOVAs with within-subjects variables

# Two within variables
aov.ww <- aov(y ~ w1*w2 + Error(subject/(w1*w2)), data=data_long)

# One between variable and two within variables
aov.bww <- aov(y ~ b1*w1*w2 + Error(subject/(w1*w2)) + b1, data=data_long)

# Two between variables and one within variables
aov.bww <- aov(y ~ b1*b2*w1 + Error(subject/(w1)) + b1*b2, data=data_long)

#----- 
#----- MANOVA - Multivariate Analysis of Variance
#----- 

wants <- c("car", "mvtnorm")
has   <- wants %in% rownames(installed.packages())
if(any(!has)) install.packages(wants[!has])

set.seed(123)
P     <- 3
Nj    <- c(15, 25, 20)
Sigma <- matrix(c(16,-2, -2,9), byrow=TRUE, ncol=2)
mu11  <- c(-4,  4)
mu21  <- c( 3,  3)
mu31  <- c( 1, -1)

library(mvtnorm)
Y11 <- round(rmvnorm(Nj[1], mean=mu11, sigma=Sigma))
Y21 <- round(rmvnorm(Nj[2], mean=mu21, sigma=Sigma))
Y31 <- round(rmvnorm(Nj[3], mean=mu31, sigma=Sigma))

dfMan1 <- data.frame(Y =rbind(Y11, Y21, Y31),
                     IV=factor(rep(1:P, Nj)))

manRes1 <- manova(cbind(Y.1, Y.2) ~ IV, data=dfMan1)
summary(manRes1, test="Wilks")

#                   Df   Wilks approx F num Df den Df    Pr(>F)    
#IV         2 0.38675   17.024      4    112 6.222e-11 ***
#  Residuals 57                                             
#---
#  Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

summary(manRes1, test="Roy")
summary(manRes1, test="Pillai")
summary(manRes1, test="Hotelling-Lawley")

# 2x2 Factorial MANOVA with 3 Dependent Variables.
Y <- cbind(y1,y2,y3)
fit <- manova(Y ~ A*B)
summary(fit, test="Pillai")

#----- Two-way MANOVA

Q    <- 2
mu12 <- c(-1,  4)
mu22 <- c( 4,  8)
mu32 <- c( 4,  0)

library(mvtnorm)
Y12  <- round(rmvnorm(Nj[1], mean=mu12, sigma=Sigma))
Y22  <- round(rmvnorm(Nj[2], mean=mu22, sigma=Sigma))
Y32  <- round(rmvnorm(Nj[3], mean=mu32, sigma=Sigma))

dfMan2 <- data.frame(Y <- rbind(Y11, Y21, Y31, Y12, Y22, Y32),
                     IV1 <- factor(rep(rep(1:P, Nj), Q)),
                     IV2 <- factor(rep(1:Q, each=sum(Nj))))

#Type I sum of squares

manRes2 <- manova(cbind(Y.1, Y.2) ~ IV1*IV2, data=dfMan2)
summary(manRes2, test="Pillai")

summary(manRes2, test="Wilks")
summary(manRes2, test="Roy")
summary(manRes2, test="Hotelling-Lawley")

# Type II/III sum of squares

library(car)
fitIII <- lm(cbind(Y.1, Y.2) ~ IV1*IV2, data=dfMan2, contrasts=list(IV1=contr.sum, IV2=contr.sum))
ManRes <- Manova(fitIII, type="III")
summary(ManRes, multivariate=TRUE)

# Detach (automatically) loaded packages (if possible)

try(detach(package:mvtnorm))
try(detach(package:car))
try(detach(package:nnet))
try(detach(package:MASS))

#--------------------------------------------------------------------------------
#--------------------------------------------------------------------------------
