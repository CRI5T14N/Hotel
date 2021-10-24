const passport = require('passport');
const LocalStrategy = require('passport-local').Strategy;
const pool = require('../database');
const helpers = require('../lib/helpers');

passport.use('local.signup', new LocalStrategy({
    emailField: 'email',
    passwordField: 'password',
    passReqToCallback: true
}, async (req, email, password, done) => {
    const { fullname, username } = req.body;
    const newUser = {
        fullname,
        username,
        email,
        password
    };
    newUser.password = await helpers.encryptPassword(password);
    const result = await pool.query('INSERT INTO tabla_cliente SET ?', [newUser]);
    newUser.id = result.insertId;
    return done(null, newUser);
}));

passport.serializeUser((cliente, done) => {
    done(null, cliente.id);
});

passport.deserializeUser(async (id, done) => {
    const rows = await pool.query('SELECT * FROM tabla_cliente WHERE idcliente = ?', [id]);
    done(null, rows[0]);
});
