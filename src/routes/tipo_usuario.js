const express = require('express');
const router = express.Router();
const pool = require('../database')

router.get('/add', (req,res) => {
    res.render('tipo_usuario/add')
});

router.post("/add", async (req, res) => {
    try {
      const {
        nombre_tipo_usuario,
        descripcion_tipo_usuario
       } = req.body;
       const newTipoUsuario = {
        nombre_tipo_usuario,
        descripcion_tipo_usuario
       };
       
       await pool.query("INSERT INTO tipo_usuario SET ?", [newTipoUsuario]);
       req.flash("success", "Registrado correctamente");
       res.redirect("/tipo_usuario/add");
     } catch (error) {       
         req.flash("message", "Error al registrar") 
         res.redirect("/tipo_usuario/add");
       }  
     }
   );

module.exports = router;