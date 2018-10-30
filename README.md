# Calidad del Aire: 

## Medición de contaminantes en el aire a nivel peatonal

## Descripción de tu proyecto en un tweet: 
“Transparencia al aire que respiras”

## Acerca del proyecto
### Descripción del proyecto 
Como parte de la convocatoria CodigoCDMX, coordinada por el Laboratorio para la Ciudad, se desarrollaron tres sensores de calidad del aire (uno fijo + dos sensores móviles), con capacidad de subir datos sobre la calidad a nuestra plataforma en tiempo real. El sensor fijo se desarrolló de tal manera que se pudiera instalar en una de las estaciones del Sistema de Monitoreo Atmosférico de la Ciudad de México (SIMAT), para poder hacer un análisis comparativo entre los datos producidos por los sensores de Smability y los del SIMAT, dicho sensor mide monóxido de carbono, partículas PM2.5, humedad y temperatura. Los dos sensores móviles sirvieron para el levantamiento de datos a nivel peatonal, y sólo pueden medir partículas finas PM2.5, hora y GPS en su modalidad de sensores portátiles.

Este repositorio contiene el código utilizado para hacer el análisis comporativo entre los datos producidos por los sensores de Smability y el del SIMAT, especificamente para partículas PM2.5. La estación del SIMAT se llama Laboratorio de Analisis Ambiental y se encuentra en Vallejo. 

## Comienza
### Descarga
El usuario debe tener R instalado en su computadora. Para poder ejecutar dicho archivo se debe descargar el código denominado "ComparativaSensores.R" y también los datos en crudo para su uso y pruebas "RawData2.xlsx"

### Instalación
El usuario debe instalar las siguientes librerías en R para poder ejecutar el programa 
- readxl # Excel files library
- lubridate # Dates library
- dplyr # Data library
- ggplot2 # visualization library
- magrittr # coding library
- ggpubr # visualization library
- BlandAltmanLeh # Library for this specific plot
- rJava # Java & R library
- xlsx # Excel library

### Ejecución
El programa se ejecuta completo o por partes para poder producir las gráficas e indicadores estadísticos de la comparación entre los dos sensores

## Contribuye
### Explicar formas de contribuir al proyecto
El código y las funciones contenidas en el pueden ser de interés para cualquier persona haciendo procesamiento y análisis de datos de sensores, así como para personas haciendo el comparativo entre dos sensores simultaneos: la prueba y la referencia estandar. 

Para contribuir al proyecto podrían mejorar el código haciendolo más eficiente, mejorando las visualizaciones. Si se está comparando otros datasets o sensores podrían incluir los datos y el código empleado para procesarlos.

## Créditos
La autoría de este código es de Smability SAPI, Startup mexicana en Internet de las Cosas (Internet of Things - IoT)

## Tipo de Licencia
El código, los datos y los textos en este repositorio son libres de uso bajo una licencia de datos abiertos MIT. 

### Copyright 2018 SMABILITY  

*Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:*

*The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.*

_THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE._
