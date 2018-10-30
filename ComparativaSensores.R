#############
# Programa en R para CodigoCDMX Calidad del Aire
# Este código sirve para hacer la comparativa de datos entre el sensor del SIMAT (LAA- En Vallejo) y el de Smability
# Se requiere el archivo denominado RawData2.xlsx (diponible)
#############

############# Se requieren tener las siguientes librerías instaladas (no explicado aquí)
library(readxl) # Excel library
library(lubridate) # Dates library
library(dplyr) # Data library

library(ggplot2)  # library for visualization
library(magrittr) # library for coding
library(ggpubr) # library for visualization
library(BlandAltmanLeh) # Library for this specific plot

library(rJava)
library(xlsx)

############# Se lee la información de un archivo de Excel denominado "RawData2"
############# Ajustar la ubicación adecuadamente
PM_Simat <- read_excel("Push2Gas/Project Management/Calidad del aire CDMX/Data/RawData2.xlsx", 
                                             sheet = "pm25 comparison", range = "A2:B4299", 
                                             col_types = c("date", "numeric"))
PM_Smability<- read_excel("Push2Gas/Project Management/Calidad del aire CDMX/Data/RawData2.xlsx", 
                       sheet = "pm25 comparison", range = "D2:E44997", 
                       col_types = c("date", "numeric"))

############## Primero se plotean los datos sin procesar 
par(lwd=2,lty=1, col="black", pch=17)
plot(PM_Simat$Date, PM_Simat$SIMAT, type="n", xlab="Fecha", main="PM 2.5 - Datos sin procesar",
     ylab="PM2.5 (ug/m3)") 
legend( "top",
        inset=-0.1,
        horiz=TRUE,
        legend=c("Smability","SIMAT"), 
        col=c("blue","green3"), 
        lty=c(1,1), # line types
        lwd=c(2,2),
        cex=0.7, #font size
        box.lty=0.5) #box countour
par(lwd=2,lty=1, col="blue", pch=17)
lines(PM_Smability$Date, PM_Smability$Smability, type="l")
par(lwd=2,lty=1, col="green3", pch=22)
lines(PM_Simat$Date, PM_Simat$SIMAT, type="l") 

############## Se quitan los datos que no son de tipo numérico & y aquellos datos que son "cero"
PM_Simat <- PM_Simat[complete.cases(PM_Simat), ]
PM_Simat <- PM_Simat[PM_Simat$SIMAT>=0.01,]

########## Se quitan los periodos con lluvia registrada superior a los 5mm/h 
########## Estación CCHVALLEJO del Observatorio Hidrológico de la UNAM
########## https://www.oh-iiunam.mx/estaciones.html

RemoveDates <- function(x,y){PM_Simat[!(PM_Simat$Date >= x & PM_Simat$Date <= y),]}

DATEA <- as_datetime("2018-01-24 16:00:00")
DATEB <- as_datetime("2018-01-25 00:00:00")
PM_Simat <- RemoveDates(DATEA,DATEB)

DATEA <- as_datetime("2018-01-28 18:00:00")
DATEB <- as_datetime("2018-01-28 22:00:00")
PM_Simat <- RemoveDates(DATEA,DATEB)

DATEA <- as_datetime("2018-02-08 18:00:00")
DATEB <- as_datetime("2018-02-08 22:00:00")
PM_Simat <- RemoveDates(DATEA,DATEB)

DATEA <- as_datetime("2018-02-09 16:00:00")
DATEB <- as_datetime("2018-02-10 02:00:00")
PM_Simat <- RemoveDates(DATEA,DATEB)

DATEA <- as_datetime("2018-03-09 16:00:00")
DATEB <- as_datetime("2018-03-09 22:00:00")
PM_Simat <- RemoveDates(DATEA,DATEB)

DATEA <- as_datetime("2018-03-14 14:00:00")
DATEB <- as_datetime("2018-03-14 22:00:00")
PM_Simat <- RemoveDates(DATEA,DATEB)

DATEA <- as_datetime("2018-03-15 14:00:00")
DATEB <- as_datetime("2018-03-15 20:00:00")
PM_Simat <- RemoveDates(DATEA,DATEB)

DATEA <- as_datetime("2018-04-04 18:00:00")
DATEB <- as_datetime("2018-04-05 02:00:00")
PM_Simat <- RemoveDates(DATEA,DATEB)

DATEA <- as_datetime("2018-04-05 18:00:00")
DATEB <- as_datetime("2018-04-05 23:59:00")
PM_Simat <- RemoveDates(DATEA,DATEB)

DATEA <- as_datetime("2018-04-06 14:00:00")
DATEB <- as_datetime("2018-04-06 22:00:00")
PM_Simat <- RemoveDates(DATEA,DATEB)

DATEA <- as_datetime("2018-04-10 18:00:00")
DATEB <- as_datetime("2018-04-10 23:59:00")
PM_Simat <- RemoveDates(DATEA,DATEB)

DATEA <- as_datetime("2018-04-11 18:00:00")
DATEB <- as_datetime("2018-04-11 23:59:00")
PM_Simat <- RemoveDates(DATEA,DATEB)

DATEA <- as_datetime("2018-04-15 18:00:00")
DATEB <- as_datetime("2018-04-15 23:59:00")
PM_Simat <- RemoveDates(DATEA,DATEB)

DATEA <- as_datetime("2018-04-21 18:00:00")
DATEB <- as_datetime("2018-04-22 02:00:00")
PM_Simat <- RemoveDates(DATEA,DATEB)

DATEA <- as_datetime("2018-04-22 18:00:00")
DATEB <- as_datetime("2018-04-22 23:59:00")
PM_Simat <- RemoveDates(DATEA,DATEB)

DATEA <- as_datetime("2018-04-26 18:00:00")
DATEB <- as_datetime("2018-04-27 04:00:00")
PM_Simat <- RemoveDates(DATEA,DATEB)

############### Datos que SIMAT reportó erroneos en su procesos y que tienen que descartarse

DATEA <- as_datetime("2017-12-25 01:00:00") # Outlier
DATEB <- as_datetime("2017-12-25 03:00:00")
PM_Simat <- RemoveDates(DATEA,DATEB) 

DATEA <- as_datetime("2017-12-25 16:00:00") # Outlier
DATEB <- as_datetime("2017-12-25 21:00:00")
PM_Simat <- RemoveDates(DATEA,DATEB) 

DATEA <- as_datetime("2017-12-27 12:00:00") # Outlier
DATEB <- as_datetime("2017-12-29 12:00:00")
PM_Simat <- RemoveDates(DATEA,DATEB) 

DATEA <- as_datetime("2017-12-31 01:00:00") # Outlier
DATEB <- as_datetime("2017-12-31 03:00:00")
PM_Simat <- RemoveDates(DATEA,DATEB) 

DATEA <- as_datetime("2018-05-06 00:00:00") # Outlier
DATEB <- as_datetime("2018-05-06 05:00:00")
PM_Simat <- RemoveDates(DATEA,DATEB) 

DATEA <- as_datetime("2018-03-30 00:00:00") # Outlier
DATEB <- as_datetime("2018-03-30 04:00:00")
PM_Simat <- RemoveDates(DATEA,DATEB) 

DATEA <- as_datetime("2017-12-24 03:00:00") # Outlier
DATEB <- as_datetime("2017-12-24 06:00:00")
PM_Simat <- RemoveDates(DATEA,DATEB) 

############## En esta parte puede elegirse un periodo especifico de fechas a analizar
############## DATE1 sería fecha inicial
############## DATE2 sería fecha final
myfunc1 <- function(x,y){PM_Simat[PM_Simat$Date >= x & PM_Simat$Date <= y,]}
DATE1 <- "2017-12-01 00:00:00"
DATE2 <- "2018-04-30 00:00:00"
PM_Simat <- myfunc1(DATE1,DATE2)

############## Los datos de SMABILITY se promedian para cada hora
############## Los datos de SMABILITY se ajustan por una hora (horario de verano)
PM_Smability %>%
  mutate("TimeHour" = ceiling_date(Date, 'hour')) %>%
  group_by(TimeHour) %>%
  summarize(MeanPM25 = mean(Smability)) %>%
  mutate(TimeHour = TimeHour+dhours(1)) -> PM_Smability_Average

############## Ajustes de formatos de hora (las zona horarias se hacen iguales)
strptime(round(PM_Simat$Date[],'mins'),format="%Y-%m-%d  %H:%M", tz='UTC') -> PM_Simat$Date
strptime(round(PM_Smability_Average$TimeHour[],'mins'),format="%Y-%m-%d  %H:%M", tz='UTC') -> PM_Smability_Average$TimeHour

############## se plotean los datos procesados
par(lwd=2,lty=1, col="black", pch=17)
plot(PM_Simat$Date, PM_Simat$SIMAT, type="n", xlab="Fecha", main="PM 2.5 - Datos Procesados",
     ylab="PM2.5 (ug/m3)" ) 
legend( "top",
        inset=-0.1,
        horiz=TRUE,
        legend=c("Smability","SIMAT"), 
        col=c("blue","green3"), 
        #pch=c("-","-")) # line types
        lty=c(1,1), # line types
        lwd=c(2,2),
        cex=0.7, #font size
        box.lty=0.0) #box countour
par(lwd=2,lty=1, col="blue", pch=17)
lines(PM_Smability_Average$TimeHour, PM_Smability_Average$MeanPM25, type="l")
par(lwd=2,lty=1, col="green3", pch=22)
lines(PM_Simat$Date, PM_Simat$SIMAT, type="l") 

############## En estadistica, para comparar 2 conjuntos de datos, los vectores requieren ser del mismo tamaño
############## En esta parte, se hace un "crosscheck" entre los datos con una "comparacion de vectores"

PM_Smability_Average2 <- PM_Smability_Average[PM_Smability_Average$TimeHour %in% PM_Simat$Date,]
PM_Simat2 <- PM_Simat[PM_Simat$Date %in% PM_Smability_Average$TimeHour,]

############## Se plotean los datos procesados, con vector del mismo tamaño
par(lwd=2,lty=1, col="black", pch=17)
plot(PM_Simat2$Date, PM_Simat2$SIMAT, type="n", xlab="Fecha", main="PM 2.5 -  Vector del mismo tamaño",
     ylab="PM2.5 (ug/m3)" )
legend( "top",
        inset=-0.1,
        horiz=TRUE,
        legend=c("Smability","SIMAT"),
        col=c("blue","green3"),
        #pch=c("-","-")) # line types
        lty=c(1,1), # line types
        lwd=c(2,2),
        cex=0.7, #font size
        box.lty=0.5) #box countour
par(lwd=2,lty=1, col="blue", pch=17)
lines(PM_Smability_Average2$TimeHour, PM_Smability_Average2$MeanPM25, type="l")
par(lwd=2,lty=1, col="green3", pch=22)
lines(PM_Simat2$Date, PM_Simat2$SIMAT, type="l")

############## Con vectores del mismo tamaño se puede estimar la correlacion
cor(PM_Simat2$SIMAT,PM_Smability_Average2$MeanPM25)

############## Los datos se ponen en una matriz (mejor manejo de datos)
Together <- PM_Smability_Average2
Together[,c(2)] <- PM_Simat2$SIMAT
Together[,c(3)] <- PM_Smability_Average2$MeanPM25
Together[,c(4)] <- PM_Smability_Average2$MeanPM25
Together[,c(5)] <- PM_Smability_Average2$MeanPM25-PM_Simat2$SIMAT
colnames(Together) <- c("Date","PM25Ref", "PM25Sma","FixedSma","ErrorPM25")
b=median(Together$ErrorPM25)

############## Grafica de la densidad del error (antes de calibrar)
par(lwd=2,lty=1, col="black", pch=17)
plot(density(Together$ErrorPM25),lwd=2,col="blue",main="Grafica de la densidad del error",xlab="Error",
     ylab=" Densidad")
legend("topright",
       inset=00.0,
       legend=c("Error de Smability"), 
       col=c("blue"), 
       #pch=c("-","-")) # line types
       lty=c(1,1,1), # line types
       lwd=c(2,2,2),
       cex=0.8, #font size
       box.lty=0) #box countour

############## Aplicando calibración de unn sólo punto
Together[,c(4)] <- Together$PM25Sma-b
Together[,c(5)] <- Together$FixedSma-Together$PM25Ref

############## Estimando la desviacion estandar y correlacion
ErrorSD <- sd(Together$ErrorPM25)
ErrorSD
cor(Together$PM25Ref,Together$FixedSma)

############## Se plotean los datos procesados, calibracion de un solo punto
par(lwd=2,lty=1, col="black", pch=17)
plot(Together$Date, Together$FixedSma, type="n", xlab="Fecha", main="PM 2.5 - Datos calibrados",
     ylab="PM2.5 (ug/m3)" ) 
legend( "top",
        inset=-0.1,
        horiz=TRUE,
        legend=c("Smability","SIMAT"), 
        col=c("blue","green3"), 
        lty=c(1,1), # line types
        lwd=c(2,2),
        cex=0.7, #font size
        box.lty=0.5) #box countour
par(lwd=2,lty=1, col="blue", pch=17)
lines(Together$Date, Together$FixedSma, type="l")
par(lwd=2,lty=1, col="green3", pch=22)
lines(Together$Date, Together$PM25Ref, type="l") 

############## Grafica de la densidad del error (despues de calibrar)
par(lwd=2,lty=1, col="black", pch=17)
plot(density(Together$ErrorPM25),lwd=2,col="blue",main="Grafica de la densidad del error",xlab="Error",
     ylab=" Densidad")
legend("topright",
       inset=0.01,
        legend=c("Error de Smability","Distribución Normal"), 
        horiz=FALSE,
        col=c("blue","green3"), 
        #pch=c("-","-")) # line types
        lty=c(1,1,1), # line types
        lwd=c(2,2,2),
        cex=0.8, #font size
        box.lty=0) #box countour
x <- seq(-40, 40, length=600)
y <- dnorm(x, mean=0, sd=ErrorSD)
lines(x, y, type="l", lwd=2, col="green3")

############## Evaluando si el error tiene una distribucion normal
############## the p-value > 0.05 implying that the distribution of the data are not significantly different from normal distribution. In other words, we can assume the normality.

shapiro.test(Together$ErrorPM25)

############## Bland Altman Plot
############## Para comparar dos tipos de sensores similares
##############  plot((A+B)/2, A-B, main="Mean-Difference-Plot")
par(lwd=2,lty=1, col="black", pch=1)
bland.altman.plot(Together$FixedSma, Together$PM25Ref, col="blue",main="Comparación de los sensores (Bland Altman)", xlab="Promedios", ylab="Diferencias")

########### PM 2.5 Comparacion entre dispositivos
########### Calculando el intervalo de confianza a 95%
########### Y la correlación entre los datos

ggscatter(Together, x = "PM25Ref", y = "FixedSma", add.params = list(color = "green3"), shape=1,
          add = "reg.line", color="blue", 
          cor.coef = TRUE, cor.method = "pearson",cor.coeff.args = list(method = "pearson"),
          conf.int = TRUE, conf.int.level = 0.95,
          main = "Comparativa Smability con la Referencia",
          xlim=c(00,160),ylim=c(00,160),
          xlab = "Sensor Referencia (ug/m3)", ylab = "Sensor Smability (ug/m3)")
cor.test(Together$FixedSma, Together$PM25Ref,  method = "pearson")

########### Salvando los datos procesados a un archivo de Excel llamado "ProcessedData2.xlsx"
########### Ajustar la ubicación de archivo adecuadamente
ProcessedData <- as.data.frame(Together)
ProcessedData[,1] <- as.character(ProcessedData[,1])
write.xlsx(ProcessedData, "C:/Users/coxiz/Documents/Push2Gas/Project Management/Calidad del aire CDMX/Data/ProcessedData2.xlsx")
