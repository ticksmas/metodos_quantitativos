#!/usr/bin/python
# -*- coding: utf-8 -*-

# A biblioteca 'numpy' contém um excelente pacote para trabalhar com matrizes
import numpy as np

# Definindo matrizes 5x5
m1 = np.random.randint(-9, 10, size=(5, 5))
m2 = np.random.randint(-9, 10, size=(5, 5))
print 'Matriz 1:'
print m1

print '\nMatriz 2:' 
print m2

# Soma algébrica
soma = np.add(m1, m2)
print '\nSoma M1 + M2:'
print soma

soma = np.add(4, m1)
print '\nSoma 4 + M1:'
print soma

# Multiplicação
# Triangular inferior e superior
# É diagonal / É identidade / É simétrica 
# Inversa
# Transposta
# Adjunta
# Determinante
# Menor complementar
# Posto
# Autovalor
# Autovetor
