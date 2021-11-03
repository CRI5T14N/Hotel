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
    `numTarjetaCredito` VARCHAR(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE tabla_reserva (
	`id_Reserva` INT PRIMARY KEY AUTO_INCREMENT,
    `id_Cliente` int (10) NOT NULL,
    CONSTRAINT fk_cliente FOREIGN KEY (id_Cliente) REFERENCES tabla_cliente(idCliente)
)  ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO tabla_reserva
	(id_Cliente)
    VALUES (3), (2), (1), (4);

SELECT * FROM tabla_reserva ORDER BY id_Reserva;

SELECT id_Reserva, nombreCliente FROM tabla_cliente as tc
INNER JOIN tabla_reserva as tr
ON tc.idCliente = tr.id_Cliente ORDER BY id_Reserva;

CREATE TABLE tabla_tipo_habitacion (
	id_tipo INT PRIMARY KEY AUTO_INCREMENT,
    tipo_habitacion VARCHAR(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE tabla_habitacion (
	`id_Habitacion` INT PRIMARY KEY AUTO_INCREMENT,
    `id_tipo_habitacion` INT(10) NOT NULL,
    `precio_Normal` INT(10) NOT NULL,
    `precio_Weekend` INT(10) NOT NULL,
    `precio_Especial` INT(10) NOT NULL,
	`url_img1` VARCHAR(50) NOT NULL,
    `url_img2` VARCHAR(50) NOT NULL,
    `estado` INT(1) NOT NULL,
    CONSTRAINT fk_tipo_habitacion FOREIGN KEY (id_tipo_habitacion) REFERENCES tabla_tipo_habitacion(id_tipo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO tabla_tipo_habitacion
	(tipo_habitacion)
    VALUES
    ('Simple'),
    ('Doble'),
    ('Triple'),
    ('Cuádruple');

INSERT INTO tabla_habitacion 
	(id_tipo_habitacion, precio_Normal, precio_Weekend, precio_Especial, url_img1, url_img2, estado)
    VALUES
    (1, 100, 150, 175, '/img/simple1.jpg', '/img/simple1-1.jpg', 1),
    (1, 150, 200, 250, '/img/simple2.jpg', '/img/simple2.jpg', 1),
    (1, 170, 180, 210, '/img/simple3.jpg', '/img/simple3.jpg', 1),
    (2, 250, 300, 325, '/img/doble1.jpg', '/img/doble1.jpg', 1),
    (2, 230, 315, 340, '/img/doble2.jpg', '/img/doble2.jpg', 1),
    (2, 275, 350, 375, '/img/doble3.jpg', '/img/doble3.jpg', 1),
    (3, 300, 350, 375, '/img/triples1.jpg', '/img/triples1', 1),
    (3, 315, 360, 390, '/img/triples2.jpg', '/img/triples2', 1),
    (3, 330, 350, 375, '/img/triples3.jpg', '/img/triples3', 1),
    (4, 400, 430, 450, '/img/cuadruple1.jpg', '/img/cuadruple1.jpg', 1),
    (4, 450, 470, 490, '/img/cuadruple2.jpg', '/img/cuadruple2.jpg', 1),
    (4, 475, 480, 500, '/img/cuadruple3.jpg', '/img/cuadruple3.jpg', 1);

CREATE VIEW Vista_Habitacion AS
SELECT id_habitacion, precio_normal, precio_weekend, precio_especial, url_img1, url_img2, estado, tipo_habitacion
FROM tabla_habitacion as th
INNER JOIN tabla_tipo_habitacion as tph
ON th.id_tipo_habitacion = tph.id_tipo;

SELECT * FROM vista_habitacion;
DROP VIEW vista_habitacion;

SELECT * FROM tabla_reserva_habitacion;
CREATE TABLE tabla_reserva_habitacion (
	`id_Reserva_Habitacion` INT PRIMARY KEY AUTO_INCREMENT,
    `id_Habitacion` int (10) NOT NULL,
    `id_Reserva` int (10) NOT NULL,
    `fecha_reservacion` timestamp NOT NULL DEFAULT current_timestamp,
    `fecha_entrada` datetime NOT NULL,
    `fecha_salida` datetime NOT NULL,
    CONSTRAINT fk_Habitacion FOREIGN KEY (id_Habitacion) REFERENCES tabla_habitacion(id_Habitacion),
    CONSTRAINT fk_Reserva FOREIGN KEY (id_Reserva) REFERENCES tabla_reserva(id_Reserva)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE tabla_vehiculo (
	id_Vehiculo INT PRIMARY KEY AUTO_INCREMENT,
    tipo_Vehiculo VARCHAR(30) NOT NULL,
    precio_hora FLOAT NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO tabla_vehiculo
	(tipo_Vehiculo, precio_hora)
    VALUES
    ('BMW', 150),
    ('KIA PICANTO', 130),
    ('Toyota', 200),
    ('Audi', 150);

CREATE TABLE tabla_rentar_vehiculo (
	id_Rentar_Vehiculo INT PRIMARY KEY AUTO_INCREMENT,
    id_Reserva INT NOT NULL,
    id_Vehiculo INT NOT NULL,
    fecha_entrega DATETIME NOT NULL,
    fecha_devolucion DATETIME NOT NULL,
    dias_v INT NOT NULL,
    CONSTRAINT fk_ReservaV FOREIGN KEY (id_Reserva) REFERENCES tabla_reserva(id_Reserva),
    CONSTRAINT fk_Vehiculo FOREIGN KEY (id_Vehiculo) REFERENCES tabla_vehiculo(id_Vehiculo)
)ENGINE = InnoDB DEFAULT CHARSET=utf8mb4;