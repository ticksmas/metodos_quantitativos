#--------------------------------------------------------------------------------
# Disciplina: Metodos Quantitativos em CC - 2017
# Professor : Luis Enrique Zarate
# Alunos    : Matheus Alcantara
#             Pedro Ruas
#             Marcos W. Rodrigues
# Abordagens: Espaços e Sub-espaços (Espaços e Sub-espaços vetoriais, Combinação
#                      Linear, Sub-espaço vetorial gerado, Dependência e Indepen-
#                      dência Linear, Base de um Espaço vetorial, Transformações
#                      Lineares, Núcleo e imagem de uma transformação linear
#--------------------------------------------------------------------------------

#----------
#----------

# Espaços e Sub-espaços vetoriais




#----------
#----------

# Combinação Linear




#----------
#----------

# Sub-espaço vetorial gerado




#----------
#----------

# Dependência e Independência Linear

#http://www.statmethods.net/stats/frequencies.html

A <- matrix(data = 1:25, nrow = 5, ncol = 5, byrow = TRUE)
chisq.test(A)

library(MASS)
mytable <- xtabs(~A+B+C, data=mydata) 

#Mutual Independence: A, B, and C are pairwise independent.
loglm(~A+B+C, mytable)

#Partial Independence: A is partially independent of B and C (i.e., A is independent of the composite variable BC).
loglin(~A+B+C+B*C, mytable) 

#----------
#----------

# Base de um Espaço vetorial



#----------
#----------

# Transformações Lineares



#----------
#----------

# Núcleo e imagem de uma transformação linear



#----------
#----------
