const express = require('express');
const router = express.Router();
const pool = require('../database');
const { isLoggedIn } = require('../lib/redirect')

router.get('/', isLoggedIn, async (req, res) => {
    const reservas = await pool.query('SELECT * FROM tabla_reserva WHERE id_Cliente = ? ORDER BY id_Reserva', [req.user.idCliente]);
    res.render('user/reservas', {reservas});
});




module.exports = router;