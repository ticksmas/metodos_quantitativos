#--------------------------------------------------------------------------------
# Disciplina: Metodos Quantitativos em CC - 2017
# Professor : Luis Enrique Zarate
# Alunos    : Matheus Alcantara
#             Pedro Ruas
#             Marcos W. Rodrigues
# Abordagens: Matrizes (Definições, Operações, Produto, Matrizes triangulares,
#                      Identidade, Inversa, Transposta, Simétrica, Menor complemen-
#                      tário, Cofator, Matriz adjunta, Determinante, Posto (Rank),
#                      Auto-Valores e Auto-Vetores, Operador linear
#--------------------------------------------------------------------------------

# Definindo matrizes

A <- matrix(sample(0:9,9), nrow=3, ncol=3)
B <- matrix(sample(0:9,9), nrow=3, ncol=3)
#A <- matrix(c(1,2,6,2,3,5,1,7,9), nrow=3, ncol=3, byrow=TRUE, dimnames=list(c("X","Y","Z"), c("A","B","C")))
#B <- matrix(c(5,9,3,4,2,1,1,0,4), nrow=3, ncol=3, byrow=TRUE, dimnames=list(c("X","Y","Z"), c("A","B","C")))
#C <- matrix(c(5,3,2,1,1,0), nrow=3, ncol=2, byrow=TRUE, dimnames=list(c("X","Y","Z"), c("A","B")))

cat("Matriz A:\n") ; A
cat("Matriz B:\n") ; B

#----------

# Operacoes com matrizes

cat("Soma dos elementos das matrizes (A+B):\n") ; A+B
cat("Escalar multiplica cada elemento da matriz (3*A):\n") ; A ; 3*A
cat("Multiplicacao dos elementos das matrizes (A*B):\n") ; A ; B ; A*B
cat("Multiplicacao de matrizes (A*B):\n") ; A ; B ; A %*% B
I <- diag(1,nrow=dim(A)[1]) #Matriz identidade
cat("Matriz identidade de tamanho 3:\n") ; I
cat("Multiplicacao da matriz pela matriz identidade resulta na propria matriz (A*I):\n") ; A ; diag(3) ; A %*% I

cat("Diagonal da matriz da matriz A:\n") ; diag(A)

cat("Transposta da matriz A:\n") ; t(A)

cat("Matriz inversa de A (Somente matriz quadrada):\n") ; solve(A)
#cat("Matriz inversa de Moore-Penrose:\n") ; ginv(A) #Precisa de install.packages(MASS)
cat("Multiplicacao da matriz inversa de A pela matriz B (A'*B):\n") ; crossprod(A,B)

cat("Determinante da matriz A - (det(A)):\n") ; det(A)
cat("Determinante da matriz transposta A - det(T(A)):\n") ; det(t(A))

#----------

# Posto ou Rank

cat("Posto (rank) da matriz A:\n") ; A ; matrix(rank(A), nrow=length(A[,1]), ncol=length(A[1,]))

#----------

# Triangular superior e inferior

library(base) #install.packages("base")
C <- matrix(1:20, 4, 5)
cat("Triangular superior:\n") ; upper.tri(C, diag=TRUE)
cat("Triangular inferior:\n") ; lower.tri(C, diag=TRUE)

#----------

# Cofator

A <- matrix(data=c(1, 2, 3, 2, 5, 9, 5, 7, 8), nrow=3, ncol=3)
minor <- function(A, i, j) det( A[-i,-j] )
cofactor <- function(A, i, j) (-1)^(i+j) * minor(A,i,j)
adjoint1 <- function(A) { #Loop
  n <- nrow(A)
  B <- matrix(NA, n, n)
  for( i in 1:n )
    for( j in 1:n )
      B[j,i] <- cofactor(A, i, j)
  B
}
adjoint2 <- function(A) { #Outer
  n <- nrow(A)
  t(outer(1:n, 1:n, Vectorize(
    function(i,j) cofactor(A,i,j)
  )))
}
#det(A) * diag(nrow(A))
cat("Cofator da matriz A:\n") ; A %*% adjoint1(A)
cat("Cofator da matriz A:\n") ; A %*% adjoint2(A)

cat("A matriz A eh simetrica da matriz B?:\n") ; A == B
cat("A matriz A eh simetrica da matriz B?:\n") ; A == t(A)
isSymmetric.matrix(B)

#----------

# Sistemas de equacoes lineares

#  x + 2y + 3z = 20  
# 2x + 5y + 9z = 100  
# 5x + 7y + 8z = 200

A <- matrix(data=c(1, 2, 3, 2, 5, 9, 5, 7, 8), nrow=3, ncol=3, byrow=TRUE)    
x <- matrix(data=c(20, 100, 200), nrow=3, ncol=1, byrow=FALSE)
b <- round(solve(A, x), 3) ; rownames(b) <- c("x","y","z")
cat("Sistema de equacoes [A][x]=[y]\n") 
cat("Matriz A:\n") ; A 
cat("Matriz x:\n") ; x
cat("Matriz solucao b:\n") ; b

#----------

# Autovalores e autovetores

#A <- matrix(sample(0:9,9), nrow=3, ncol=3)
A <- matrix(c(3,-1,1,-1,5,-1,1,-1,3), nrow=3, ncol=3)
y <- eigen(A)
cat("Autovalores da matriz A:\n") ; y$values
cat("Autovetores da matriz A:\n") ; round(y$vectors)

#----------

# Metodo de decomposicao/fatorizacao dos minimos quadrados

A <- matrix(c(3,-1,1,-1,5,-1,1,-1), nrow=4, ncol=2)
B <- matrix(c(3,2,0,2,3,0,0,0), nrow=4, ncol=2)

mq <- lsfit(A,B, wt=NULL, intercept=TRUE, tolerance=1.e-07,yname=NULL)
cat("Metodo dos minimos quadrados:\n") ; ls.print(mq) #mq
#s <- solve(t(A) %*% B) %*% t(A) %*% A[,1]

#----------

# Metodo de reducao Gauss-Jordan

install.packages("pracma", repos="http://R-Forge.R-project.org")
library(pracma)

A = matrix(c(1,1,1,1,-1,-1,1,1,1,-1,-1,1,1,2,3,4), nrow=4, ncol=4)
cat("Matriz A:\n") ; A

cat("Linha reduzida:\n") ; rref(A)

#----------

#Matriz 6x4
Xij <- matrix(seq(1:24), ncol = 4) 
rownames(Xij) <- paste("S", seq(1, dim(Xij)[1]), sep="")
colnames(Xij) <- paste("V", seq(1, dim(Xij)[2]), sep="")
Xij

#Vetor de 1s
um <- rep(1, dim(Xij)[1])

#Media da coluna 
X.means <- t(um) %*% Xij / dim(Xij)[1] #CÃ¡lculo por etapas
colMeans(Xij) #CÃ¡lculo direto

X.diff <- Xij - um %*% X.means

X.cen <- scale(Xij,scale=FALSE) #MÃ©dia do centro da matriz

#----------

#Variancia e Covariancia

X.cov <- t(X.diff) %*% X.diff / (dim(X.diff)[1]-1)
round(X.cov)

round(cov(Xij),2) #CovariÃ¢ncia
cor(Xij) #CorrelaÃ§Ã£o

#----------
#----------
