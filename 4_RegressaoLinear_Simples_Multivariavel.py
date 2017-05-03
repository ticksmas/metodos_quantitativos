#--------------------------------------------------------------------------------
# Disciplina: Metodos Quantitativos em CC - 2017
# Professor : Luis Enrique Zarate
# Alunos    : Matheus Alcantara
#             Pedro Ruas
#             Marcos W. Rodrigues
# Abordagens: Regressao Linear Simples
#             Regressao Linear Multivariavel
#             Regressao Linear Multipla (n > 2)
#--------------------------------------------------------------------------------

#Documentation:http://scikit-learn.org/stable/modules/generated/sklearn.linear_model.LinearRegression.html


# Regressao Linear Simples


import matplotlib.pyplot as plt
import numpy as np
from sklearn import datasets, linear_model

# Load the diabetes dataset
diabetes = datasets.load_diabetes()

#teste = numpy.array([[ 2, 4, 200],
#					[0,6,240],
#					[3,4,250],
#					[5,5,300],
#					[4,4,310],
#					[3,5,320],
#					[4,6,325],
#					[5,8,320]])



#X = np.random.randint(0, 10, size=(7, 7))

# Use only one feature
diabetes_X = diabetes.data[:, np.newaxis, 2]

#print(" Matriz: \n", diabetes_X)

# Split the data into training/testing sets
diabetes_X_train = diabetes_X[:-20]
diabetes_X_test = diabetes_X[-20:]

# Split the targets into training/testing sets
diabetes_y_train = diabetes.target[:-20]
diabetes_y_test = diabetes.target[-20:]

# Create linear regression object
regr = linear_model.LinearRegression()

# Train the model using the training sets
regr.fit(diabetes_X_train, diabetes_y_train)

# The coefficients
#print('Coefficients: \n', regr.coef_)

#Returns the coefficient of determination R^2 of the prediction.
print('Scores: \n', diabetes_X_test,diabetes_y_test)

# The mean squared error
print("Mean squared error: %.2f"
      % np.mean((regr.predict(diabetes_X_test) - diabetes_y_test) ** 2))

# Explained variance score: 1 is perfect prediction
print('Variance score: %.2f' % regr.score(diabetes_X_test, diabetes_y_test))

# Predict using the linear model
#print('Prediction: \n', regr.predict(diabetes_X))


# Plot outputs
plt.scatter(diabetes_X_test, diabetes_y_test,  color='black')
plt.plot(diabetes_X_test, regr.predict(diabetes_X_test), color='blue',
         linewidth=3)

plt.xticks(())
plt.yticks(())

plt.show()




print("\n\n =========================LOGISTIC FUNCTION================================")
#Documentation: http://scikit-learn.org/stable/auto_examples/linear_model/plot_logistic.html#sphx-glr-auto-examples-linear-model-plot-logistic-py
#Logistic function
# this is our test set, it's just a straight line with some
# Gaussian noise
xmin, xmax = -5, 5
n_samples = 100
np.random.seed(0)
X = np.random.normal(size=n_samples)
y = (X > 0).astype(np.float)
X[X > 0] *= 4
X += .3 * np.random.normal(size=n_samples)

X = X[:, np.newaxis]
# run the classifier
clf = linear_model.LogisticRegression(C=1e5)
clf.fit(X, y)

# and plot the result
plt.figure(1, figsize=(7, 6))
plt.clf()
plt.scatter(X.ravel(), y, color='black', zorder=20)
X_test = np.linspace(-5, 10, 300)


def model(x):
    return 1 / (1 + np.exp(-x))
loss = model(X_test * clf.coef_ + clf.intercept_).ravel()
plt.plot(X_test, loss, color='red', linewidth=3)

ols = linear_model.LinearRegression()
ols.fit(X, y)
plt.plot(X_test, ols.coef_ * X_test + ols.intercept_, linewidth=1)
plt.axhline(.5, color='.5')

plt.ylabel('y')
plt.xlabel('X')
plt.xticks(range(-5, 10))
plt.yticks([0, 0.5, 1])
plt.ylim(-.25, 1.25)
plt.xlim(-4, 10)
plt.legend(('Logistic Regression Model', 'Linear Regression Model'),
           loc="lower right", fontsize='small')
plt.show()