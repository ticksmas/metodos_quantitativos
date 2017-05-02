#--------------------------------------------------------------------------------
# Disciplina: Metodos Quantitativos em CC - 2017
# Professor : Luis Enrique Zarate
# Alunos    : Matheus Alcantara
#             Pedro Ruas
#             Marcos W. Rodrigues
# Abordagens: Analise de Componentes Principais (PCA)
#             Analise Fatorial (FA)
#             Singular Value Decomposition (SVD)
#--------------------------------------------------------------------------------

#Documentation PCA: http://scikit-learn.org/stable/modules/generated/sklearn.decomposition.PCA.html
#Documentation SVD: http://scikit-learn.org/stable/modules/generated/sklearn.decomposition.TruncatedSVD.html
#Documentation FA: http://scikit-learn.org/stable/modules/generated/sklearn.decomposition.FactorAnalysis.html#sklearn.decomposition.FactorAnalysis.get_covariance

import numpy as np
from sklearn.decomposition import PCA
from sklearn.decomposition import TruncatedSVD, FactorAnalysis
from sklearn.random_projection import sparse_random_matrix

#PCA
#X = sparse_random_matrix(100, 100, density=0.01, random_state=42)
#X = np.array([[-1, -1], [-2, -1], [-3, -2], [1, 1], [2, 1], [3, 2]])
X = np.random.randint(0, 10, size=(7, 7))
print(" Matriz:")
print (X)



#PCA(copy=True, iterated_power='auto', n_components=2, random_state=None,svd_solver='auto', tol=0.0, whiten=False)


print("\n\n ================================PCA================================")

pca = PCA(n_components=5)
pca.fit(X)

# Principal axes in feature space, representing the directions of maximum variance in the data. The components are sorted by explained_variance_.
print("Componentes PCA")
print (pca.components_)

#The amount of variance explained by each of the selected components.
print ("Variância explicada por componente:")
print(pca.explained_variance_) 

#Percentage of variance explained by each of the selected components.
print ("Porcentagem de variância explicada por componente:")
print(pca.explained_variance_ratio_) 

print ("Variância explicada acumulada:")
print(pca.explained_variance_ratio_.sum()) 

#Perform dimensionality reduction on X.
print("Redução de dimensionalidade na matriz")
print(pca.transform(X))





#Analise fatorial
print("\n\n ================================ANALISE FATORIAL================================")

#X = sparse_random_matrix(10, 10, density=1, random_state=20)
#X = np.array([[-1, -1], [-2, -1], [-3, -2], [1, 1], [2, 1], [3, 2]])
#print(X)

fa = FactorAnalysis(n_components=5)
fa.fit(X)

print("Componentes FA")
print (fa.components_)

#Compute data covariance with the FactorAnalysis model.
print("Compute data covariance with the FactorAnalysis model")
print (fa.get_covariance())

#The log likelihood at each iteration.
print ("The log likelihood at each iteration:")
print(fa.loglike_) 

#The estimated noise variance for each feature.
print ("The estimated noise variance for each feature:")
print(fa.noise_variance_) 

#Compute the average log-likelihood of the samples
print ("Scores da amostra:")
print(fa.score(X))

#Perform dimensionality reduction on X.
print("Redução de dimensionalidade na matriz")
print(fa.transform(X))



#SVD
print("\n\n ================================SVD================================")

#X = sparse_random_matrix(10, 10, density=1, random_state=20)
#X = np.array([[-1, -1], [-2, -1], [-3, -2], [1, 1], [2, 1], [3, 2]])
#print(X)

svd = TruncatedSVD(n_components=5, n_iter=7, random_state=20)
svd.fit(X)

print("Componentes SVD")
print (svd.components_)

#The variance of the training samples transformed by a projection to each component.
print ("The variance of the training samples:")
print(svd.explained_variance_) 

#Percentage of variance explained by each of the selected components.
print ("Porcentagem de variância explicada por componente:")
print(svd.explained_variance_ratio_) 

print ("Variância explicada acumulada:")
print(svd.explained_variance_ratio_.sum()) 


#Perform dimensionality reduction on X.
print("Redução de dimensionalidade na matriz")
print(svd.transform(X))
