# Cyclistic: caso de estudio 
**Análisis de uso del servicio de bicicletas urbanas de Chicago para su uso en marketing**

## Brief
El propósito de este proyecto es implementar los conocimientos adquiridos en la [Certificación de Google y Coursera Analista de Datos Profesional](https://www.coursera.org/programs/crece-con-google-2026-fundacion-compromiso-05nl2/specializations/google-data-analytics). Se abordó según los lineamientos del ejercicio y se buscaron rasgos de uso diferenciadores del segmento de usuarios casuales, frente a los miembros anuales. Cabe destacar que el segmento de usuarios de interés es 11 veces menor a su contraparte, con lo cual, me centré en buscar tendencias dentro del propio segmento y en rasgos que al compararlo con el segmento de miembros, los casuales lo superaran, los cuales fueron el tiempo promedio de uso y la proporción de los viajes redondos. 
	
### [Presentación de resultados (PDF)](https://github.com/pixelciosa/cyclistic/blob/main/Cyclistic.pdf)

## Bitácora del proyecto
**Tarea de negocio:** Diferenciar los miembros anuales de los casuales según el uso que le dan a las bicicletas. Buscamos características que puedan usarse en estrategias de medios digitales para conseguir que los usuarios casuales prefieran ser miembros anuales.

**Métricas:** duración promedio de viaje, proporción de viajes redondos, proporción de uso entre semana y fines de semana, distribución de tipos de usuario según horarios, días y meses de uso, principales estaciones de inicio y final del viaje.

**Partes interesadas:** Directora de Marketing, Ejecutivos de Cyclistic  

**Fuentes de datos utilizadas:**   
Los datos son publicados por la empresa que los recopila con licencia de uso público y limitado. No cuentan con ningún tipo de garantía, se entregan tal cual están, en archivos .zip. Los datos disponibles son desde 2013 y varía el alcance temporal de cada archivo a través del tiempo. El 2013 está en un solo archivo, del 2014 al 2017 inclusive, están en archivos semestrales (2 trimestres por archivo), del 2018 al primer trimestre del 2020 está en archivos trimestrales y desde abril 2020 en adelante hay un archivo por cada mes. 

**Herramientas elegidas:** Google Spreadsheets y Jupiter Notebook para exploración y limpieza de datasets por separado. DBeaver para trabajar con el dataset unificado. Tableau para las visualizaciones.

**Procesamiento de datos:**

1. Líneas vacías: en Cyclistic\_Trips\_2020\_Q1 se detectaron 2 y se borraron (líneas 426889 y 426890\) y en en Cyclistic\_Trips\_2019\_Q1 también se detectaron 2 y se borraron (líneas 365071 y 365072\)  
2. Columnas comunes: los datasets tienen columnas con distintos datos y algunos datos en común aunque el nombre de las columnas no es igual. De modo que tenemos:

   1. Columnas en común con nombres diferentes (2019 \| 2020):  
      * trip\_id \| ride\_id  
        * valores: numéricos \| alfanuméricos  
      * start\_time \| started\_at  
      * end\_time \| ended\_at  
      * from\_station\_id \| start\_station\_id  
      * from\_station\_name \| start\_station\_name  
      * to\_station\_id \| ​​end\_station\_id  
      * to\_station\_name \| end\_station\_name  
      * usertype \| member\_casual  
        * valores: subscriber \- customer \| member \- casual  
   2. Columnas distintas  
      * 2019:   
        * bikeid  
        * tripduration (en cantidad de segundos)  
        * gender  
        * birthyear  
      * 2020:   
        * rideable\_type   
        * start\_lat  
        * start\_lng  
        * end\_lat  
        * end\_lng  
3. Se manipularon los datasets para contener solo las columnas comunes y los nombres de columna y valores correspondientes a 2020 por ser más actuales.  
4. Se calculó el tiempo del viaje en la columna ride\_length usando el formato hh:mm:ss  
5. Se sumó una columna para el número de la semana en que se empezó el viaje. (1 \= domingo y 7= sábado)  
6. Se planea validar si los viajes que se hacen en Headquarters que se deberían sacar de la muestra, ya que en el dataset de 2020, hay 3765 registros que empiezan y terminan en la estación llamada “HQ QR”   
   1. 3761 valores son de menos de un minuto y 4 de más de un minuto.  
   2. hay duraciones negativas  
7. En el motor de SQL (DBeaver) la columna ride\_length se creó de TYPE INTERVAL por tener formato hh:mm:ss y tener valores mayores de 24 horas en algunos casos.  
8. Se hizo un UNION ALL de los 2 datasets y los ride\_id pasaron a ser TYPE VARCHAR(255)  
9. Se confirma que los viajes que inician en “HQ QR” son datos de prueba, al igual que los viajes con duración negativa, de modo que se excluyen esos datos  
10. Se valida que la unidad de tiempo deseable para el ride\_length es en cantidad de segundos con formato de número con decimales y se cambia.

**Análisis de datos:**

| Métrica | Casual | Member |
| :---- | :---- | :---- |
| Duración promedio de viaje | **El \~88% de los viajes son de menos de una hora**, y el \~11% de más de una hora. tendencia que se mantiene estable entre el Q1 del 2029 y el Q1 del 2020\.  | El 99,7% de los viajes son de menos de una hora, y el 0,23% de más de una hora. tendencia que se mantiene estable entre el Q1 del 2029 y el Q1 del 2020\.  |
| Duración promedio de viaje | **De los viajes de más de una hora, el 68% es de usuarios casuales** y 31% de miembros |  |
| Duración promedio de viaje | **El promedio de viaje durante el Q1 es de \~1.5 horas**  | El promedio de viaje durante el Q1 es de 13 minutos  |
| Duración promedio de viaje | El mes con **mayor promedio de viajes es febrero** y el de menor duración promedio es marzo | No varía significativamente entre los meses del Q1 |
| Duración promedio de viaje | **El día de la semana con mayor tiempo promedio de viajes es el jueves** y el de menor duración promedio son miércoles y sábado.  | No varía significativamente entre los días de la semana del Q1 |
| Proporción de viajes redondos | **14% de los viajes de usuarios casuales empieza y termina en la misma estación** | 2% de los viajes de usuarios casuales empieza y termina en la misma estación |
| Proporción de uso entre semana y fines de semana | La cantidad de usuarios casuales **aumenta el fin de semana siendo el Domingo el día más popular** con \+18.6 mil usuarios casuales. El día menos popular es el Lunes con un promedio de \+5.5 mil usuarios casuales.  | La cantidad de usuarios casuales disminuye el fin de semana siendo el Sábado el día menos popular con \+59.4 mil miembros. El día más popular es el Martes con un promedio de \+127.9 mil usuarios casuales.  |
| Distribución de tipos de usuario según el mes | **Marzo** es el mes con mayor cantidad de viajes del Q1, llegando a sobrepasar a la suma de Enero y Febrero por \~13 mil viajes. | Marzo es el mes con mayor cantidad de viajes y febrero el más bajo, con una diferencia entre ellos de \~45 mil viajes. |
| Distribución de tipos de usuario según horarios y días de uso | **La franja preferida por los usuarios casuales es durante el día los fines de semana** con \+14 mil usuarios promedio cada día. | La franja preferida por los usuarios casuales es durante la hora pico los días entre semana con \+71 mil usuarios cada día. |
| Principales estaciones de inicio y final del viaje. | **Las estaciones más usadas son las que se ubican rodeando la costa, desde el Teatro del Lago hasta el Planetario Adler.**  | Las estaciones más usadas son las que se ubican desde Larrabee St & Kingsbury St. hasta Canal St & Adams St. con concentración en la zona de la terminal de tren. |
| Principales estaciones de inicio y final del viaje. | **Destacan Streeter Dr & Grand Ave** y Lake Shore Dr & Monroe St. con \+2.7 viajes casuales en promedio. | Destacan Canal St & Adams St y Clinton St & Madison St con \+13.3 mil viajes de miembros |
| Principales estaciones de inicio y final del viaje. | **En viajes redondos la estación más elegida para viajes casuales es Lake Shore Dr & Monroe St** con \+700 viajes. Seguido por distintas estaciones que bordean o están cerca de la costa | En viajes redondos las 10 estaciones más elegidas entre los miembros rondan los 110 viajes y se ubican desde California Ave & Motrose Ave al norte hasta Shore Dr & 55th St al sur con concentración en la zona media entre el río Chicago y su desembocadura en el lago Michigan. La que más viajes tiene es Wabash Ave & Grand Av con un promedio de 162 viajes redondos de miembros. |

**Recomendaciones:**

* Las acciones de marketing podrían enfocarse en la zona geográfica de la costa que es donde se encuentran las 10 estaciones más utilizadas, con mayor intensidad en Streeter Dr & Grand Ave y Lake Shore Dr & Monroe.  
* El mes de febrero es el mejor  mes del Q1 para aprovechar que los viajes suelen ser más largos para explotar la propuesta de valor minuto a minuto de la membresía anual.  
* La franja semanal con mayor cantidad de usuarios casuales es durante las horas de sol del sábado y domingo y el mes con mayor cantidad de viajes es Marzo, se recomienda tenerlo en cuenta en caso de planificar desplegar promociones y activaciones de la campaña de membresía.  
* Considerar incluir en los datos brutos futuros el id de usuario para poder hacer un análisis más centrado en el comportamiento de los usuarios en el tiempo lo que permitiría incluir en futuros análisis, por ejemplo, la frecuencia de viajes.


	
