const express = require('express');
const router = express.Router();
const passport = require('passport');
const { isLoggedIn, isNotLoggedIn } = require('../lib/redirect');

router.get('/registro', isNotLoggedIn, (req, res) => {
    res.render('user/checkin');
});


router.post('/registro', isNotLoggedIn, passport.authenticate('local.signup', {
    successRedirect: '/profile',
    failureRedirect: '/registro'
}));

router.get('/profile', isLoggedIn, (req, res) => {
    res.render('profile');
});


router.get('/login', isNotLoggedIn, (req, res) => {
    res.render('user/login');
});

router.post('/login', isNotLoggedIn, (req, res, next) => {
    passport.authenticate('local.signin', {
        successRedirect: '/reservas',
        failureRedirect: '/login',
        failureFlash: true
    })(req, res, next);
});





router.get('/registrar-usuario', (req, res) => {
    res.render('user/admin-checkin');
});

/*router.post('/registrar-usuario', passport.authenticate('local.signup', {
    successRedirect: '/profile',
    failureRedirect: '/registrar-usuario'
}));*/

/*router.post('/registrar-usuario', passport.authenticate('local.signup', {
    successRedirect: '/profile',
    failureRedirect: '/signup'
}));*/

router.get('/logout', isLoggedIn, (req, res) => {
    req.logOut();
    res.redirect('/login');
});

module.exports = router;