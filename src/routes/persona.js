const express = require('express');
const router = express.Router();
const pool = require('../database')

router.get('/add', (req,res) => {
    res.render('persona/add')
});


router.post("/add", async (req, res) => {
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
    console.log(newPersona);
    await pool.query("INSERT INTO persona SET ?", [newPersona]);
    
    // req.flash("success", "La persona se adicciono correctamente");
    res.redirect("/personas/add");
  });


router.get("/", async (req, res) => {
    const personal = await pool.query("SELECT * FROM persona;");
    res.render("persona/list", { personal });
  });


module.exports = router;