const express = require('express');
const router = express.Router();
const pool = require('../database')

router.get('/add',  async (req,res) => {
  const tipo_persona = await pool.query(
    "select id_tipo_persona, nombre_tipo_persona from tipo_persona;"
  )
    res.render('persona/addp', {tipo_persona})
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
      await pool.query("INSERT INTO persona SET ?", [newPersona]);
      console.log(req.body);
      const cedula = {CI};
      const { CI: ci } = cedula;
      console.log( "antes del catch");
      const paciente = await pool.query(
              "select TP.id_persona, CONCAT(TP.nombre, ' ', TP.ap_paterno, ' ', TP.ap_materno) as nombre_completo from persona TP where CI = ?;", [ci]
            )
      console.log(paciente);
      res.render("persona/addS",{paciente})
      
    } catch (error) {
      if (error.code === 'ER_DUP_ENTRY') { 
        console.log("aqui if as");
        console.error(error.code); 
        console.log(req.flash("success"));
        req.flash("message", "El CI ya se encuentra resgistrado")
        res.redirect("/persona/addP");
      } else {
        console.log("aqui else");
        req.flash("message", "error al registrar")
        console.error(error + " else"); 
        res.redirect("/persona/addP");
      }  
    }
  });


  router.get("/", async (req, res) => {
    const persona = await pool.query("SELECT * FROM covid.v_lista_pacientes;")
    res.render("persona/listp", {persona})
  });



  // router.get('/add', async (req, res) => {
    
  //   const persona = await pool.query(
  //       "select id_persona, ap_paterno, ap_materno, nombre from persona where CI = ?;", [ci]
  //     )
  //       res.render('persona/addS')

  // });


module.exports = router;