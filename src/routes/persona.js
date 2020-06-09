const express = require('express');
const router = express.Router();
const pool = require('../database')

router.get('/add', (req,res) => {
    res.render('persona/add')
});


router.post("/add", async (req, res) => {
   try {
     
     const {
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
        ap_paterno,
        ap_materno,
        nombre,
        fecha_nacimiento,
        CI,
        celular,
        domicilio,
        sexo
      };
      await pool.query("INSERT INTO persona SET ?", [newPersona]);
      req.flash("success", "Registrado correctamente");
      res.redirect("/persona/add");
    } catch (error) {
      if (error.code === 'ER_DUP_ENTRY') {
        req.flash("success", "El CI ya se encuentra resgistrado")
        res.redirect("/persona/add");
        
      } else {  
        req.flash("success", "error al registrar")
        res.redirect("/persona/add");
      }  
    }
  });


router.get("/", async (req, res) => {
    const personal = await pool.query("SELECT * FROM persona;");
    res.render("persona/list", { personal });
  });


module.exports = router;