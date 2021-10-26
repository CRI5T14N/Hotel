create database Hotel;
use Hotel;
show tables;

CREATE TABLE tabla_cliente (
	`idCliente` INT PRIMARY KEY AUTO_INCREMENT,
    `userNameCliente` varchar(20) NOT NULL,
    `nombreCliente` varchar(50) NOT NULL,
    `email` varchar(30) NOT NULL,
    `password` VARCHAR(100) NOT NULL,
    `numTarjetaCredito` VARCHAR(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE tabla_reserva (
	`id_Reserva` INT PRIMARY KEY AUTO_INCREMENT,
    `id_Cliente` int (10) NOT NULL,
    CONSTRAINT fk_cliente FOREIGN KEY (id_Cliente) REFERENCES tabla_cliente(idCliente)
)  ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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

CREATE TABLE tabla_habitacion (
	`id_Habitacion` INT PRIMARY KEY AUTO_INCREMENT,
    `precio_Normal` INT(10) NOT NULL,
    `precio_Weekend` INT(10) NOT NULL,
    `precio_Especial` INT(10) NOT NULL,
	`url_img1` VARCHAR(50) NOT NULL,
    `url_img2` VARCHAR(50) NOT NULL,
    `estado` INT(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE tabla_habitacion
	ADD COLUMN id_tipo_habitacion INT(10) NOT NULL;

CREATE TABLE tabla_tipo_habitacion (
	id_tipo INT PRIMARY KEY AUTO_INCREMENT,
    tipo_habitacion VARCHAR(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE VIEW Vista_Habitacion AS
SELECT id_habitacion, precio_normal, precio_weekend, precio_especial, url_img1, url_img2, estado, tipo_habitacion
FROM tabla_habitacion as th
INNER JOIN tabla_tipo_habitacion as tph
ON th.id_tipo_habitacion = tph.id_tipo;

SELECT * FROM vista_habitacion;