const express = require('express');
const router = express.Router();
const pool = require('../database')

router.get('/add', async (req, res) => {
    console.log(CI);
    
    const persona = await pool.query(
        "select id_persona, ap_paterno, ap_materno, nombre from persona where CI = ?;", [CI]
      )
        res.render('persona/add', {persona})

});


module.exports = router;

    // diaActual = new Date();

    // var day = diaActual.getDate();
    // var month = diaActual.getMonth() + 1;
    // var year = diaActual.getFullYear();

    // fecha = year + '/' + month + '/' + day;
    // console.log(fecha);
    // res.render('sintomas/add', { fecha })