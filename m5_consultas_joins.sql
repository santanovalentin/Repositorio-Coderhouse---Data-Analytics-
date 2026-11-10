/* Consulta 1 - Vista base del proyecto - INNER JOIN */

SELECT 
v.id_venta,
c.Nombre AS nombre_cliente,
p.nombre_producto,
v.fecha_venta,
v.cantidad,
v.precio_unitario,
 (v.cantidad * precio_unitario) AS total_venta

FROM Ventas v
INNER JOIN Clientes c ON v.id_cliente = c.id_cliente
INNER JOIN Productos p ON v.id_producto = p.id_producto
;

/* Consulta 2 - Clientes sin ventas - LEFT JOIN */
--Propósito: Detectar clientes registrados que nunca compraron, para que el area de CRM los contacte o analice el motivo de inactividad.

SELECT 
c.nombre,
c.email,
c.fecha_registro

FROM clientes c 
LEFT JOIN ventas v ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;

/* Consulta 3 - Productos sin ventas - LEFT JOIN */
-- Propósito: Identificar productos del catálogo que no tienen movimiento de ventas, 
-- para que el área de Producto evalúe estrategias de promoción o discontinuación.--

SELECT 
p.nombre_producto,
p.id_categoria,
p.precio

FROM productos p
LEFT JOIN ventas v ON p.id_producto = v.id_producto
WHERE v.id_cliente IS NULL;

/* Consulta 4 - Consolidado por canal - UNION ALL */

SELECT 
    canal,
    SUM (total) AS total_canal
FROM (
   SELECT
      fecha_venta,
      (cantidad * precio_unitario) AS total,
      'Online' AS canal
   FROM ventas
   WHERE id_venta <=5

   UNION ALL

   SELECT 
    fecha_venta,
    (cantidad * precio_unitario) AS total,
    'Presencial'AS canal
  FROM ventas
  WHERE id_venta > 5
 ) AS consolidado
 GROUP BY canal;

