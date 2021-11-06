const express = require('express');
const router = express.Router();
const pool = require('../database');
const { isLoggedIn } = require('../lib/redirect');

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
});


router.post('/reservar', isLoggedIn, (req, res) => {
    const { id, img1, img2, estado } = req.body;
    if (estado == 1) {
        const datos = { id, img1, img2};
        res.render('reservas/add', {datos});
    } else {
        res.render('reservas/disponible');
    }
    
});

//Reservar
router.post('/agregada', isLoggedIn, async (req, res) => {
    const { id_Habitacion, fecha_entrada, fecha_salida, id_Vehiculo, fecha_entrega, fecha_devolucion, dias_v, id_Desayuno, fecha_Desayuno,
        hora_Desayuno, cantidad_Desayuno, id_Servicio, fecha_servicio, hora_servicio, id_traslado, cantidad_personas, fecha_traslado, hora_traslado } = req.body;

    const newReserva = {
        id_Cliente: req.user.idCliente
    };

    const reserva = await pool.query('INSERT INTO tabla_reserva SET ?', [newReserva]);
    id_Reserva = reserva.insertId;
    
    const newReservaH = { id_Reserva, id_Habitacion, fecha_entrada, fecha_salida };

    const newReservaV = { id_Reserva, id_Vehiculo, fecha_entrega, fecha_devolucion, dias_v };

    const newDesayuno = { id_Reserva, id_Desayuno, fecha_Desayuno, hora_Desayuno, cantidad_Desayuno };
    
    const newServicio = { id_Reserva, id_Servicio, fecha_servicio, hora_servicio };

    const newTraslado = { id_Reserva, id_traslado, cantidad_personas, fecha_traslado, hora_traslado };

    const reserva_hab = await pool.query('INSERT INTO tabla_reserva_habitacion SET ?', [newReservaH]);
    const update = await pool.query('UPDATE tabla_habitacion set estado = 2 WHERE id_habitacion = ?', [id_Habitacion]);

    if ( id_Vehiculo != 0 ) {
        const reserva_v = await pool.query('INSERT INTO tabla_rentar_vehiculo SET ?', [newReservaV]);
    }

    if ( id_Desayuno != 0 ) {
        const d = await pool.query('INSERT INTO tabla_reserva_desayuno SET ?', [newDesayuno]);
    }
    
    if ( id_Servicio != 0 ) {
        const s = await pool.query('INSERT INTO tabla_reserva_servicio SET ?', [newServicio]);
    }

    if ( id_traslado != 0 ) {
        const t = await pool.query('INSERT INTO tabla_reserva_traslado SET ?', [newTraslado]);
    }

    res.render('reservas/reservada');
});

router.get('/editar/:id_Reserva', isLoggedIn, async (req, res) => {
    const { id_Reserva } = req.params;
    const result = await pool.query('SELECT * FROM vista_reserva WHERE id_Reserva = ?', [id_Reserva]);
    datos = result[0];
    console.log(result);
    res.render('reservas/edit', {datos});
});

/*router.post('/editar', isLoggedIn, async (req, res) => {
    const { id_Reserva } = req.body;
    const result = await pool.query('SELECT * FROM vista_reserva WHERE id_Reserva = ?', [id_Reserva]);
    datos = result[0];
    console.log(datos);
    res.render('reservas/edit', {datos});
});*/

module.exports = router;