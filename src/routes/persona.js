const express = require('express');
const router = express.Router();
const moment = require("handlebars.moment");
const pool = require('../database')

router.get('/add',  async (req,res) => {
  const tipo_persona = await pool.query(
    "select id_tipo_persona, nombre_tipo_persona from tipo_persona;"
  )
    res.render('persona/add', {tipo_persona})
});


router.post("/add", async (req, res) => {
   try {
     const {
       id_tipo_persona,
       ap_paterno,
       ap_materno,
       nombre,
       fecha_nacimiento,
       CI,
       celular,
       domicilio,
       sexo
      } = req.body;
      const newPersona = {
        id_tipo_persona,
        ap_paterno,
        ap_materno,
        nombre,
        fecha_nacimiento,
        CI,
        celular,
        domicilio,
        sexo
      };
      const ci = CI
      // await pool.query("INSERT INTO persona SET ?", [newPersona]);
      console.log('Req Body in', req.body);
      
      console.log( ci, "antes del catch");
      req.flash("success", "Registrado correctamente");
      res.redirect(`/sintomas/add?ci=${ci}`);
    } catch (error) {
      if (error.code === 'ER_DUP_ENTRY') { 
        console.log("aqui if as");
        console.error(error.code); 
        console.log(req.flash("success"));
        req.flash("message", "El CI ya se encuentra resgistrado")
        res.redirect("/persona/add");
      } else {
        console.log("aqui else");
        req.flash("message", "error al registrar")
        console.error(error + " else"); 
        res.redirect("/persona/add");
      }  
    }
  });


  router.get("/", async (req, res) => {
    const persona = await pool.query("SELECT * FROM covid.v_lista_pacientes;")
    res.render("persona/list", {persona})
  });

  router.get("/historial/:id", async (req, res) => {
    const { id } = req.params;
    const historial = await pool.query(
      "SELECT * FROM covid.v_historial_pacientes WHERE id_persona = ?",
      [id]
    );
    res.render("persona/historial", { historial });
    console.log(historial);
    
  });

module.exports = router;