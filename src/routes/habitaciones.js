const express = require('express');
const router = express.Router();
const pool = require('../database');

//Habitaciones
router.get('/', (req, res) => {
    res.render('reservas/rooms');
})

//Información Habitación
router.post('/habitacion', async (req, res) => {
    const { idhab } = req.body;
    const habs = await pool.query('SELECT * FROM vista_habitacion WHERE id_habitacion = ?', [idhab]);
    res.render('reservas/room-info', { habs: habs[0] });
    console.log(habs[0]);
});

module.exports = router;