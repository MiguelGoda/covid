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
    const persona = await pool.query("SELECT tipo_persona.id_tipo_persona, tipo_persona.nombre_tipo_persona, P.id_persona , CONCAT(P.nombre, ' ', P.ap_paterno, ' ', P.ap_materno) as nombre_completo  FROM tipo_persona RIGHT JOIN persona P ON tipo_persona.id_tipo_persona = P.id_tipo_persona where P.id_tipo_persona = 2;");

    const tipo_usuario = await pool.query("SELECT id_tipo_usuario, nombre_tipo_usuario from tipo_usuario;")
    res.render('auth/signup', {persona, tipo_usuario})
})

router.post('/signup', passport.authenticate('local.signup', {
    successRedirect: '/persona',
    failureRedirect: '/signup',
    failureFlash: true
}));

module.exports = router;