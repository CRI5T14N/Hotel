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
    const habs = await pool.query('SELECT * FROM tabla_habitacion WHERE id_habitacion = ?', [idhab]);
    const h = habs[0];
    const tipo = await pool.query('SELECT * FROM tabla_tipo_habitacion WHERE id_tipo = ?', [h.id_tipo_habitacion]);
    res.render('reservas/room-info', { h, tipo: tipo[0] });
});

module.exports = router;