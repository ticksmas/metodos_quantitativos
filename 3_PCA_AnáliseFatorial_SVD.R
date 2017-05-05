#--------------------------------------------------------------------------------
# Disciplina: Metodos Quantitativos em CC - 2017
# Professor : Luis Enrique Zarate
# Alunos    : Matheus Alcantara
#             Pedro Ruas
#             Marcos W. Rodrigues
# Abordagens: Análise de Componentes Principais (Principal Component Analysis - PCA)
#             Análise Fatorial (Factor Analysis - FA)
#             Decomposição em valor Singular (Singular Value Decomposition - SVD)
#--------------------------------------------------------------------------------

#--------------------------------------------------------------------------------
#--------------------------------------------------------------------------------
# PCA - Análise de Componentes Principais (Principal Component Analysis)
#--------------------------------------------------------------------------------
#--------------------------------------------------------------------------------

library(factoextra)
library(devtools) #install.packages("devtools")
#devtools::install_github("kassambara/factoextra")

data(decathlon2)
#Extract only active individuals and variables for principal component analysis:
decathlon2.active <- decathlon2[1:23, 1:10]
head(decathlon2.active[, 1:6])
res.pca <- prcomp(decathlon2.active, scale=TRUE)
#The values returned, by the function prcomp(), are:
names(res.pca)

print(res.pca)

#the standard deviations of the principal components (the square roots of the eigenvalues)
head(res.pca$sdev)
  
#rotation : the matrix of variable loadings (columns are eigenvectors)
head(unclass(res.pca$rotation)[, 1:4])

#center, scale : the centering and scaling used, or FALSE
# Eigenvalues
eig <- (res.pca$sdev)^2
# Variances in percentage
variance <- eig*100/sum(eig)
# Cumulative variances
cumvar <- cumsum(variance)
eig.decathlon2.active <- data.frame(eig=eig, variance=variance, cumvariance=cumvar)
head(eig.decathlon2.active)

summary(res.pca)

fviz_screeplot(res.pca, ncp=10)

head(res.pca)

fviz_pca_var(res.pca)

fviz_pca_var(res.pca, col.var="cos2") +
  scale_color_gradient2(low="white", mid="blue", 
                        high="red", midpoint=0.5) + theme_minimal()
# Contributions of variables on PC1
fviz_pca_contrib(res.pca, choice = "var", axes = 1)

# Contributions of variables on PC2
fviz_pca_contrib(res.pca, choice = "var", axes = 2)

# Total contribution on PC1 and PC2
fviz_pca_contrib(res.pca, choice = "var", axes = 1:2)

fviz_pca_contrib(res.pca, choice = "var", axes = 1, top = 7)

# Control variable colors using their contributions
fviz_pca_var(res.pca, col.var="contrib")

# Change the gradient color
fviz_pca_var(res.pca, col.var="contrib") +
  scale_color_gradient2(low="white", mid="blue", 
                        high="red", midpoint=50) + theme_minimal()

#--------------------------------------------------------------------------------
#--------------------------------------------------------------------------------
# Análise Fatorial (Factor Analysis)
#--------------------------------------------------------------------------------
#--------------------------------------------------------------------------------

install.packages("psych")
library(psych) #require(psych)
require(foreign)
library( GPArotation )

#Data
#28 variables, and 1000 observations, who were asked to rate themselves on a Lickert scale of 1 to 6. 
#We should be aware of two issues: 
#Lickert scales are known to produce skewed results because of testing fatigue and general boredom, and 
#people are not always very accurate at self-reporting. 
#The last three variables in the data frame report age, education and gender.
data(bfi)
head(bfi)
describe(bfi)

df <- bfi[1:25]
scree(df)
fa.parallel(bfi)

out <- fa(df,6,fm='minres',rotate='oblimin')
print(out$loadings,cut=.2)
fa.diagram( out )
out <- fa(df,5,fm='minres','oblimin')
print(out$loadings,cut=.2)
fa.diagram( out )

#--------------------------------------------------------------------------------
#--------------------------------------------------------------------------------
# SVD - Decomposição em valor Singular (Singular Value Decomposition)
#--------------------------------------------------------------------------------
#--------------------------------------------------------------------------------

cnut <- read.dta("http://statistics.ats.ucla.edu/stat/data/cerealnut.dta")

#centering the variables
mds.data <- as.matrix(sweep(cnut[, -1], 2, colMeans(cnut[, -1])))
dismat <- dist(mds.data)
mds.m1 <- cmdscale(dismat, k = 8, eig = TRUE)
mds.m1$eig

mds.m1 <- cmdscale(dismat, k = 2, eig = TRUE)
x <- mds.m1$points[, 1]
y <- mds.m1$points[, 2]
plot(x, y)
text(x + 20, y, label=cnut$brand)

# eigenvalues
xx <- svd(mds.data %*% t(mds.data))
xx$d

# coordinates
xxd <- xx$v %*% sqrt(diag(xx$d))
x1 <- xxd[, 1]
y1 <- xxd[, 2]

plot(x1, y1)
text(x1 + 20, y1, label=cnut$brand)

#--------------------------------------------------------------------------------
#--------------------------------------------------------------------------------
