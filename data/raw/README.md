# Datos crudos — instrucciones de descarga

Los archivos originales no se incluyen en este repositorio por su tamaño. Para reproducir el proyecto, descargalos desde la fuente oficial:

## Main_Data.csv
Fuente: National Park Service (NPS), U.S. Department of the Interior
Página del dataset: https://catalog.data.gov/dataset/nps-visitor-use-statistics-data-package-2025
Descarga directa: https://irma.nps.gov/DataStore/DownloadFile/756959?Reference=2317666
Período: 1979-2025 | Filas: 2.905.440 | Licencia: dominio público (CC0)

## Main_State_Data.csv
Descarga directa: https://irma.nps.gov/DataStore/DownloadFile/756960?Reference=2317666
Período: 2016-2025 | Filas: 743.040
Lo uso solo para armar la tabla de referencia parque-estado.

## Pasos para reproducir
1. Descargar los 2 archivos y guardarlos acá.
2. Crear la base en PostgreSQL (ver documentation/methodology.md).
3. Importar los CSV a raw.main_data y raw.state_lookup vía pgAdmin.
4. Correr los scripts de sql/ en orden: 01 → 02 → 03 → 04.
