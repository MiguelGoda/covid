const express = require('express');
const router = express.Router();
const pool = require('../database')

router.get('/add', (req,res) => {
    res.render('tipo_persona/add')
});

router.post("/add", async (req, res) => {
    try {
      const {
        nombre_tipo_persona,
        descripcion_tipo_persona
       } = req.body;
       const newTipoPersona = {
        nombre_tipo_persona,
        descripcion_tipo_persona
       };
       await pool.query("INSERT INTO tipo_persona SET ?", [newTipoPersona]);
       req.flash("success", "Registrado correctamente");
       res.redirect("/tipo_persona/add");
     } catch (error) {
         console.log("aqui else");
         req.flash("message", "Error al registrar")
         console.error(error + " else"); 
         res.redirect("/tipo_persona/add");
       }  
     }
   );

module.exports = router;