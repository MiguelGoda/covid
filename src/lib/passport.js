const passport = require('passport');
const LocalStrategy =  require('passport-local').Strategy;

const pool = require('../database');
const helpers = require('./helpers');

passport.use('local.signin', new LocalStrategy ({
    usernameField: 'username',
    passwordField: 'password',
    passReqToCallback: true
}, async(req, username, password, done) => {
    console.log(req.body);
    
    const rows = await pool.query('SELECT * FROM usuarios WHERE username = ?', [username]);
    if (rows.length > 0) {
        const usuario = rows[0];
        const validPassword = await helpers.matchPassword(password, usuario.password)
        if (validPassword) {
            done(null, usuario, req.flash('success', 'Bienvenido ' + usuario.username));
        } else {
            done(null, false, req.flash('message' ,'Contraseña incorrecta'))
        }
    } else {
        return done(null, false, req.flash('message', 'Usuario no existe'))
    }
    
    
    
}));


passport.use('local.signup', new LocalStrategy({
  usernameField: 'username',
  passwordField: 'password',
  passReqToCallback: true
}, async (req, username, password, done) => {
    const {id_persona, id_tipo_usuario} = req.body;
    let newUser = {
        id_tipo_usuario,
        username,
        password,
        id_persona 
    };

    newUser.password = await helpers.encryptPassword(password);
    // Saving in the Database
    const result = await pool.query('INSERT INTO usuarios set ?', [newUser])
    newUser.id_usuario = result.insertId;
    return done(null, newUser)
    
}));

passport.serializeUser((usuarios, done) => {
    done(null, usuarios.id_usuario);
});

passport.deserializeUser( async (id_usuario,done) =>{
    const rows = await pool.query('SELECT * FROM usuarios WHERE id_usuario = ?', [id_usuario]);
    done(null, rows[0]);
});

