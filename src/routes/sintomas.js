const express = require('express');
const router = express.Router();
const pool = require('../database')

router.get('/add', (req, res) => {
    

    diaActual = new Date();

    var day = diaActual.getDate();
    var month = diaActual.getMonth() + 1;
    var year = diaActual.getFullYear();

    fecha = year + '/' + month + '/' + day;
    console.log(fecha);
    res.render('sintomas/add', { fecha })
});


module.exports = router;