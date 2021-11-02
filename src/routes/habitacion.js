const express = require('express');
const router = express.Router();
const pool = require('../database');

//Información Habitación
router.post('/', async (req, res) => {
    const { idhab } = req.body;
    const habs = await pool.query('SELECT * FROM vista_habitacion WHERE id_habitacion = ?', [idhab]);
    res.render('reservas/room-info', { habs: habs[0] });
    console.log(habs[0]);
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
    const { id_Habitacion, fecha_entrada, fecha_salida } = req.body;
    const id_Cliente = 3;
    const newReserva = {
        id_Cliente
    };

    const reserva = await pool.query('INSERT INTO tabla_reserva SET ?', [newReserva]);
    id_Reserva = reserva.insertId;
    console.log(reserva);
    const newReservas = {
        id_Reserva,
        id_Habitacion,
        fecha_entrada,
        fecha_salida
    };
    console.log(newReservas);
    const reserva_hab = await pool.query('INSERT INTO tabla_reserva_habitacion SET ?', [newReservas]);
    
    res.render('reservas/reservada');
});

router.get('/editar', (req, res) => {
    res.render('reservas/edit')
});

module.exports = router;