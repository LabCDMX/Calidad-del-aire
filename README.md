# Calidad del Aire

Medición de contaminantes en el aire a nivel peatonal

Como parte de la convocatoria CodigoCDMX, coordinada por el Laboratorio para la Ciudad, se desarrollaron tres sensores de calidad del aire (uno fijo + dos sensores móviles), con capacidad de subir datos sobre la calidad a nuestra plataforma en tiempo real. El sensor fijo se desarrolló de tal manera que se pudiera instalar en una de las estaciones del Sistema de Monitoreo Atmosférico de la Ciudad de México (SIMAT), para poder hacer un análisis comparativo entre los datos producidos por los sensores de Smability y los del SIMAT, dicho sensor mide monóxido de carbono, partículas PM2.5, humedad y temperatura. Los dos sensores móviles sirvieron para el levantamiento de datos a nivel peatonal, y sólo pueden medir partículas finas PM2.5, hora y GPS en su modalidad de sensores portátiles.

Este repositorio contiene el código utilizado para hacer el análisis comporativo entre los datos producidos por los sensores de Smability y el del SIMAT, especificamente para partículas PM2.5. La estación del SIMAT se llama Laboratorio de Analisis Ambiental y se encuentra en Vallejo.

El código ha sido programado en la herramienta estadística R. Puede ser de interés para cualquier persona haciendo el comparativo entredos variables: la prueba y la referencia estandar. Se incluye un archivo con los datos para su uso.
