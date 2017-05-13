#--------------------------------------------------------------------------------
# Disciplina: Metodos Quantitativos em CC - 2017
# Professor : Luis Enrique Zarate
# Alunos    : Matheus Alcantara
#             Pedro Ruas
#             Marcos W. Rodrigues
# Abordagens: Estatistica Descritiva
#             Analise de graficos (Boxplot)
#             Histogramas de frequencia
#             Distribuicao de probabilidades de variaveis continuas e discretas
#             Distribuicao de probabilidade conjunta
#--------------------------------------------------------------------------------

#--------------------------------------------------------------------------------
#--------------------------------------------------------------------------------
# Estatistica Descritiva
#--------------------------------------------------------------------------------
#--------------------------------------------------------------------------------

#Uma medida de dispersao para uma variavel quantitativa e um indicador do grau de 
#espalhamento dos valores da amostra em torno da medida de centralidade.

nt <- c(183.8,125.4,193.3,162,142.3,140.6,456.8,228.7,231.4,86.1,199.6,235.3,
        218.6,128,125.4,244.2,147.8,118.2,347.5,150.1,236.9,214.6,214.1,257.3,
        362.8,140.7,113.8)

#Media aritmetica
mean(nt)

#Mediana
median(nt)

#Quantil com 20%, 50%, 75% e 95%
quantile(nt, c(0.20, 0.50, 0.75, 0.95))

#Variancia
var(nt)

#Desvio-padrao
sd(nt)

#Distancia interquartil
q <- fivenum(nt); 
q[4]-q[2]    #em q estao os 5 num. Subtraimos o Q3 do Q1

#Valor minimo, os tres quartis e o valor maximo
fivenum(nt)

#Valor minimo, os tres quartis, o valor maximo e a media
summary(nt)

#--------------------------------------------------------------------------------
#--------------------------------------------------------------------------------
# Analise de graficos (Boxplot)
#--------------------------------------------------------------------------------
#--------------------------------------------------------------------------------

#O Box Plot e um grafico que se costuma utilizar para sintetizar em uma mesma 
#figura varias informacoes relativas as distribuicao de uma determinada variavel 
#quantitativa. 

cax <- read.csv("http://ecologia.ib.usp.br/bie5782/lib/exe/fetch.php?media=dados:caixeta.csv", header=TRUE, as.is=TRUE)
boxname <- paste( sort(rep(unique(cax$local),5)), rep(1:5,3) )
boxcor <- sort(rep(c("navy","darkgreen","salmon1"),5))
boxplot(cap~local * parcela, data=cax , names=boxname, col=boxcor, horizontal=T, las=1, xlab="DAP (cm)")

#--------------------------------------------------------------------------------
#--------------------------------------------------------------------------------
# Diagrama de dispersao
#--------------------------------------------------------------------------------
#--------------------------------------------------------------------------------

cax <- read.csv("http://ecologia.ib.usp.br/bie5782/lib/exe/fetch.php?media=dados:caixeta.csv", header=TRUE, as.is=TRUE)
plot(x=cax$cap, y=cax$h)
scatter.smooth( cax$cap, cax$h , col="red")

scatter.smooth( cax$cap, cax$h , col="red", xlab="DAP (cm)", ylab="Altura (dm)", main="Caixetais")
scatter.smooth( cax$cap, cax$h , col="red", xlab="DAP (cm)", ylab="Altura (dm)", log="x")
scatter.smooth( cax$cap, cax$h , col="red", xlab="DAP (cm)", ylab="Altura (dm)", log="y")
scatter.smooth( cax$cap, cax$h , col="red", xlab="DAP (cm)", ylab="Altura (dm)", log="xy")

#--------------------------------------------------------------------------------
#--------------------------------------------------------------------------------
# Histogramas de frequencia
#--------------------------------------------------------------------------------
#--------------------------------------------------------------------------------

cax = read.csv("http://ecologia.ib.usp.br/bie5782/lib/exe/fetch.php?media=dados:caixeta.csv", header=TRUE, as.is=TRUE)
egr = read.csv("http://ecologia.ib.usp.br/bie5782/lib/exe/fetch.php?media=dados:egrandis.csv", header=TRUE, as.is=TRUE)

summary(cax)

cax$dap = (pi/4)* (cax$cap/10)
hist( cax$dap )
hist( cax$dap[ cax$local == "chauas" ] )
hist( cax$dap[ cax$local == "jureia" ] )
hist( cax$dap[ cax$local == "retiro" ] )

hist( cax$dap, plot=FALSE) #A funçao 'hist' tambem pode fornecer os dados do histograma, sem gerar o histograma propriamente dito

dap.hist <- hist( cax$dap, plot=FALSE )
class(dap.hist)
plot(dap.hist)

plot(density(cax$dap) )

plot(density(cax$dap, bw=0.5), col="red" )
lines(density(cax$dap, bw=5), col="blue" )
lines(density(cax$dap, bw=1.5), col="green" )

#--------------------------------------------------------------------------------
#--------------------------------------------------------------------------------
# Distribuicao de probabilidades de variaveis continuas e discretas
#--------------------------------------------------------------------------------
#--------------------------------------------------------------------------------

family_id   <- c(001, 002, 003, 004, 005, 006, 007, 008, 009, 010, 011, 012, 013, 014, 015, 016, 017, 18, 019, 020, 021, 022, 023, 024, 025)
energy_cost <- c(211, 572, 558, 250, 478, 307, 184, 435, 460, 308, 188, 111, 676, 326, 142, 255, 205, 77, 190, 320, 407, 333, 488, 374, 409)

#Variavel aleatoria (v.a.) e uma funcao que associa cada elemento de um
#espaco amostral a um número real.

#V.a. discretas: Um numero finito de valores entre quaisquer dois valores (enumeravel)
#Ex: Binomial, Hipergeometrica, Poisson, Geometrica, Binomial negativa-Pascal 

#V.a. continuas: Um numero infinito de valores entre quaisquer dois valores (intervalo de numeros reais)
#Ex: Uniforme, Exponencial, Normal, t-student, quiquadrado

#P(X<80) onde X = peso, Media = 70Kg, Desvio padrao = 8Kg
pnorm(80, 70, 8)

#10% eh o peso limite para ser obeso. Achar X que deixa 90% abaixo do peso limite
qnorm(0.9, 70, 8)

#Normal padrao 
pnorm((80-70)/8)

size <- 50
range <- c(1:100)
n <- sample(range, size, replace=FALSE)
prob <- 0.3
lambda <- 2
nn <- n
m <- 10
k <- 8
df <- 0.5
df1 <- 0.2
df2 <- 0.6
shape <- 1
shape1 <- 2
shape2 <- 1

rbinom(n, size, prob) #binomial (n, size, prob)
rpois(n, lambda) #Poisson (n, lambda)
rgeom(n, prob) #geometrica (n, prob)
rhyper(nn, m, n, k) #hipergeometrica (nn, m, n, k)
rnbinom(n, size, prob) #binomial negativa (n, size, prob)
runif(n, min=0, max=1) #uniforme (n, min=0, max=1)
rexp(n, rate=1) #exponential (n, rate=1)
rnorm(n, mean=0, sd=1) #Gaussiana (normal) (n, mean=0, sd=1)
rt(n, df) #Student' (t) (n, df)
rf(n, df1, df2) #Fisher'Snedecor (F) (n, df1, df2)
rchisq(n, df) #Quiquadrada (n, df)
rgamma(n, shape, scale=1) #gamma (n, shape, scale=1)
rbeta(n, shape1, shape2) #beta (n, shape1, shape2)
rlnorm(n, meanlog=0, sdlog=1) #lognormal (n, meanlog=0, sdlog=1)
rcauchy(n, location=0, scale=1) #Cauchy (n, location=0, scale=1)
rweibull(n, shape, scale=1) #Weibull (n, shape, scale=1)
rwilcox(nn, m, n) #Wilcoxon's rank sum statistics (nn, m, n)
rsignrank(nn, n) #Wilcoxon's signed rank statistics (nn, n)
rlogis(n, location=0, scale=1) #logistic (n, location=0, scale=1)

#d valor da densidade de probabilidade no ponto x dnome(x, ...)
#p probabilidade acumulada no ponto x pnome(x, ...)
#q quantil correspondente a probabilidade acumulada p dnome(p,...)

#Student's t-test
a <- c(175, 168, 168, 190, 156, 181, 182, 175, 174, 179)
b <- c(185, 169, 173, 173, 188, 186, 175, 174, 179, 180)
var.test(a,b)

# Teorema Central do Limite

n <- c(1, 2, 3, 4, 5, 10, 15, 20)
rexp(n, 1/3) #simula n valores

tcl.exp <- function(n, N=200, titulo=" ", yl=c(0, .4)) {     
  ## inicio da funcao tcl.exp
  medias=numeric(N)
  for(i in 1:N)  
    medias[i] <- mean(rexp(n,1/3))
  hist(medias, xlim=c(-1,10), ylim=yl, freq=F, main=titulo)  
  x=seq(-1,10, .02)
  points(x, dnorm(x, 3, 3*sqrt(1/n) ), type="l", lwd=3)
}

## fim da funcao 
graphics.off()
par(mfrow=c(3,3), mai=c(.3,.4,.1,.1))
tcl.exp(1,titulo="n=1")
tcl.exp(2,titulo="n=2")
tcl.exp(3,titulo="n=3")
tcl.exp(4,titulo="n=4")
tcl.exp(5,titulo="n=5")
tcl.exp(6,titulo="n=6")
tcl.exp(10,titulo="n=10",yl=c(0,.6))
tcl.exp(15,titulo="n=15",yl=c(0,.6))
tcl.exp(20,titulo="n=20",yl=c(0,.6))

#--------------------------------------------------------------------------------
#--------------------------------------------------------------------------------
# Distribuicao de probabilidade conjunta
#--------------------------------------------------------------------------------
#--------------------------------------------------------------------------------

#https://rstudio-pubs-static.s3.amazonaws.com/209289_9f9ba331cccc4e8f8aabdb9273cc76af.html

#       P(Y=0)  P(Y=5)  P(Y=10) P(Y=15)
#P(X=0)  0.02   0.06    0.06    0.10
#P(X=5)  0.04   0.15    0.20    0.10
#P(X=10) 0.01   0.15    0.14    0.01

p <- matrix(c(0.02,0.04,0.01,0.06,0.15,0.15,0.02,0.20,0.14,0.10,0.10,0.01), ncol=4)
p

test1 <- c(1,2,3,4)
test1 

test2 <- matrix(c(1,2,3,4), ncol=1)
test2

test3 <- matrix(c(1,2,3,4),ncol=2)
test3

test4 <- matrix(c(1,2,3,4,5,6), ncol=2)
test4

test5 <- matrix(c(1,2,3,4,5,6), ncol=3)
test5

#P(X=5 and Y=10)
p[2,3]

#P(X=0 and Y=5)
p[1,2]

sum(p)

px <- apply(p,1,sum) #create marginal probabilities for X 
px          

py <- apply(p,2,sum) #create marginal probabilities for Y 
py

p_x5_y5 <- p[2,2]/py[2] #computes conditional probability P(X=5|Y=5)
p_x5_y5

p_x0_y5 <- p[1,2]/py[2]
p_x10_y5 <- p[3,2]/py[2]

p_x_y5 <- c(p_x0_y5,p_x5_y5,p_x10_y5)
p_x_y5

#Computing expectations and variances

x <- c(0,5,10)
y <- c(0,5,10,15)

EX  <- sum(px*x)   ## expectation of X
EX2 <- sum(px*x^2) ## expectation of X^2

EX_Y5 <- sum(p_x_y5*x)
EX_Y5

VX <- EX2 - (EX)^2
VX

#Compute cumulative distribution functions for X and Y

CDF_x <- cumsum(px)
CDF_x

CDF_y <- cumsum(py)
CDF_y

#Plot the pmfs and the CDFs

par(mfrow=c(2,1)) ## this line let's us plot 2 graphs one above the other
plot(x,CDF_x,pch=19,main='CDF (circle) and pmf (square) of X',ylab='CDF and pmf')  ## scatter plot for CDF_x; pch=19 makes solid circles
points(x,px,pch=22)         ## adds the marginal distribution px; pch=22 makes squares
plot(y,CDF_y,pch=19,main='CDF (circle) and pmf (square) of Y',ylab='CDF and pmf')  ## scatter plot for CDF_y; solid circles
points(y,py,pch=22)         ## adds the marginal distribution py; squares

