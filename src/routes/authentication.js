const express = require('express');
const router = express.Router();
const pool = require('../database');

const passport = require('passport');
 
router.get('/signin', (req,res) => {
    res.render('auth/signin')
})

router.post('/signin', (req, res, next) =>{
    passport.authenticate('local.signin', {
        successRedirect: '/persona',
        failureRedirect: '/signin',
        failureFlash: true
    })(req, res, next)
})

router.get('/signup', async (req, res) => {
    const persona = await pool.query("SELECT * FROM covid.v_registrar_usuarios where id_tipo_persona = 2;");

    const tipo_usuario = await pool.query("SELECT id_tipo_usuario, nombre_tipo_usuario from tipo_usuario;")
    res.render('auth/signup', {persona, tipo_usuario})
})

router.post('/signup', passport.authenticate('local.signup', {
    successRedirect: '/persona',
    failureRedirect: '/signup',
    failureFlash: true
}));

module.exports = router;