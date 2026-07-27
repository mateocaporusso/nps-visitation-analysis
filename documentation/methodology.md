# Metodologia

## 1. Fuente y alcance
Datos oficiales del NPS Visitor Use Statistics Data Package 2025. Se uso unicamente la estadistica "Recreation Visits" (codigo TRV). Periodo: 1979-2025.

## 2. Carga de datos
Los CSV se cargaron sin modificar en PostgreSQL, schema raw, respetando la estructura original (formato largo).

## 3. Validacion de calidad
Conteo de filas post-importacion (coincidencia exacta), nulos por columna (0), duplicados (0), valores negativos (63 filas de 2,9M, documentadas como correcciones legitimas del NPS).

## 4. Limpieza
Se filtro raw.main_data a statistic = 'TRV', generando analytics.park_visits (193.696 filas). Se extrajo tabla de referencia unica unit_code -> state_id desde raw.state_lookup, generando analytics.park_state (440 filas).

## 5. Decisiones de alcance
- 14 de las 15 categorias de "Statistic" quedaron fuera por no ser necesarias.
- No se incorporo clasificacion por tipo de unidad (parque/ruta/memorial): el dataset no la incluye y se documenta como limitacion.
- No se uso modelado estadistico (regresion, desvio estandar): todas las comparaciones de tendencia se resolvieron con comparaciones interanuales simples.
- El mapeo parque-estado solo esta disponible oficialmente para 2016-2025; se asumio constante en el tiempo y se aplico al historico completo.

## 6. Analisis
SQL: agregaciones (SUM, GROUP BY), porcentajes, JOINs, comparaciones interanuales pareadas via subqueries con nombre.

## 7. Visualizacion
Power BI Desktop, conectado directamente a PostgreSQL. Seis hojas, una por pregunta de negocio.

## 8. Hechos vs. interpretacion
En hallazgos con cambios porcentuales extremos se documento que probablemente reflejan factores puntuales (cierres, obras, cambios de metodologia), sin afirmaciones causales. El dataset no incluye variables explicativas, por lo que el analisis es descriptivo y exploratorio, no causal.
