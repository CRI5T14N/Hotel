const passport = require('passport');
const LocalStrategy = require('passport-local').Strategy;
const pool = require('../database');
const helpers = require('../lib/helpers');


passport.use('local.signin', new LocalStrategy({
    usernameField: 'email',
    passwordField: 'password',
    passReqToCallback: true
}, async (req, email, password, done) => {
    const rows = await pool.query('SELECT * FROM tabla_cliente WHERE email = ?', [email]);
    if(rows.length > 0) {
        const cliente = rows[0];
        const validPassword = await helpers.matchPassword(password, cliente.password);
        if (validPassword) {
            done(null, cliente, req.flash('success', 'Welcome ' + cliente.nombreCliente));
        } else {
            done(null, false, req.flash('message', 'Email o Contraseña Incorrectos'));
        }
    } else {
        return done(null, false, req.flash('message', 'Email o Contraseña Incorrectos'));
    }
}));



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
    newUser.idCliente = result.insertId;
    return done(null, newUser);
}));

passport.serializeUser((cliente, done) => {
    done(null, cliente.idCliente);
});

passport.deserializeUser(async (idCliente, done) => {
    const rows = await pool.query('SELECT * FROM tabla_cliente WHERE idCliente = ?', [idCliente]);
    done(null, rows[0]);
});
