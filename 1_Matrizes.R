#--------------------------------------------------------------------------------
# Disciplina: Metodos Quantitativos em CC - 2017
# Professor : Luis Enrique Zarate
# Alunos    : Matheus Alcantara
#             Pedro Ruas
#             Marcos W. Rodrigues
#--------------------------------------------------------------------------------

#---------- Aula 14/03/2017

# Definindo matrizes 3x3

A <- matrix(sample(0:9,9), nrow=3, ncol=3)
B <- matrix(sample(0:9,9), nrow=3, ncol=3)
#A <- matrix(c(1,2,6,2,3,5,1,7,9), nrow=3, ncol=3, byrow=TRUE, dimnames=list(c("X","Y","Z"), c("A","B","C")))
#B <- matrix(c(5,9,3,4,2,1,1,0,4), nrow=3, ncol=3, byrow=TRUE, dimnames=list(c("X","Y","Z"), c("A","B","C")))
#C <- matrix(c(5,3,2,1,1,0), nrow=3, ncol=2, byrow=TRUE, dimnames=list(c("X","Y","Z"), c("A","B")))

cat("Matriz A:\n") ; A
cat("Matriz B:\n") ; B

# Operacoes com matrizes

cat("Soma dos elementos das matrizes (A+B):\n") ; A+B
cat("Escalar multiplica cada elemento da matriz (3*A):\n") ; A ; 3*A
cat("Multiplicacao dos elementos das matrizes (A*B):\n") ; A ; B ; A*B
cat("Multiplicacao de matrizes (A*B):\n") ; A ; B ; A %*% B
cat("Multiplicacao da matriz pela matriz identidade resulta na propria matriz (A*I):\n") ; A ; diag(3) ; A %*% diag(3)

cat("Diagonal da matriz da matriz A:\n") ; diag(A)

cat("Transposta da matriz A:\n") ; t(A)

cat("Matriz inversa de A (Somente matriz quadrada):\n") ; solve(A)
#cat("Matriz inversa de Moore-Penrose:\n") ; ginv(A) #Precisa de install.packages(MASS)
cat("Multiplicacao da matriz inversa de A pela matriz B (A'*B):\n") ; crossprod(A,B)

cat("Determinante da matriz A - (det(A)):\n") ; det(A)
cat("Determinante da matriz transposta A - det(T(A)):\n") ; det(t(A))

cat("Decomposicao simples da matriz A:\n") ; y <- svd(A) ; y # y$d ; y$u ; y$v
#cat("Decomposicao simples - Valores singulares:\n") ; y$d
#cat("Decomposicao simples - Vetores singular a esquerda de A:\n") ; y$u
#cat("Decomposicao simples - Vetores singular a direita de A:\n") ; y$v

#Cofator
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

#---------- Aula 21/03/2017

# Sistemas de equacoes

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

# Autovalores e autovetores

#A <- matrix(sample(0:9,9), nrow=3, ncol=3)
A <- matrix(c(3,-1,1,-1,5,-1,1,-1,3), nrow=3, ncol=3)
y <- eigen(A)
cat("Autovalores da matriz A:\n") ; y$values
cat("Autovetores da matriz A:\n") ; round(y$vectors)

# Metodo de decomposicao/fatorizacao dos minimos quadrados

A <- matrix(c(3,-1,1,-1,5,-1,1,-1), nrow=4, ncol=2)
B <- matrix(c(3,2,0,2,3,0,0,0), nrow=4, ncol=2)

mq <- lsfit(A,B, wt=NULL, intercept=TRUE, tolerance=1.e-07,yname=NULL)
cat("Metodo dos minimos quadrados:\n") ; ls.print(mq) #mq
#s <- solve(t(A) %*% B) %*% t(A) %*% A[,1]

# Metodo de reducao Gauss-Jordan

install.packages("pracma", repos="http://R-Forge.R-project.org")
library(pracma)

A = matrix(c(1,1,1,1,-1,-1,1,1,1,-1,-1,1,1,2,3,4), nrow=4, ncol=4)
cat("Matriz A:\n") ; A

cat("Linha reduzida:\n") ; rref(A)

#--------------------------------------------------------------------------------
#--------------------------------------------------------------------------------

