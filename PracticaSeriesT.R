library(lubridate)
library(tidyverse)
library(patchwork)
# Practica de serie de Tiempo y Predicciones con datos ecobici
# @author IkerAb

file.choose() #Buscar el archivo descargado
raw_data<-read_csv("/Users/ikerab/Desktop/R/2025-03.csv")

viajes_diarios<-raw_data %>%
  mutate(fecha_hora=dmy_hms(paste(Fecha_Retiro,Hora_Retiro)))%>%
  filter(fecha_hora >= as.Date("2025-03-13"), 
         fecha_hora<= as.Date("2025-03-16"))%>%
  group_by(horas=floor_date(fecha_hora, unit= "hour"))%>%
  summarise(conteo= n())

horas_completas<- data.frame(
  horas=seq(floor_date(min(viajes_diarios$horas), unit="hour"), 
            floor_date(max(viajes_diarios$horas), unit="hour"), 
            by="hour")
)

#

viajes_hora <- horas_completas%>%
  group_by(horas_redondeadas=floor_date(horas, unit="hour"))%>%
  left_join(viajes_diarios)%>%
  mutate(conteo= ifelse(is.na(conteo), 0,conteo))

g <- ggplot(viajes_diarios, aes(x=horas,y=conteo))+
  geom_line()

conteo_ts<-ts(viajes_hora$conteo,
            start=1,
            frequency=24)
conteo_ts
#Time Series:
#Start = c(1, 1) 
#End = c(3, 24) 3 son los dias 24 es la frecuencia

library(forecast)
ajuste <- auto.arima(y=conteo_ts)
summary(ajuste) 
predicciones <- forecast(ajuste)

ajuste2 <- ets(conteo_ts)
predicciones2<- forecast(ajuste2)

#para ajustar la tabla
limites <- c(min(predicciones[["lower"]]),
             max(predicciones[["upper"]]))

p_predict <- autoplot(predicciones)+
  labs(title="Pronostico con predicción de 2 dias 13-16 con 17 y 18 calculado (ARIMA)", 
       y="conteo de bicis", 
       x="horas")
p_predict

p2_predict <-autoplot(predicciones2, 
                      main="Pronostico con predicción de 2 dias 13-16 con 17y 18 calculado (ETS) ", 
                      xlab="horas", 
                      ylab="conteo de bicis")
p2_predict

#

viajes_diarios_completos<-raw_data %>%
  mutate(fecha_hora=dmy_hms(paste(Fecha_Retiro,Hora_Retiro)))%>%
  filter(fecha_hora >= as.Date("2025-03-13"), 
         fecha_hora<= as.Date("2025-03-18"))%>%
  group_by(horas=floor_date(fecha_hora, unit= "hour"))%>%
  summarise(conteo= n())

horas_completas<- data.frame(
  horas=seq(floor_date(min(viajes_diarios_completos$horas), unit="hour"), 
            floor_date(max(viajes_diarios_completos$horas), unit="hour"), 
            by="hour")
)

g2 <- ggplot(viajes_diarios_completos,aes(x=horas, y=conteo))+
  geom_line(color="navy")+
  ylim(limites)+
  labs(
    title="Observacion real del 13-18", 
    y="conteo de bicis"
  )

(p_predict/g2)
p_predict/p2_predict
(p2_predict/g2)


