/*const passport = require('passport');
const LocalStrategy = require('passport-local').Strategy;
const pool = require('../database');
const helpers = require('../lib/helpers');

passport.use('local.signup', new LocalStrategy({
    usernameField: 'email',
    passwordField: 'password',
    passReqToCallback: true
}, async (req, email, password, done) => {
    const { nombreUsuario, userNameUsuario, usuario } = req.body;
    const newUser = {
        nombreUsuario,
        userNameUsuario,
        email,
        password
    };
    newUser.password = await helpers.encryptPassword(password);
    if (usuario == 2) {
        const result = await pool.query('INSERT INTO tabla_recepcionista SET ?', [newUser]);
        newUser.id = result.insertId;
    } else if (usuario == 3 ) {
        const result = await pool.query('INSERT INTO tabla_ama SET ?', [newUser]);
        newUser.id = result.insertId;
    } else if (usuario == 4 ) {
        const result = await pool.query('INSERT INTO tabla_admin SET ?', [newUser]);
        newUser.id = result.insertId;
    }
    return done(null, newUser);
}));

passport.serializeUser((cliente, done) => {
    done(null, cliente.id);
});

passport.deserializeUser(async (id, done) => {
    const rows = await pool.query('SELECT * FROM tabla_cliente WHERE idcliente = ?', [id]);
    done(null, rows[0]);
});
*/