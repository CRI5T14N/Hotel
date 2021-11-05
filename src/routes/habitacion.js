const express = require('express');
const router = express.Router();
const pool = require('../database');

//Información Habitación
router.post('/', async (req, res) => {
    const { idhab } = req.body;
    const result = await pool.query('SELECT * FROM vista_habitacion WHERE id_habitacion = ?', [idhab]);
    const habs = result[0];
    let disp;
    if (habs.estado == 1) {
        disp = 'Disponible!';
    } else if (habs.estado == 2) {
        disp = 'No Disponible!'
    }
    habs.disp = disp;
    res.render('reservas/room-info', { habs: habs });
    console.log(habs);
});

router.get('/reservar', (req, res) => {
    res.render('reservas/add');
});

router.post('/reservar', (req, res) => {
    const { id, img1, img2 } = req.body;
    const datos = { id, img1, img2};
    res.render('reservas/add', {datos});
});

//Reservar
router.post('/agregada', async (req, res) => {
    const { id_Habitacion, fecha_entrada, fecha_salida, id_Vehiculo, fecha_entrega, fecha_devolucion, dias_v } = req.body;
    const id_Cliente = 2;
    const newReserva = {
        id_Cliente
    };

    const reserva = await pool.query('INSERT INTO tabla_reserva SET ?', [newReserva]);
    id_Reserva = reserva.insertId;
    const newReservaH = {
        id_Reserva,
        id_Habitacion,
        fecha_entrada,
        fecha_salida
    };
    const newReservaV = {
        id_Reserva,
        id_Vehiculo,
        fecha_entrega,
        fecha_devolucion,
        dias_v
    }
    
    const reserva_hab = await pool.query('INSERT INTO tabla_reserva_habitacion SET ?', [newReservaH]);
    const update = await pool.query('UPDATE tabla_habitacion set estado = 2 WHERE id_habitacion = ?', [id_Habitacion]);
    console.log(update)
    if( id_Vehiculo != 0 && fecha_entrada != '' && fecha_devolucion != '' && dias_v != '') {
        console.log(newReservaV);
        const reserva_v = await pool.query('INSERT INTO tabla_rentar_vehiculo SET ?', [newReservaV]);
    }
    
    res.render('reservas/reservada');
});

router.get('/editar/:id_Reserva', async (req, res) => {
    const { id_Reserva } = req.params;
    const result = await pool.query('SELECT * FROM vista_reserva_habitacion WHERE id_Reserva = ?', [id_Reserva]);
    datos = result[0];
    console.log(result);
    res.render('reservas/edit', {datos});
});

router.post('/editar', async (req, res) => {
    const { id_Reserva } = req.body;
    const result = await pool.query('SELECT * FROM vista_reserva WHERE id_Reserva = ?', [id_Reserva]);
    datos = result[0];
    console.log(datos);
    res.render('reservas/edit', {datos});
});

module.exports = router;