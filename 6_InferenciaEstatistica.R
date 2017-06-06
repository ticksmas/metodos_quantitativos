#--------------------------------------------------------------------------------
# Disciplina: Metodos Quantitativos em CC - 2017
# Professor : Luis Enrique Zarate
# Alunos    : Matheus Alcantara
#             Pedro Ruas
#             Marcos W. Rodrigues
# Abordagens: Inferencia Estatistica
#             Teste de hipotese - Teste para a Média com Variancia desconhecida
#             Teste para a Variância de uma população normal
#             Teste para uma Proporção Binomial
#             Testes de Duas amostras para a diferença de duas médias com variâncias desconhecidas e diferentes
#             Teste para as variâncias de duas populações normais
#             Teste para duas proporções
#--------------------------------------------------------------------------------

#--------------------------------------------------------------------------------
#--------------------------------------------------------------------------------
# Inferencia Estatistica
#--------------------------------------------------------------------------------
#--------------------------------------------------------------------------------

#----- Teste de hipotese - Teste para a Média com Variancia desconhecida

x <- c(19.8, 18.5, 17.6, 16.7, 15.8, 15.4, 14.1, 13.6,
     + 11.9, 11.4, 11.4, 8.8, 7.5, 15.4, 15.4, 19.5,
     + 14.9, 12.7, 11.9, 11.4, 10.1, 7.9)
x

t.test(x, alternative="greater", mu=10, conf.level=0.95)

#One Sample t-test
#
#data:  x
#t = 4.9017, df = 21, p-value = 3.781e-05
#alternative hypothesis: true mean is greater than 10
#95 percent confidence interval:
#  12.40996      Inf
#sample estimates:
#  mean of x 
#13.71364 

#----- Teste de hipotese - Teste para a Variância de uma população normal

nam <- 20 #n = tamanho da amostra
varS <- 0.0153 #varS = variância amostral
sig0 <- 0.01 #sig0 = valor de variância testada
alfa <- 0.05 #alfa = significância do teste

quicalc = (nam-1) * varS / sig0
quicalc

#Funcao que testa uma variancia
onevartest <- function(varS, nam, sig0, alfa, tail){
  #nam = tamanho da amostra
  #varS = variância amostral
  #sig0 = valor de variância testada
  #alfa = significância do teste
  quicalc <- (nam-1)*varS/sig0; #estatística de teste
  #Testes unilaterais apenas
  if(tail==0){ #intervalo superior
    #pvalor do teste
    pvalor <- pchisq(q=quicalc,df=nam-1, lower.tail = F)
    Intervalo <- ((nam-1)*varS)/(qchisq(p=alfa,df=nam-1, lower.tail=F))
    print("P-Valor e Valor crítico do intervalo superior")
  }else{ #intervalo inferior
    #pvalor do teste
    pvalor <- pchisq(q=quicalc,df=nam-1, lower.tail = T);
    Intervalo <- ((nam-1)*varS)/(qchisq(p=alfa,df=nam-1, lower.tail=T))
    print("P-Valor e Valor crítico do intervalo inferior")
  }
  return(list(c("Pvalor =", pvalor),c("Intervalo = ", Intervalo)))
}
onevartest(0.0153,20,0.01,0.05,0) #Teste

#----- Teste para uma Proporção Binomial

x <- matrix(c(4,196),1,2)
x

prop.test(x,p=0.06,alternative="less",conf.level=0.97)

#	1-sample proportions test with continuity correction
#data:  x, null probability 0.06
#X-squared = 4.9867, df = 1, p-value = 0.01277
#alternative hypothesis: true p is less than 0.06
#97 percent confidence interval:
#  0.00000000 0.05203808
#sample estimates:
#  p 
#0.02

#----- Testes de Duas amostras para a diferença de duas médias com variâncias desconhecidas e diferentes

x <- c(91.50, 94.18, 92.18, 95.39,91.79,89.07,94.72,89.21)
y <- c(89.19,90.95,90.46,93.21,97.19,97.04,91.07,92.75)
x
y

t.test(x,y,alternative="two.sided",mu=0)

#	Welch Two Sample t-test
#data:  x and y
#t = -0.35359, df = 13.353, p-value = 0.7292
#alternative hypothesis: true difference in means is not equal to 0
#95 percent confidence interval:
#  -3.387118  2.432118
#sample estimates:
#  mean of x mean of y 
#92.2550   92.7325 

#----- Teste para as variâncias de duas populações normais

x <- rnorm(11, sd=5.1)
y <- rnorm(16, sd=4.7)
x
y

var.test(x,y,ratio=1,alternative="t",conf.level=0.9)

#F test to compare two variances
#data:  x and y
#F = 0.94901, num df = 10, denom df = 15, p-value = 0.9603
#alternative hypothesis: true ratio of variances is not equal to 1
#90 percent confidence interval:
#  0.3730807 2.6999553
#sample estimates:
#  ratio of variances 
#0.9490122

#----- Teste para duas proporções

X <- c(110,33)
Y <- c(201299, 200745)
X
Y

prop.test(X,Y,alternative="t")

#	2-sample test for equality of proportions with continuity correction
#data:  X out of Y
#X-squared = 40.197, df = 1, p-value = 2.296e-10
#alternative hypothesis: two.sided
#95 percent confidence interval:
#  0.0002606084 0.0005035179
#sample estimates:
#  prop 1       prop 2 
#0.0005464508 0.0001643877

prop.test(X,Y,alternative="t",conf.level=0.99)

#	2-sample test for equality of proportions with continuity correction
#data:  X out of Y
#X-squared = 40.197, df = 1, p-value = 2.296e-10
#alternative hypothesis: two.sided
#99 percent confidence interval:
#  0.0002240077 0.0005401186
#sample estimates:
#  prop 1       prop 2 
#0.0005464508 0.0001643877

#--------------------------------------------------------------------------------
#--------------------------------------------------------------------------------
