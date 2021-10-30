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

router.post('/agregada', async (req, res) => {
    const { id_Habitacion, fecha_entrada, fecha_salida } = req.body;
    const id_Reserva = 1;
    const newReserva = {
        id_Reserva,
        id_Habitacion,
        fecha_entrada,
        fecha_salida
    };
    const reserva_hab = await pool.query('INSERT INTO tabla_reserva_habitacion SET ?', newReserva);
    res.render('reservas/reservada');
    //Aquí Git
});


module.exports = router;