-- Evolucion historica 1979-2025
SELECT year, SUM(recreation_visits) AS total_visitas
FROM analytics.park_visits
GROUP BY year
ORDER BY year;

-- Top 10 parques mas visitados
SELECT
    unit_code,
    SUM(recreation_visits) AS total_visitas,
    ROUND(100.0 * SUM(recreation_visits) / (SELECT SUM(recreation_visits) FROM analytics.park_visits), 2) AS porcentaje_del_total
FROM analytics.park_visits
GROUP BY unit_code
ORDER BY total_visitas DESC
LIMIT 10;

-- Estacionalidad por mes
SELECT
    month,
    SUM(recreation_visits) AS total_visitas,
    ROUND(100.0 * SUM(recreation_visits) / (SELECT SUM(recreation_visits) FROM analytics.park_visits), 2) AS porcentaje_del_total
FROM analytics.park_visits
GROUP BY month
ORDER BY month;

-- Concentracion por estado
SELECT
    ps.state_id,
    SUM(pv.recreation_visits) AS total_visitas,
    ROUND(100.0 * SUM(pv.recreation_visits) / (SELECT SUM(recreation_visits) FROM analytics.park_visits), 2) AS porcentaje_del_total
FROM analytics.park_visits pv
JOIN analytics.park_state ps ON pv.unit_code = ps.unit_code
GROUP BY ps.state_id
ORDER BY total_visitas DESC
LIMIT 15;

-- Recuperacion post-pandemia 2019 vs 2024
SELECT
    v2019.unit_code, v2019.visitas_2019, v2024.visitas_2024,
    ROUND(100.0 * (v2024.visitas_2024 - v2019.visitas_2019) / v2019.visitas_2019, 2) AS variacion_porcentual
FROM
    (SELECT unit_code, SUM(recreation_visits) AS visitas_2019 FROM analytics.park_visits WHERE year = 2019 GROUP BY unit_code) v2019
JOIN
    (SELECT unit_code, SUM(recreation_visits) AS visitas_2024 FROM analytics.park_visits WHERE year = 2024 GROUP BY unit_code) v2024
    ON v2019.unit_code = v2024.unit_code
WHERE v2019.visitas_2019 > 100000
ORDER BY variacion_porcentual ASC
LIMIT 15;

-- Crecimiento silencioso 2015 vs 2025
SELECT
    v2015.unit_code, v2015.visitas_2015, v2025.visitas_2025,
    ROUND(100.0 * (v2025.visitas_2025 - v2015.visitas_2015) / v2015.visitas_2015, 2) AS variacion_porcentual
FROM
    (SELECT unit_code, SUM(recreation_visits) AS visitas_2015 FROM analytics.park_visits WHERE year = 2015 GROUP BY unit_code) v2015
JOIN
    (SELECT unit_code, SUM(recreation_visits) AS visitas_2025 FROM analytics.park_visits WHERE year = 2025 GROUP BY unit_code) v2025
    ON v2015.unit_code = v2025.unit_code
WHERE v2015.visitas_2015 > 100000
ORDER BY variacion_porcentual DESC
LIMIT 15;
