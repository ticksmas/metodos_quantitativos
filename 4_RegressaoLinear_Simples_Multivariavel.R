#--------------------------------------------------------------------------------
# Disciplina: Metodos Quantitativos em CC - 2017
# Professor : Luis Enrique Zarate
# Alunos    : Matheus Alcantara
#             Pedro Ruas
#             Marcos W. Rodrigues
# Abordagens: Regressão Linear Simples
#             Regressão Linear Multivariável
#             Regressão Linear Multipla (n > 2)
#--------------------------------------------------------------------------------

#---------- 

# Regressão Linear Simples

galap <- read.table("https://sites.google.com/site/vllandeiror/dados/galapagos.txt", sep=" ", header=TRUE, quote="\"", colClasses="character", fileEncoding="UTF-8")
riqueza <- scan(text=galap[,3], dec=".")
area <- scan(text=galap[,2], dec=".")
plot(area,riqueza)

#Note que a relação não é linear e que um ponto assemelha-se a um outlier. Para linearizar os dados e reduzir o efeito do outlier tranformamos os dados em log.
riqueza.log <-log10(strtoi(riqueza,base=10))
area.log <- log10(as.double(area))
plot(area.log, riqueza.log) 

resultado<-lm(riqueza.log ~ area.log) #fazendo a regressão
resultado #mostra os coeficientes a (intercepto) e b (inclinação) da regressão
summary(resultado) #detalhes da regressão

summary.aov(resultado) #estatísticas: valores de t, probabilidades, os graus de liberdade e r2
plot(area.log,riqueza.log) 
abline(resultado) #linha de tendência da regressão

#----------

# Regressão Linear Multivariável





#----------

# Regressão Linear Multipla (n > 2)

formigas <- read.table("https://sites.google.com/site/vllandeiror/dados/formigas.txt", sep=" ", header=TRUE, quote="\"", colClasses="character", fileEncoding="UTF-8")
lat <- scan(text=formigas[,1], dec=".") # latitude
alt <- scan(text=formigas[,2], dec=".") # altitude
dens.formig <- scan(text=formigas[,3], dec=".") # densidade de formigas
lm(log10(dens.formig) ~ lat+alt)
reg.mult <- lm(log10(dens.formig) ~ lat+alt)
reg.mult
summary(reg.mult)
summary.aov(reg.mult)
#avPlots(reg.mult) #gráfico dos parciais desta regressão múltipla (pacote "car")

#----------
#----------
