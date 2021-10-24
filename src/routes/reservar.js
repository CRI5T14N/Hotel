const express = require('express');
const router = express.Router();
const pool = require('../database');


router.get('/add', (req, res) => {
    res.render('reservas/add');
});

router.post('/add', (req, res) => {
    const { id, img1, img2 } = req.body;
    const datos = { id, img1, img2};
    res.render('reservas/add', {datos});
});


module.exports = router;