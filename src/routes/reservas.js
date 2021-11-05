const express = require('express');
const router = express.Router();
const pool = require('../database');

router.get('/', async (req, res) => {
    const reservas = await pool.query('SELECT * FROM tabla_reserva ORDER BY id_Reserva');
    res.render('user/reservas', {reservas});
});




module.exports = router;