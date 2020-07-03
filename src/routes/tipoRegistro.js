const express = require('express');
const router = express.Router();
const pool = require('../database')

router.get('/add', (req,res) => {
    res.render('tipoRegistro/add')
});

router.post("/add", async (req, res) => {
    try {
      const {
        nombre_tipo_registro,
        descripcion_tipo_registro
       } = req.body;
       const newTipoRegistro = {
        nombre_tipo_registro,
        descripcion_tipo_registro
       };
       await pool.query("INSERT INTO tipo_registro SET ?", [newTipoRegistro])
       console.log(newTipoRegistro);
       
       req.flash("success", "Registrado correctamente");
       res.redirect("/tipoRegistro");
     } catch (error) {
         console.log("aqui else");
         req.flash("message", "Error al registrar")
         console.error(error + " else"); 
         res.redirect("/tipoRegistro/add");
       }  
     }
   );


   router.get("/", async (req, res) => {
    const tipoRegistro = await pool.query(
      "SELECT * FROM tipo_registro ;"
    );
    res.render("tipoRegistro/list", {tipoRegistro});
  });

module.exports = router;