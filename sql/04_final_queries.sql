CREATE TABLE analytics.post_pandemic_recovery AS
SELECT
    v2019.unit_code, v2019.visitas_2019, v2024.visitas_2024,
    ROUND(100.0 * (v2024.visitas_2024 - v2019.visitas_2019) / v2019.visitas_2019, 2) AS variacion_porcentual
FROM
    (SELECT unit_code, SUM(recreation_visits) AS visitas_2019 FROM analytics.park_visits WHERE year = 2019 GROUP BY unit_code) v2019
JOIN
    (SELECT unit_code, SUM(recreation_visits) AS visitas_2024 FROM analytics.park_visits WHERE year = 2024 GROUP BY unit_code) v2024
    ON v2019.unit_code = v2024.unit_code
WHERE v2019.visitas_2019 > 100000;

CREATE TABLE analytics.silent_growth AS
SELECT
    v2015.unit_code, v2015.visitas_2015, v2025.visitas_2025,
    ROUND(100.0 * (v2025.visitas_2025 - v2015.visitas_2015) / v2015.visitas_2015, 2) AS variacion_porcentual
FROM
    (SELECT unit_code, SUM(recreation_visits) AS visitas_2015 FROM analytics.park_visits WHERE year = 2015 GROUP BY unit_code) v2015
JOIN
    (SELECT unit_code, SUM(recreation_visits) AS visitas_2025 FROM analytics.park_visits WHERE year = 2025 GROUP BY unit_code) v2025
    ON v2015.unit_code = v2025.unit_code
WHERE v2015.visitas_2015 > 100000;
