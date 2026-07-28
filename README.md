# Analisis de Visitacion en Parques Nacionales de EEUU (1979-2025)

**Autor:** Mateo Caporusso
**Stack:** PostgreSQL - SQL - Power BI Desktop

Proyecto de portfolio de Data Analyst Junior. Analiza casi 47 anos de datos oficiales de visitacion al Sistema de Parques Nacionales de Estados Unidos, publicados por el National Park Service (NPS).

## Objetivo
Analizar la evolucion historica de la visitacion a los parques nacionales de EEUU para identificar patrones estacionales, diferencias geograficas entre estados, y tendencias de crecimiento o declive por parque durante el periodo 1979-2025.

## Preguntas de negocio
1. Como evoluciono la visitacion total al sistema entre 1979 y 2025?
2. Que parques concentran la mayor cantidad de visitas historicas, y que % del total representan?
3. Que meses del ano concentran mas visitas (estacionalidad)?
4. Que estados concentran mas visitas?
5. Que parques todavia no se recuperaron del impacto de la pandemia (2019 vs. 2024)?
6. Que parques tuvieron el mayor crecimiento reciente, mas alla de su tamano (2015 vs. 2025)?

## Fuente de datos
NPS Visitor Use Statistics Data Package, 2025 - National Park Service, U.S. Department of the Interior
DOI: 10.57830/2317666 | https://irma.nps.gov/Stats/

Los CSV originales estan en `data/raw/` (no se suben a Github por su tamano, ver `data/raw/README.md`).

## Estructura del repositorio
```
├── data/raw/          -> CSV originales + instrucciones de descarga
├── sql/                -> 01 a 04, todo el analisis en SQL
├── documentation/       -> diccionario de datos y metodologia
├── powerbi/             -> archivo .pbix + reporte final en Word
```

## Herramientas utilizadas
PostgreSQL 16, SQL, Power BI Desktop, pgAdmin 4.

## Hallazgos principales
- El sistema perdio el 27,6% de sus visitas en 2020 por la pandemia, recuperandose casi por completo en 1 ano.
- El top 10 de unidades mas visitadas concentra ~29% del total historico, mezclando parques tradicionales con rutas escenicas y sitios urbanos.
- Julio y agosto concentran ~28% de las visitas anuales de todo el sistema.
- Los primeros 15 estados (de 55) concentran ~96% de las visitas totales.
- Un grupo de unidades muestra caidas de mas del 50% entre 2019 y 2024, probablemente por factores puntuales.
- Gulf Islands National Seashore (GUIS) combina alto volumen historico con un crecimiento reciente del +90%.

Ver el reporte completo en `powerbi/NPS_Visitation_Reporte_Final.docx` para el detalle de cada hallazgo, su evidencia y sus limitaciones.

## Limitaciones
Ver `documentation/methodology.md` para el detalle completo.
