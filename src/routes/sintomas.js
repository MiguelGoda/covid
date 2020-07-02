const express = require('express');
const router = express.Router();
const pool = require('../database');

router.get('/add', async (req, res) => {
    const cedula = req.query.ci
    const persona = await pool.query(
        "select TP.id_persona, CONCAT(TP.nombre, ' ', TP.ap_paterno, ' ', TP.ap_materno) as nombre_completo from persona TP WHERE CI = ?;", [cedula]
    )
    console.log(persona);

    res.render('sintomas/add', { persona })

});

router.post('/add', async (req, res) => {
    try {
        const {
            id_persona,
            dolor_cabeza = 0,
            estornudos = 0,
            fiebre = 0,
            fatiga = 0,
            tos_seca = 0,
            dificultad_respirar = 0,
            dolor_cuerpo = 0,
            sin_olores = 0,
            dolor_garganta = 0,
            embarazo = 0,
            fecha_sintomas,
            alergias
        } = req.body;
        const newSintoma = {
            id_persona,
            dolor_cabeza,
            estornudos,
            fiebre,
            fatiga,
            tos_seca,
            dificultad_respirar,
            dolor_cuerpo,
            sin_olores,
            dolor_garganta,
            embarazo,
            fecha_sintomas,
            alergias
        };
        const idP = id_persona;
        await pool.query("INSERT INTO sintomas SET ?", [newSintoma]);
        console.log(req.body, "antes del catch");
        console.log(newSintoma, "newpersona");

        req.flash("success", "Registrado correctamente");
        res.redirect(`/registros/add?idP=${idP}`);
    } catch (error) {
        if (error.code === 'ER_DUP_ENTRY') {
            console.log("aqui if as");
            console.error(error.code);
            console.log(req.flash("success"));
            req.flash("message", "El CI ya se encuentra resgistrado")
            res.redirect("/sintomas/add");
        } else {
            console.log("aqui else");
            req.flash("message", "error al registrar")
            console.error(error + " else");
            res.redirect("/sintomas/add");
        }
    }
});


router.get("sintomas/add/:id", async (req,res) => {
    const { id } = req.params;
    res.redirect('sintomas/add')
     
})


module.exports = router;

    // diaActual = new Date();

    // var day = diaActual.getDate();
    // var month = diaActual.getMonth() + 1;
    // var year = diaActual.getFullYear();

    // fecha = year + '/' + month + '/' + day;
    // console.log(fecha);
    // res.render('sintomas/add', { fecha })