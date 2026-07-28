# Metodología

Usé los datos oficiales del NPS Visitor Use Statistics Data Package 2025. De las 15 categorías que trae la columna "Statistic" del archivo, me quedé solo con "TRV" (Recreation Visits), que es la métrica que el NPS define como la visitación estándar. El resto (horas de visita, estadías nocturnas, etc.) no lo necesitaba para las preguntas que quería responder, así que no tenía sentido cargarlo todo.

Los CSV los subí a PostgreSQL sin tocarlos, en un schema `raw`, tal cual venían. De ahí armé las tablas limpias en `analytics`: filtré por TRV y calculé una columna de fecha para poder agrupar por período más fácil.

Antes de analizar nada, revisé que la carga estuviera bien: conté filas y comparé contra el archivo original, busqué nulos (no había), busqué duplicados (tampoco), y encontré 63 filas con valores negativos sobre casi 3 millones. Investigué esas filas y son ajustes que el NPS carga cuando corrige un conteo de un mes anterior — no las "arreglé" ni inventé un valor, las dejé como están y las documenté.

Para el análisis geográfico armé una tabla de referencia parque → estado a partir del segundo archivo (Main_State_Data.csv), que solo cubre 2016-2025. Asumí que esa relación se mantiene igual en todo el período 1979-2025, porque la ubicación de un parque no cambia de un año a otro — es un supuesto razonable pero no lo pude verificar parque por parque.

Decisiones que tomé a propósito para no complicar el proyecto de más:

- No clasifiqué las unidades por tipo (parque / ruta escénica / memorial), porque el dataset no lo trae y traer otra fuente solo para eso sumaba complejidad sin necesidad. Donde esto afecta un resultado (como el ranking de top parques, que mezcla categorías distintas), lo aclaro directamente ahí.
- No usé nada de estadística inferencial (regresión, desvío estándar). Todas las comparaciones de tendencia las resolví comparando dos años puntuales y calculando el % de cambio — más simple y más fácil de explicar sin perder el hallazgo.
- Todo el análisis se hizo en SQL: agregaciones, joins, subqueries para comparar años.
- La visualización se hizo en Power BI Desktop, conectado directo a PostgreSQL.

Algo que traté de tener presente en todo el análisis: cuando un número sale muy extremo (una caída del 89%, un crecimiento del 200%), no asumí que eso "significa" algo por sí solo. El dataset no tiene información de presupuesto, clima, infraestructura ni nada que explique el por qué — así que donde encontré esos casos, los dejé marcados como posibles artefactos de datos (cierres, obras, cambios de metodología) en vez de sacar una conclusión que los datos no pueden sostener.
