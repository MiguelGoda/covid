const express = require('express');
const router = express.Router();
const pool = require('../database')

router.get('/add', async (req, res) => {
    
    
    // const persona = await pool.query(
    //     "select id_persona, ap_paterno, ap_materno, nombre from persona where CI = ?;", [CI]
    //   )
        res.render('sintomas/add')

});


module.exports = router;
