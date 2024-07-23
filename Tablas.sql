USE HotelReservas

CREATE TABLE Clientes(
	cliente_id INT AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(100),
	email VARCHAR(100) UNIQUE,
	telefono VARCHAR(15),
	fecha_registro date
);

CREATE TABLE Habitaciones (
	habitacion_id INT AUTO_INCREMENT PRIMARY KEY,
	numero_habitacion VARCHAR(10) UNIQUE,
	tipo VARCHAR(50),
	precio_por_noche DECIMAL(10,2),
	estado VARCHAR(20) -- disponible , ocupada, mantenimiento
);

CREATE TABLE Reservas(
	reserva_id INT AUTO_INCREMENT PRIMARY KEY,
	cliente_id INT,
	habitacion_id INT,
	fecha_inicio DATE,
	fecha_fin DATE ,
	monto_total DECIMAL(10,2),
	estado VARCHAR(20),
	FOREIGN KEY (cliente_id) REFERENCES Clientes(cliente_id),
	FOREIGN KEY (habitacion_id) REFERENCES Habitaciones(habitacion_id)
);


CREATE TABLE pagos (
	pago_id INT AUTO_INCREMENT PRIMARY KEY,
	reserva_id INT ,
	monto DECIMAL (10,2),
	fecha_pago DATE,
	metodo_pago VARCHAR(50),
	FOREIGN KEY (reserva_id) REFERENCES Reservas(reserva_id)
);




SHOW tables