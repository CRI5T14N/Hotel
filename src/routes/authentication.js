const express = require('express');
const router = express.Router();
const passport = require('passport');

router.get('/signup', (req, res) => {
    res.render('user/checkin');
});


router.post('/signup', passport.authenticate('local.signup', {
    successRedirect: '/profile',
    failureRedirect: '/signup'
}));

router.get('/profile', (req, res) => {
    res.send('Profile');
});

router.get('/login', (req, res) => {
    res.render('user/login');
});

module.exports = router;