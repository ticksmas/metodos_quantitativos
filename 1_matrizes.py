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
# É diagonal / É identidade / É simétrica 
# Inversa
# Transposta
# Adjunta
# Determinante
# Menor complementar
# Posto
# Autovalor
# Autovetor

