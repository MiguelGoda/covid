const express = require('express')
const router = express.Router();
const pool = require('../database');
const { route } = require('.');

router.get('/add', async (req,res) => {
    const idP = req.query.idP
    user_id = req.user.id_usuario;
    console.log(user_id, 'id_usuario');
    const persona = await pool.query("select TP.id_persona, CONCAT(TP.nombre, ' ', TP.ap_paterno, ' ', TP.ap_materno) as nombre_completo from persona TP WHERE id_persona = ?;", [idP])
    
    const usuario = await pool.query("SELECT * FROM covid.v_agregar_registro WHERE id_usuario = ?", [user_id])
    console.log(usuario);
    

    const sintomas = await pool.query("SELECT * FROM covid.v_agregar_registro_sintomas WHERE id_persona = ?", [idP])

    const nivelEnfermedad = await pool.query("SELECT * FROM covid.v_agregar_registro_nivel_enfermedad;")

    const tipoRegistro = await pool.query("select id_tipo_registro as TR, nombre_tipo_registro as NTR from tipo_registro;")
    
    const distrito = await pool.query("SELECT * FROM covid.v_agregar_registro_distrito;")
    console.log(distrito);
    
    
    
res.render('registros/add', {persona, usuario, sintomas, nivelEnfermedad, tipoRegistro, distrito})
})

router.post("/add", async (req, res) => {
    try {
      const {
        id_sintomas,
        id_usuario,
        id_persona,
        id_nivel_enfermedad,
        id_tipo_registro,
        id_distrito,
        observaciones
       } = req.body;
       const newRegistro = {
        id_sintomas,
        id_usuario,
        id_persona,
        id_nivel_enfermedad,
        id_tipo_registro,
        id_distrito,
        observaciones
       };
       console.log(newRegistro);
       await pool.query("INSERT registro SET ?", [newRegistro]);
    
       console.log('Req Body in', req.body);
       req.flash("success", "Registrado correctamente");
       res.redirect(`/persona`);
     } catch (error) {
     
         ;
         console.error(error.code); 
         console.log(req.flash("success"));
         req.flash("message", "Hubo un error")
         res.redirect("persona");
       
     }
   });



module.exports = router;