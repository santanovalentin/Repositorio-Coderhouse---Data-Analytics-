------------- Consulta 1 - Resumen ejecutivo mensual -----------

SELECT
   MONTH(fecha_venta) AS Mes,
   SUM (cantidad * precio_unitario) AS Total_Facturado,
   COUNT(id_venta) AS Cantidad_de_pedidos,
   AVG (cantidad * precio_unitario) AS Ticket_Promedio
FROM ventas
GROUP BY MONTH(fecha_venta);

------------- Consulta 2 - Ranking de productos -----------

SELECT 
  TOP 5 id_producto,
  SUM(cantidad) AS unidades_vendidas,
  SUM(cantidad * precio_unitario) AS Total_generado

FROM ventas
GROUP BY id_producto
ORDER BY Total_generado DESC;

------------- Consulta 3 - Clientes recurrentes -----------

SELECT
 id_cliente,
 COUNT(*) AS Cantidad_de_pedidos,
 SUM(cantidad * precio_unitario) AS Total_gastado

FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1;


------------- Consulta 4 - Productos por encima/por debajo del promedio -----------

------------- Paso 1: Con la CTE calculo los totales por grupo ----------

WITH Totales_agrupados AS (
SELECT
 id_producto,
 SUM(cantidad * precio_unitario) AS Total_Facturado
FROM ventas
GROUP BY id_producto
)

-- Paso 2: La consulta final usa la CTE para comparar contra el promedio general
SELECT 
    id_producto,
    Total_Facturado,
    CASE 
        WHEN Total_Facturado > (SELECT AVG(Total_Facturado) FROM Totales_agrupados) THEN 'Por encima' ELSE 'Por debajo' END AS Rendimiento
FROM Totales_agrupados;

------------------------ HALLAZGOS ------------------------
------ 1. Concentración de ingresos: El producto 1 es el producto estrella, concentra la mayor parte de la facturación mensual.
------ 2. Fidelidad de clientes: Se cuenta con una base solida de 5 clientes recurrentes que realizaron múltiples pedidos durante el mes.
------ 3. Al evaluar los totales, existe una brecha notable. Algunos productos rinden significativamente 'Por encima' del promedio, compensando a los que quedaron 'Por debajo'.