const express = require('express');
const router = express.Router();
const pool = require('../database');


router.get('/', async (req, res) => {
    const links = await pool.query('SELECT * FROM tabla_reserva');
    console.log(links);
    res.send('Simon');
});



module.exports = router;