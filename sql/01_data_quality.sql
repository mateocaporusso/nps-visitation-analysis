CREATE SCHEMA raw;
CREATE SCHEMA analytics;

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

SELECT COUNT(*) FROM raw.main_data;

SELECT COUNT(*) FROM raw.state_lookup;

SELECT
    COUNT(*) FILTER (WHERE unit_code IS NULL) AS nulos_unit_code,
    COUNT(*) FILTER (WHERE year IS NULL) AS nulos_year,
    COUNT(*) FILTER (WHERE month IS NULL) AS nulos_month,
    COUNT(*) FILTER (WHERE statistic IS NULL) AS nulos_statistic,
    COUNT(*) FILTER (WHERE value IS NULL) AS nulos_value
FROM raw.main_data;

SELECT unit_code, year, month, statistic, COUNT(*)
FROM raw.main_data
GROUP BY unit_code, year, month, statistic
HAVING COUNT(*) > 1;

SELECT unit_code, year, month, statistic, value
FROM raw.main_data
WHERE value < 0
ORDER BY value ASC;

SELECT MIN(value), MAX(value)
FROM raw.main_data;
