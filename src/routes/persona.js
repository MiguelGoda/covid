const express = require('express');
const router = express.Router();
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
      const cedula = {CI}
      await pool.query("INSERT INTO persona SET ?", [newPersona]);
      console.log( cedula, "antes del catch");
      req.flash("success", "Registrado correctamente");
      res.redirect("/persona/add");
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
    const personal = await pool.query("SELECT * FROM persona;");
    res.render("persona/list", { personal });
  });


module.exports = router;