# Proyecto Integrador: RetailPro – Análisis de Ventas y Rentabilidad

## Descripción del Proyecto
**RetailPro** es una solución integral de Inteligencia de Negocios (BI) desarrollada para diagnosticar y monitorear el desempeño comercial de una distribuidora de productos tecnológicos.

El proyecto nace ante la necesidad de responder una pregunta diagnóstica crítica para la gerencia: **"¿A qué se debe la caída del 8% en el último semestre en el margen de ganancia de los productos en la región sur?"**.
A lo largo del repositorio se documenta todo el ciclo de vida del dato: desde el diseño e implementación de bases de datos relacionales y consultas analíticas en SQL, pasando por la extracción y limpieza ETL, 
hasta el modelado dimensional en estrella y la visualización ejecutiva.

---

## Arquitectura y Herramientas Utilizadas
* **SQL Server / SSMS (SQL Server Management Studio):** Diseño de esquemas relacionales (DDL), carga de datos (DML) y desarrollo de consultas analíticas de negocio (`INNER JOIN`, `LEFT JOIN`, `UNION ALL`) sobre la base de práctica `Ventas_Tech_DB`.
* **Power BI Desktop (Power Query & Lenguaje M):** Extracción desde archivos planos (`.csv`/`.xlsx`), perfilado, limpieza de duplicados, tratamiento de valores nulos y transformación hacia un modelo en estrella (`Dim_Clientes`, `Dim_Productos`, `Dim_Categorias`, `Fact_Ventas`) para **RetailPro**.
* **DAX (Data Analysis Expressions):** Creación de tabla calendario (`Dim_Fechas`), medidas de inteligencia de tiempo (`TOTALYTD`, `SAMEPERIODLASTYEAR`) y KPIs financieros.
* **GitHub:** Control de versiones y documentación técnica del proyecto.

---

## Estructura del Repositorio

```text
├── m4_consultas_negocio.sql          # Métricas comerciales, rankings y CASE WHEN sobre Ventas_Tech_DB (M4)
├── m5_consultas_joins.sql            # Cruces con INNER/LEFT JOIN y UNION ALL sobre Ventas_Tech_DB (M5)
├── Pipeline_ETL_Santano_Valentin.pbix # Extracción desde CSV, limpieza en Power Query y código M de RetailPro (M6)
├── Santano_Valentin_Checkpoint2.pbix # Modelo en estrella, tabla calendario y medidas DAX de RetailPro (M8)
└── README.md                         # Documentación técnica del proyecto
```
---
## Guía paso a paso: Cómo ejecutar los scripts SQL

Los scripts .sql de este repositorio fueron desarrollados para operar sobre la base de datos relacional Ventas_Tech_DB en SQL Server Managment Studio (SSMS). Por su parte, el dataset de RetailPro proviene de archivos planos (.csv)
que se ingieren y transforman directamente en Power BI Desktop.

### 1. Para reproducir las consultas SQL en tu entorno local:
1. Abrí SSMS y conectate a tu instancia local.
2. Asegurate de tener creada y seleccionada la base de datos relacional (USE Ventas_Tech_DB;).
3. Ejecutá m4_consultas_negocio.sql para obtener los resúmenes ejecutivos mensuales, rankings de productos, clientes activos y clasificación de desempeño.
4. Ejecutá m5_consultas_joins.sql para generar las vistas consolidadas (INNER JOIN), detectar clientes y productos sin rotación (LEFT JOIN) y analizar el consolidado por canal (UNION ALL).

---

### Modelo de Datos Analítico (RetailPro)
El modelo final en Power BI implementa un esquema en estrella con cardinalidad 1:N y dirección de filtro única desde las dimensiones hacia la tabla de hechos Fact_Ventas (50 transacciones válidas), 
cruzando 11 clientes únicos,12 productos, 4 categorías y una tabla calendario dinámica (Dim_Fechas).
