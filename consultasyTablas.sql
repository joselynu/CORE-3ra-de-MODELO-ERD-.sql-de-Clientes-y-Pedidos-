----------------------------------------------------------------------
------------------------------------------------------------------------
-------------------------------------------------------------------------------
--Le comparto los querys más las tablas, como no pude instalar mysql developer
--usé mysql con XAMPP, entonces tuve que crear las tablas  a mano, de 
--paso, también le comparto el modelo ERD




--tablas

CREATE TABLE clientes(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(45),
    direccion VARCHAR(200),
    telefono INT
    );
    
CREATE TABLE pedidos(
    id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT,
    fecha DATE,
    total DECIMAL(10,2),
    FOREIGN KEY  (cliente_id) REFERENCES clientes(id)
    );

-------------------QUERYS--------------------------------------------
--1) inserción de datos, 5 nuevos clientes 

INSERT INTO clientes (nombre, direccion, telefono) VALUES
('Carlos Medina', 'Av Puerto Yunhgay', 99883338),
('Manolo Mirto', 'Av Siempre Viva', 99445338),
('Dayana Bella' , 'Av Santa Maria', 97783838),
('Karin Mellano', 'Av Lexintong', 99285537),
('Daniel Regio', 'Av Vodskov', 97883138);


--2)Aquí son 10 inserciones de nuevos pedidos
INSERT INTO pedidos (cliente_id, fecha, total) VALUES
(1, '2025-11-11', 15000),
(2, '2025-02-21', 25000),
(3, '2025-03-13', 32000),
(4, '2025-04-16', 28000),
(5, '2025-04-22', 13000),
(5, '2025-01-08', 20000),
(5, '2025-12-18', 9000),
(3, '2025-01-12', 45000),
(2, '2025-02-11', 80000),
(2, '2025-03-01', 70000);


-------------- las otras peticiones de query ------------------------
/*
3)Proyecta todos los clientes de la tabla «clientes» y 
sus respectivos pedidos.
*/

SELECT * FROM  clientes JOIN pedidos ON clientes.id = pedidos.cliente_id;



/*
4)Proyecta todos los pedidos realizados por un cliente específico, utilizando su ID.
*/

SELECT pedidos.id AS "ID PEDIDO", pedidos.fecha AS "FECHA", pedidos.total AS "MONTO TOTAL DEL PEDIDO" FROM pedidos WHERE pedidos.cliente_id = 5;


/*
5)Calcula el total de todos los pedidos para cada cliente.
*/

SELECT clientes.id, clientes.nombre, SUM(pedidos.total) AS "TOTAL DE PEDIDOS"
FROM clientes 
JOIN pedidos  ON clientes.id = pedidos.cliente_id
GROUP BY clientes.id, clientes.nombre;



/*
6)Elimina un cliente específico de la tabla «clientes» y todos sus pedidos asociados de la tabla «pedidos».
*/
--eliminamos el peido y luego el cliente sino se puede
DELETE FROM pedidos WHERE cliente_id = 3;
DELETE FROM clientes WHERE id=3;



/*
7)Proyecta los tres clientes que han realizado más pedidos, ordenados de forma descendente por el número de pedidos.
*/

SELECT clientes.id AS "CLIENTES", clientes.nombre AS "NOMBRE DE CLIENTES", COUNT(pedidos.id) AS "CANTIDAD DE PEDIDOS"
FROM clientes 
JOIN pedidos ON clientes.id = pedidos.cliente_id
GROUP BY  clientes.id, clientes.nombre
ORDER BY "CANTIDAD DE PEDIDOS" DESC
LIMIT 3;



