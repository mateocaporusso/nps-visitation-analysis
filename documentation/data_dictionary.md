# Diccionario de datos

## raw.main_data

Es la carga cruda de Main_Data.csv, sin modificar.

| Columna | Tipo | Qué es |
|---|---|---|
| unit_code | VARCHAR(4) | Código de 4 letras del parque (ej: YELL = Yellowstone) |
| year | INTEGER | Año |
| month | INTEGER | Mes (1-12) |
| statistic | VARCHAR(10) | Qué tipo de estadística es esta fila (ver tabla de abajo) |
| value | INTEGER | El número correspondiente a esa estadística |

## raw.state_lookup

Mismas columnas que main_data, más `state_id` (el estado, en 2 letras). Solo cubre 2016-2025. La uso únicamente para sacar la relación parque-estado, no para nada más.

## Los códigos de "statistic"

El archivo trae 15 categorías distintas mezcladas en la misma columna. Busqué las definiciones oficiales en la metadata que publica el NPS junto con el dataset:

| Código | Qué significa | ¿Lo usé? |
|---|---|---|
| TRV | Recreation Visits | Sí — es la única que uso en todo el proyecto |
| TNRV | Non-Recreation Visits | No |
| TV | Total Visits | No |
| TRVH | Recreation Visitor Hours | No |
| TNRVH | Non-Recreation Visitor Hours | No |
| TH | Visitor Hours | No |
| BC | Backcountry Overnight Stays | No |
| CCG | Concessionaire Campground Overnight Stays | No |
| CL | Concessionaire Lodging Overnight Stays | No |
| MISC | Miscellaneous Overnight Stays | No |
| NROS | Non-Recreation Overnight Stays | No |
| TOS | Total Overnight Stays | No |
| TT | NPS Campground Tent Overnight Stays | No |
| TTRV | NPS Campground Overnight Stays (Tent+RV) | No |
| TRVS | NPS Campground RV Overnight Stays | No |

## analytics.park_visits

La tabla que uso para casi todo el análisis. 193.696 filas.

| Columna | Tipo | Qué es |
|---|---|---|
| unit_code | VARCHAR(4) | Código del parque |
| year | INTEGER | Año |
| month | INTEGER | Mes |
| recreation_visits | INTEGER | Visitas (ya filtrado a TRV) |
| visit_date | DATE | Fecha armada a partir de year+month, para agrupar más fácil |

## analytics.park_state

440 filas — 400 parques, pero 26 aparecen más de una vez porque están repartidos en varios estados (el caso más extremo es el Appalachian Trail, en 14 estados).

| Columna | Tipo | Qué es |
|---|---|---|
| unit_code | VARCHAR(4) | Código del parque |
| state_id | VARCHAR(2) | Estado |

## analytics.post_pandemic_recovery / analytics.silent_growth

Mismas columnas en las dos: unit_code, las visitas de cada uno de los dos años que comparo, y el % de variación entre ambos. Filtré para quedarme solo con parques que ya tenían más de 100.000 visitas en el año base — si no, los parques chiquitos meten variaciones de +300% que en realidad no dicen nada, solo ruido.
