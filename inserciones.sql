INSERT INTO Clientes (nombre , email , telefono, fecha_registro) VALUES ("Jose Manuel Sanchez", "Manuelosma2011@gmail.com", "2938293", "2024/07/23");
INSERT INTO Clientes (nombre , email , telefono, fecha_registro) VALUES ("Sandra Milena", "MilenaOsma@gmail.com", "2938293", "2024/07/23");

INSERT INTO Habitaciones (numero_habitacion, tipo, precio_por_noche, estado) VALUES ('101', 'Individual', 50.00, 'Disponible');
INSERT INTO Habitaciones (numero_habitacion, tipo, precio_por_noche, estado) VALUES ('102', 'Doble', 80.00, 'Disponible');
INSERT INTO Habitaciones (numero_habitacion, tipo, precio_por_noche, estado) VALUES ('103', 'Suite', 150.00, 'Disponible');
INSERT INTO Habitaciones (numero_habitacion, tipo, precio_por_noche, estado) VALUES ('104', 'Doble Suite', 80.00, 'Ocupada');



-- consulta las reservas
SELECT r.reserva_id , h.numero_habitacion , r.fecha_inicio, r.fecha_fin , r.monto_total , r.estado
FROM Reservas r
JOIN Habitaciones h ON r.habitacion_id = h.habitacion_id
WHERE r.cliente_id = (SELECT cliente_id FROM Clientes WHERE email = 'Manuelosma2011@gmail.com');



-- consultar ocupacion de habitaciones

SELECT h.tipo , h.estado , COUNT(*) AS numero_habitaciones
FROM habitaciones h
GROUP BY h.tipo, h.estado


-- consultar reservas por mes y año 

SELECT YEAR(r.fecha_inicio) AS anio, MONTH(r.fecha_inicio) AS mes , COUNT(*) AS numero_reservas, SUM(r.monto_total) AS ingresos
FROM Reservas r
WHERE r.estado = 'Completa'
GROUP BY YEAR(r.fecha_inicio), MONTH(r.fecha_inicio)
ORDER BY anio, mes




START TRANSACTION;

CALL CrearReserva(2,2,"2024/07/24", "2024/07/25");

SET @reserva_id = LAST_INSERT_ID();

INSERT INTO pagos (reserva_id, monto, fecha_pago, metodo_pago)
VALUES (@reserva_id, (SELECT monto_total FROM reservas WHERE reserva_id = @reserva_id), CURDATE(), 'Tarjeta');

COMMIT;

-- otra transacion

START TRANSACTION;

CALL CrearReserva(1,3,"2024/08/24", "2024/08/25");

SET @reserva_id = LAST_INSERT_ID();

INSERT INTO pagos (reserva_id, monto, fecha_pago, metodo_pago)
VALUES (@reserva_id, (SELECT monto_total FROM reservas WHERE reserva_id = @reserva_id), CURDATE(), 'Efectivo');

COMMIT;

SELECT * FROM clientes 
SELECT * FROM habitaciones 
SELECT * FROM reservas

-- consulta las reservas y pagos de un cliente


SELECT c.nombre, r.reserva_id, h.numero_habitacion, r.fecha_inicio, r.fecha_fin, r.monto_total, p.monto, p.fecha_pago, h.estado
FROM clientes c
JOIN reservas r ON c.cliente_id = r.cliente_id
JOIN habitaciones h ON r.habitacion_id = h.habitacion_id
LEFT JOIN pagos p ON r.reserva_id = p.reserva_id
WHERE c.cliente_id = 1


-- liberar habitacion
CALL liberarHabitacion(3);
-- si esta ocupada la habitacion
CALL CrearReserva(1,3,"2024/08/24", "2024/08/25");




