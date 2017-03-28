#!/usr/bin/python
# -*- coding: utf-8 -*-

# A biblioteca 'numpy' contém um excelente pacote para trabalhar com matrizes
import numpy as np
from numpy import linalg as LA

def p(text, result):
	print '\n%s'%text
	print result

# Definindo matrizes 5x5
m1 = np.random.randint(-9, 10, size=(5, 5))
m2 = np.random.randint(-9, 10, size=(5, 5))
#m1 = np.array([[1,2,3],[1,3,3],[1,2,4]])
#m2 = np.array([[6,-2,-3],[-1,1,0],[-1,0,1]])
p('Matriz 1:', m1)
p('Matriz 2:', m2)

# Soma algébrica
p('Soma M1 + M2', np.add(m1, m2))
p('Soma 4 + M1', np.add(4, m1))

# Multiplicação
p('Multiplicação M1 * M2', np.matmul(m1, m2))
p('Multiplicação M2 * M1', np.matmul(m2, m1))
p('Multiplicação 4 * M1', 4 * m1)

# Triangular inferior e superior
p('Triangular Superior de M1', np.triu(m1))
p('Triangular Inferior de M1', np.tril(m1))

# Diagonal 
p('Matriz diagonal baseada em M1', np.diag(np.diag(m1)))

# Identidade
p('Matriz identidade de tamanho 5', np.identity(5))


# Transposta e simétrica
m1 = np.matrix([[3,-1,1],[-1,5,-1],[1,-1,3]]) # Ex:Simétrico=True
#m1 = np.array([[4,5],[2,1]]) # Matriz 2x2
#m1 = np.matrix([[2,0,0],[0,1,0],[0,0,2]])  # Teste autovalor e autovetor
m2 = np.matrix([[2,1,-1],[0,1,1],[0,0,2]]) # Teste autovalor e autovetor

transposta = np.matrix.transpose(m1)
p('Transposta de M1', transposta)
print 'M1 é simétrica?   R: %r' % (np.array_equal(m1,transposta))


# Inversa - As funções de linalg podem apresentar erros de precisão de ponto flutuante
p('Inverso de M1 (M1\')', np.linalg.inv(m1))

# Determinante
p('Determinante de M1', np.linalg.det(m1))

# Adjunta (inv = adj / det)
p('Adjunta de M1', np.linalg.det(m1) * np.linalg.inv(m1))

# Menor complementar
def menorComp(matriz, i, j):
	# Retirar a linha e coluna dos elementos e calcular o determinante
	temp = np.delete(np.delete(matriz, j, 1), i, 0)
	return np.linalg.det(temp)
p('Menor complementar de M1[0][0]', menorComp(m1, 0, 0))
p('Menor complementar de M1[1][1]', menorComp(m1, 1, 1))
p('Menor complementar de M1[2][1]', menorComp(m1, 2, 1))
p('Menor complementar de M1[0][2]', menorComp(m1, 0, 2))

# Matriz de cofatores
def matrizDeCofatores(matriz):
	# Para cada elemento, calcular o menor complementar (determinante removendo a linha e coluna)
	# Em cada valor obtido, multiplicar por ((-1)**(i+j)))
	temp = np.full_like(matriz, 0)
	for index in np.ndindex(matriz.shape):
		i,j = (index)
		temp[index] = ((-1)**(i+j)) * menorComp(matriz, i, j)
	return temp
p('Matriz de cofatores de M1', matrizDeCofatores(m1))

# Posto ou Rank
p('Rank (ou posto) da matriz M1', np.linalg.matrix_rank(m1))


# Autovalor e autovetor
autovalor, autovetor = np.linalg.eig(m1)
p("Autovalor da matriz M1:", autovalor)
p("Autovetor da matriz M1:", np.around(autovetor))

autovalor, autovetor = np.linalg.eig(m2)
p("Autovalor da matriz M2:", autovalor)
p("Autovetor da matriz M2:", np.around(autovetor))

# Equações lineares
# Exemplo:
#   x – y – z + w = 10
#   2x + 3y + 5z – 2w = 21
#   4x – 2y – z + w = 16
coeficientes = np.array([[ 1,-1,-1, 1],
						 [ 2, 3, 5,-2],
						 [ 4,-2,-1, 1]])
valores = np.array([10,21,16])

# Este método requer uma matrix quadrática
#result = np.linalg.solve(coeficientes, valores) 

# Método 'least-squares-fitting', que minimiza o erro da solução aproximada
result = np.linalg.lstsq(coeficientes, valores)

p("Resultados de um sistema de equações: ", result)
