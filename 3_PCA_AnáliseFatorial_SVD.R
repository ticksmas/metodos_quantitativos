#--------------------------------------------------------------------------------
# Disciplina: Metodos Quantitativos em CC - 2017
# Professor : Luis Enrique Zarate
# Alunos    : Matheus Alcantara
#             Pedro Ruas
#             Marcos W. Rodrigues
# Abordagens: Análise de Componentes Principais (PCA)
#             Análise Fatorial
#             Singular Value Decomposition (SVD)
#--------------------------------------------------------------------------------

#******************
# APAGAR ESTA LINHA [https://cran.r-project.org/doc/contrib/Landeiro-Introducao.pdf]
#******************

install.packages("vegan") #
library(vegan)

#----------

# PCA - Análise de Componentes Principais (Principal Component Analysis)

#PCA de Covariância

data(varechem)
resu.pca <- prcomp(varechem) #PCA
resu.pca # Mostra os desvios dos componentes principais e os loadings.
summary(resu.pca) # Mostra a por centagem de variância  capturada por cada eixo.
resu.pca$x # Salvar os scores da PCA (os eixos)
resu.pca$loadings #salvar os loadings
biplot(resu.pca) #plota os scores dos locais e 
screeplot(resu.pca)

#PCA de correlação

round(apply(varechem,2,var),4) 
varechem.P <- scale(varechem) #padronizar os dados
prcomp(varechem.P) #PCA dos dados padronizados
#ou
prcomp(varechem, scale=T) #PCA alterando o argumento Scale


#----------

# Análise Fatorial





#----------

# SVD - Decomposição em valor Singular (Singular Value Decomposition)

A <- matrix(sample(0:9,9), nrow=3, ncol=3)

cat("Decomposicao simples da matriz A:\n") ; y <- svd(A) ; y # y$d ; y$u ; y$v
#cat("Decomposicao simples - Valores singulares:\n") ; y$d
#cat("Decomposicao simples - Vetores singular a esquerda de A:\n") ; y$u
#cat("Decomposicao simples - Vetores singular a direita de A:\n") ; y$v


#----------
#----------
