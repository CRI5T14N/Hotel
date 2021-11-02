const passport = require('passport');
const LocalStrategy = require('passport-local').Strategy;
const pool = require('../database');
const helpers = require('../lib/helpers');

passport.use('local.signup', new LocalStrategy({
    usernameField: 'email',
    passwordField: 'password',
    passReqToCallback: true
}, async (req, email, password, done) => {
    const { nombreCliente, userNameCliente } = req.body;
    const newUser = {
        nombreCliente,
        userNameCliente,
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
