# Prediction_R

## PROYECCIÓN DE RENTA DE BICICLETAS EN CDMX CON SERIES DE TIEMPO

Este proyecto realiza un análisis y pronóstico del número de viajes por hora del sistema ECOBICI de la Ciudad de México, utilizando datos abiertos oficiales ( https://ecobici.cdmx.gob.mx/estadisticas/ ).
Se construyen modelos de series de tiempo para estimar la demanda futura de bicicletas y se comparan dos enfoques:
ARIMA
ETS (Exponential Smoothing)
El objetivo es explorar el comportamiento temporal de los viajes y generar proyecciones basadas en datos históricos.

## ESTRUCTURA DEL PROYECTO

main.R
Script principal que:
Carga y limpia los datos
Agrupa los viajes por hora
Construye la serie de tiempo
Ajusta modelos ARIMA y ETS
Genera pronósticos y gráficas
2025-03.csv
Archivo de datos abiertos de ECOBICI correspondiente a marzo de 2025.

## LIBRERÍAS UTILIZADAS
El proyecto utiliza los siguientes paquetes de R:
lubridate
tidyverse
forecast
patchwork
Para instalarlos:
install.packages(c("lubridate", "tidyverse", "forecast", "patchwork"))

## EJECUCIÓN
Descargar el archivo CSV de datos abiertos de ECOBICI.
Abrir el script main.R.
Modificar la ruta del archivo en la línea:
raw_data <- read_csv("ruta/al/archivo/2025-03.csv")
Ejecutar el script completo en RStudio o en la consola de R.

## METODOLOGÍA
Se combinan las columnas de fecha y hora para crear la variable fecha_hora.
Se filtran los datos del 13 al 16 de marzo de 2025 para entrenar el modelo.
Se agrupan los viajes por hora y se genera una serie de tiempo con frecuencia 24.
Se ajustan dos modelos:
auto.arima()
ets()
Se generan pronósticos para dos días adicionales.
Se comparan las predicciones con los datos reales del 13 al 18 de marzo.

## RESULTADOS
El proyecto genera tres gráficas principales:
Pronóstico con ARIMA
Pronóstico con ETS
Serie real observada del 13 al 18 de marzo
Estas gráficas permiten visualizar el comportamiento de cada modelo y su capacidad para aproximar la demanda real.

## CONCLUSIONES
Los modelos de series de tiempo capturan patrones horarios claros en la renta de bicicletas.
ARIMA y ETS ofrecen aproximaciones similares, aunque con diferencias en suavidad.
Este tipo de análisis puede apoyar la planeación de infraestructura y redistribución de bicicletas.

## AUTOR
Iker
