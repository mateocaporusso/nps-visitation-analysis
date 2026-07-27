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

CREATE TABLE analytics.park_state AS
SELECT DISTINCT
    unit_code,
    state_id
FROM raw.state_lookup;

SELECT COUNT(*) FROM analytics.park_state;
