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
    `fecha_reservacion` timestamp NOT NULL DEFAULT current_timestamp,
    CONSTRAINT fk_cliente FOREIGN KEY (id_Cliente) REFERENCES tabla_cliente(idCliente)
)  ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

SELECT * FROM tabla_reserva ORDER BY id_Reserva;

SELECT id_Cliente, id_Reserva, nombreCliente FROM tabla_cliente as tc
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
    (3, 300, 350, 375, '/img/triples1.jpg', '/img/triples1.jpg', 1),
    (3, 315, 360, 390, '/img/triples2.jpg', '/img/triples2.jpg', 1),
    (3, 330, 350, 375, '/img/triples3.jpg', '/img/triples3.jpg', 1),
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

CREATE TABLE tabla_reserva_habitacion (
	`id_Reserva_Habitacion` INT PRIMARY KEY AUTO_INCREMENT,
    `id_Habitacion` int (10) NOT NULL,
    `id_Reserva` int (10) NOT NULL,
    `fecha_entrada` date NOT NULL,
    `fecha_salida` date NOT NULL,
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
    fecha_entrega DATE NOT NULL,
    fecha_devolucion DATE NOT NULL,
    dias_v INT NOT NULL,
    CONSTRAINT fk_ReservaV FOREIGN KEY (id_Reserva) REFERENCES tabla_reserva(id_Reserva),
    CONSTRAINT fk_Vehiculo FOREIGN KEY (id_Vehiculo) REFERENCES tabla_vehiculo(id_Vehiculo)
)ENGINE = InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE tabla_desayuno (
	`id_Desayuno` INT PRIMARY KEY AUTO_INCREMENT,
    `nombre_Desayuno` VARCHAR(30) NOT NULL,
    `precio_Desayuno` FLOAT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO tabla_desayuno
	(nombre_Desayuno, precio_Desayuno)
	VALUES
	('Panqueques', 100),
    ('Omelet', 50),
    ('Huevos', 75);

CREATE TABLE tabla_reserva_desayuno (
	`id_Reserva_Desayuno` INT PRIMARY KEY AUTO_INCREMENT,
    `id_Reserva` INT NOT NULL,
    `id_Desayuno` INT NOT NULL,
    `fecha_Desayuno` DATE NOT NULL,
    `hora_Desayuno` TIME NOT NULL,
    `cantidad_Desayuno` INT NOT NULL,
    CONSTRAINT fk_Desayuno FOREIGN KEY (id_Desayuno) REFERENCES tabla_desayuno(id_Desayuno),
    CONSTRAINT fk_Reservacion FOREIGN KEY (id_Reserva) REFERENCES tabla_Reserva(id_Reserva)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE tabla_Servicios (
	id_Servicio INT PRIMARY KEY AUTO_INCREMENT,
    tipo_Servicio VARCHAR(100) NOT NULL,
	precio_servicio FLOAT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO tabla_servicios
	(tipo_Servicio, precio_servicio)
    VALUES
    ('Lavado de Ropa', 100),
    ('Planchado de Ropa', 100);
    
CREATE TABLE tabla_reserva_servicio (
	id_reserva_servicio INT PRIMARY KEY AUTO_INCREMENT,
    id_Reserva INT NOT NULL,
    id_Servicio INT NOT NULL,
    fecha_servicio date NOT NULL,
    hora_servicio time NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE tabla_traslado (
	id_Traslado INT PRIMARY KEY AUTO_INCREMENT,
    lugar_origen VARCHAR(50) NOT NULL,
    lugar_destino VARCHAR(50) NOT NULL,
    precio_por_persona FLOAT NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO tabla_traslado
	(lugar_origen, lugar_destino, precio_por_persona)
    VALUES
    ('Aeropuerto', 'Hotel', 50),
    ('Hotel', 'Aeropuerto', 60);

CREATE TABLE tabla_reserva_traslado (
	id_reserva_traslado INT PRIMARY KEY AUTO_INCREMENT,
	id_reserva INT NOT NULL,
    id_traslado INT NOT NULL,
    cantidad_personas INT NOT NULL,
    fecha_traslado DATE NOT NULL,
    hora_traslado TIME NOT NULL,
	CONSTRAINT fk_reserva_traslado FOREIGN KEY (id_reserva) REFERENCES tabla_reserva(id_Reserva),
    CONSTRAINT fk_Traslado FOREIGN KEY (id_traslado) REFERENCES tabla_traslado(id_traslado)
) ENGINE = InnoDB DEFAULT CHARSET=utf8mb4;






CREATE VIEW vista_reserva AS 
SELECT tr.id_Reserva, fecha_Entrada, fecha_Salida, url_img1, url_img2, trv.id_Vehiculo, fecha_entrega, fecha_devolucion, dias_v, trd.id_Desayuno, cantidad_desayuno, fecha_desayuno, hora_Desayuno, id_Servicio, fecha_servicio, hora_servicio, id_traslado, fecha_traslado, hora_traslado, cantidad_personas FROM tabla_reserva AS tr
INNER JOIN tabla_reserva_habitacion AS trh
ON tr.id_Reserva = trh.id_Reserva
INNER JOIN tabla_habitacion AS th
ON trh.id_Habitacion = th.id_Habitacion
INNER JOIN tabla_rentar_vehiculo AS trv
ON tr.id_Reserva = trv.id_Reserva
INNER JOIN tabla_vehiculo AS tv
ON trv.id_Vehiculo = tv.id_Vehiculo
INNER JOIN tabla_reserva_desayuno AS trd
ON trd.id_Reserva = tr.id_Reserva
INNER JOIN tabla_desayuno AS td
ON td.id_Desayuno = trd.id_Desayuno
INNER JOIN tabla_reserva_servicio AS trs
ON trs.id_Reserva = tr.id_Reserva
INNER JOIN tabla_reserva_traslado AS trt
ON trt.id_Reserva = tr.id_Reserva;