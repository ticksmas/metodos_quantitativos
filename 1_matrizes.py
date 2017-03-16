#!/usr/bin/python
# -*- coding: utf-8 -*-

# A biblioteca 'numpy' contém um excelente pacote para trabalhar com matrizes
import numpy as np

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
m1 = np.array([[1,2,3],[2,3,3],[3,3,4]]) # Ex:Simétrico=True
transposta = np.matrix.transpose(m1)
p('Transposta de M1', transposta)
print 'M1 é simétrica?   R: %r' % (np.array_equal(m1,transposta))


# Inversa - As funções de linalg podem apresentar erros de precisão de ponto flutuante
p('Inverso de M1 (M1\')', np.linalg.inv(m1))

# Determinante
p('Determinante de M1', np.linalg.det(m1))

# Adjunta (inv = adj / det)
p('Adjunta de M1', np.linalg.det(m1) * np.linalg.inv(m1))


#TODO: Menor complementar
def menorComp(matriz):
	"Calcula o menor complementar de uma matriz"
	i, j = matriz.shape
	#return [row[:j] + row[j+1:] for row in (matriz[:i] + matriz[i+1:])]
	return np.add(matriz[:2],matriz[2:])
p('Menor complementar de M1', menorComp(m1))

#TODO: Cofatores
#TODO: Menor complementar
#TODO: Posto
#TODO: Autovalor
#TODO: Autovetor