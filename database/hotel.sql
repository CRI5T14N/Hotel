create database Hotel;
DROP DATABASE HOTEL;
use Hotel;
show tables;

CREATE TABLE tabla_cliente (
	`idCliente` INT PRIMARY KEY AUTO_INCREMENT,
    `userNameCliente` varchar(20) NOT NULL,
    `nombreCliente` varchar(50) NOT NULL,
    `email` varchar(30) NOT NULL,
    `password` VARCHAR(100) NOT NULL,
    `numTarjetaCredito` VARCHAR(100) NOT NULL,
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE tabla_recepcionista (
	`idRecepcionista` INT PRIMARY KEY AUTO_INCREMENT,
    `userNameRecep` varchar(20) NOT NULL,
    `nombreRecepcionista` varchar(50) NOT NULL,
    `email` varchar(30) NOT NULL,
    `password` VARCHAR(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE tabla_admin (
	`idAdmin` INT PRIMARY KEY AUTO_INCREMENT,
    `userNameAdmin` varchar(20) NOT NULL,
    `nombreRecepcionista` varchar(50) NOT NULL,
    `email` varchar(30) NOT NULL,
    `password` VARCHAR(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE tabla_ama (
	`idAma` INT PRIMARY KEY AUTO_INCREMENT,
    `userNameAma` varchar(20) NOT NULL,
    `nombreAma` varchar(50) NOT NULL,
    `email` varchar(30) NOT NULL,
    `password` VARCHAR(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO tabla_cliente
	(userNameCliente, nombreCliente, email, password)
	VALUES
	('CR15T14N', 'Cristián Rivera', 'cristian@gmail.com', '123456');

CREATE TABLE tabla_reserva (
	`id_Reserva` INT PRIMARY KEY AUTO_INCREMENT,
    `id_Cliente` int (10) NOT NULL,
    CONSTRAINT fk_cliente FOREIGN KEY (id_Cliente) REFERENCES tabla_cliente(idCliente)
)  ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO tabla_reserva
	(id_Cliente)
    VALUES
    (1),
    (2);
SELECT * FROM tabla_reserva;

CREATE TABLE tabla_reserva_habitacion (
	`id_Reserva_Habitacion` INT PRIMARY KEY AUTO_INCREMENT,
    `id_Habitacion` int (10) NOT NULL,
    `id_Reserva` int (10) NOT NULL,
    `fecha_reservación` timestamp NOT NULL DEFAULT current_timestamp,
    `fecha_Entrada` datetime NOT NULL,
    `fecha_Salida` datetime NOT NULL,
    `cantidad_Huespedes` int NOT NULL,
    CONSTRAINT fk_Habitacion FOREIGN KEY (id_Habitacion) REFERENCES tabla_habitacion(id_Habitacion),
    CONSTRAINT fk_Reserva FOREIGN KEY (id_Reserva) REFERENCES tabla_reserva(id_Reserva)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO tabla_reserva_habitacion
	(id_Habitacion, id_Reserva, fecha_reservación, fecha_Entrada, fecha_Salida, cantidad_Huespedes, Total)
    VALUES
    (3, 1, now(), '2021-10-10 00:00:00', '2021-10-15 00:00:00', 3, 500),
    (1, 2, now(), '2021-10-12 00:00:00', '2021-10-14 00:00:00', 1, 200);

CREATE TABLE tabla_habitacion (
	`id_Habitacion` INT PRIMARY KEY AUTO_INCREMENT,
    `tipo_Habitacion` VARCHAR(20) NOT NULL,
    `precio_Normal` INT(10) NOT NULL,
    `precio_Weekend` INT(10) NOT NULL,
    `precio_Especial` INT(10) NOT NULL,
	`estado` INT(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO tabla_habitacion 
	(tipo_habitacion, precio_Normal, precio_Weekend, precio_Especial)
    VALUES
    ('Simple', 100, 150, 175),
    ('Doble', 150, 160, 180),
    ('Triple', 200, 225, 250);
    
INSERT INTO tabla_habitacion 
	(tipo_habitacion, precio_Normal, precio_Weekend, precio_Especial, estado)
    VALUES
    ('Simple', 100, 150, 175, 1);