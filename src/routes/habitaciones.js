const express = require('express');
const router = express.Router();
const pool = require('../database');

//Habitaciones
router.get('/', (req, res) => {
    res.render('reservas/rooms');
});

module.exports = router;