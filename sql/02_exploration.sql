-- ============================================================
-- 02_exploration.sql
-- Exploración de la columna "Statistic", investigación de
-- anomalías, y construcción de las tablas limpias (analytics)
-- ============================================================

SELECT statistic, COUNT(*)
FROM raw.main_data
GROUP BY statistic
ORDER BY statistic;

SELECT year, COUNT(DISTINCT unit_code) AS parques_reportando
FROM raw.main_data
WHERE statistic = 'TRV'
GROUP BY year
ORDER BY year;

SELECT unit_code, COUNT(DISTINCT state_id) AS cantidad_estados
FROM raw.state_lookup
GROUP BY unit_code
HAVING COUNT(DISTINCT state_id) > 1
ORDER BY cantidad_estados DESC;

-- Verificación: para parques multi-estado, el valor se reparte
-- proporcionalmente (no se duplica). Ejemplo verificado: HOVE en
-- 2020-06, TRV: CO=990 + UT=1260 = 2250, coincide con el total.

-- ============================================================
-- Limpieza: construcción de las tablas de analytics
-- ============================================================

CREATE TABLE analytics.park_visits AS
SELECT
    unit_code,
    year,
    month,
    value AS recreation_visits,
    MAKE_DATE(year, month, 1) AS visit_date
FROM raw.main_data
WHERE statistic = 'TRV';

SELECT COUNT(*) FROM analytics.park_visits;
-- Esperado: 193.696

CREATE TABLE analytics.park_state AS
SELECT DISTINCT
    unit_code,
    state_id
FROM raw.state_lookup;

SELECT COUNT(*) FROM analytics.park_state;
-- Esperado: 440 (400 parques + filas extra por unidades multi-estado)
