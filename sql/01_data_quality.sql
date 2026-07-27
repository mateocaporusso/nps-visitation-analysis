-- ============================================================
-- 01_data_quality.sql
-- Creación de la base, schemas, tablas raw, y validación de la carga
-- ============================================================

CREATE SCHEMA IF NOT EXISTS raw;
CREATE SCHEMA IF NOT EXISTS analytics;

CREATE TABLE raw.main_data (
    unit_code   VARCHAR(4),
    year        INTEGER,
    month       INTEGER,
    statistic   VARCHAR(10),
    value       INTEGER
);

CREATE TABLE raw.state_lookup (
    unit_code   VARCHAR(4),
    year        INTEGER,
    month       INTEGER,
    statistic   VARCHAR(10),
    value       INTEGER,
    state_id    VARCHAR(2)
);

-- Después de crear estas tablas, importar los CSV vía pgAdmin
-- (clic derecho en la tabla -> Import/Export Data -> Header: ON, Delimiter: ",", Quote: '"')

SELECT COUNT(*) AS filas_main_data FROM raw.main_data;
-- Esperado: 2.905.440

SELECT COUNT(*) AS filas_state_lookup FROM raw.state_lookup;
-- Esperado: 743.040

SELECT
    COUNT(*) FILTER (WHERE unit_code IS NULL) AS nulos_unit_code,
    COUNT(*) FILTER (WHERE year IS NULL)      AS nulos_year,
    COUNT(*) FILTER (WHERE month IS NULL)     AS nulos_month,
    COUNT(*) FILTER (WHERE statistic IS NULL) AS nulos_statistic,
    COUNT(*) FILTER (WHERE value IS NULL)     AS nulos_value
FROM raw.main_data;
-- Esperado: 0 en todas las columnas

SELECT unit_code, year, month, statistic, COUNT(*)
FROM raw.main_data
GROUP BY unit_code, year, month, statistic
HAVING COUNT(*) > 1;
-- Esperado: 0 filas devueltas

SELECT unit_code, year, month, statistic, value
FROM raw.main_data
WHERE value < 0
ORDER BY value ASC;
-- 63 filas negativas de 2,9M (0.002%), consistentes con correcciones
-- de conteo legítimas del NPS. No se "arreglan": se documentan.

SELECT MIN(value), MAX(value)
FROM raw.main_data;
