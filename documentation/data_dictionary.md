# Diccionario de Datos

## raw.main_data (carga cruda de Main_Data.csv)

| Columna | Tipo | Descripcion | Ejemplo |
|---|---|---|---|
| unit_code | VARCHAR(4) | Codigo oficial de la unidad NPS | YELL (Yellowstone) |
| year | INTEGER | Ano calendario | 1992 |
| month | INTEGER | Mes calendario (1-12) | 7 |
| statistic | VARCHAR(10) | Tipo de estadistica reportada | TRV |
| value | INTEGER | Valor correspondiente a esa estadistica | 1586 |

## raw.state_lookup (carga cruda de Main_State_Data.csv)

Misma estructura que raw.main_data, mas una columna state_id (VARCHAR(2)). Cubre solo 2016-2025. Se usa exclusivamente para construir analytics.park_state.

## Codigos oficiales de la columna Statistic

Fuente: metadata oficial del NPS (NPS_VUStats_Data_2025_metadata.xml).

| Codigo | Definicion oficial | Se usa en este proyecto |
|---|---|---|
| TRV | Recreation Visits | Si, metrica principal |
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

## analytics.park_visits (tabla limpia)

| Columna | Tipo | Descripcion |
|---|---|---|
| unit_code | VARCHAR(4) | Codigo de la unidad NPS |
| year | INTEGER | Ano |
| month | INTEGER | Mes |
| recreation_visits | INTEGER | Visitas recreativas (solo statistic = TRV) |
| visit_date | DATE | Fecha calculada, para series temporales |

Filas: 193.696

## analytics.park_state (tabla de referencia)

| Columna | Tipo | Descripcion |
|---|---|---|
| unit_code | VARCHAR(4) | Codigo de la unidad NPS |
| state_id | VARCHAR(2) | Codigo de estado |

Filas: 440 (400 parques; 26 con mas de 1 estado, 3 de ellos con 3 o mas)

## analytics.post_pandemic_recovery / analytics.silent_growth

| Columna | Tipo | Descripcion |
|---|---|---|
| unit_code | VARCHAR(4) | Codigo de la unidad NPS |
| visitas_YYYY (x2) | BIGINT | Total de visitas del ano de comparacion |
| variacion_porcentual | NUMERIC | % de cambio entre ambos anos |

Filtro aplicado: solo unidades con mas de 100.000 visitas en el ano base.
