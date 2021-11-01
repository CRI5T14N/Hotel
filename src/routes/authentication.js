const express = require('express');
const router = express.Router();
const passport = require('passport');

router.get('/registro', (req, res) => {
    res.render('user/checkin');
});


router.post('/registro', passport.authenticate('local.signup', {
    successRedirect: '/profile',
    failureRedirect: '/registro'
}));

router.get('/profile', (req, res) => {
    res.send('Profile');
});

router.get('/login', (req, res) => {
    res.render('user/login');
});

router.get('/registrar-usuario', (req, res) => {
    res.render('user/admin-checkin');
});

router.post('/registrar-usuario', passport.authenticate('local.signup', {
    successRedirect: '/profile',
    failureRedirect: '/registrar-usuario'
}));

/*router.post('/registrar-usuario', passport.authenticate('local.signup', {
    successRedirect: '/profile',
    failureRedirect: '/signup'
}));*/

module.exports = router;