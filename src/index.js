const express = require('express');
const morgan = require('morgan');
const exphbs = require('express-handlebars');
const path = require('path');
const session = require('express-session');
const MySQLStore = require('express-mysql-session');
const passport = require('passport');

//Initializations

const app = express();
require('./lib/passport');
//require('./lib/passportuser');

//Settings

app.set('port', process.env.PORT || 4000);
app.set('views', path.join(__dirname, 'views'));
app.engine('.hbs', exphbs({
    defaultLayout: 'main',
    layoutsDir: path.join(app.get('views'), 'layouts'),
    partialsDir: path.join(app.get('views'), 'partials'),
    extname: '.hbs',
    helpers: require('./lib/handlebars')
}));
app.set('view engine', '.hbs');

//Middlewares

app.use(morgan('dev'));
app.use(express.urlencoded({extended: false}));
app.use(express.json());
app.use(passport.initialize());
//app.use(passport.session());

//Global Variables

app.use((req, res, next) => {
    next();
});

//Routes

app.use(require('./routes'));
app.use(require('./routes/authentication'));
app.use('/reservaciones', require('./routes/reservaciones'));
app.use('/habitaciones', require('./routes/habitaciones'));
app.use('/habitacion', require('./routes/habitacion'));

//Public

app.use(express.static(path.join(__dirname, 'public')));

//Starting the Server

app.listen(app.get('port'), () => {
    console.log('Server on port', app.get('port'));
});