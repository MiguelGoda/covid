CREATE OR REPLACE VIEW V_HISTORIAL_PACIENTES as
SELECT 	TR.id_registro
		,TP.id_persona
        ,tp.CI
		,CONCAT(TP.nombre, ' ', TP.ap_paterno, ' ', TP.ap_materno) as nombre_completo
		,TREG.NOMBRE_TIPO_REGISTRO as tipo_registro
        ,TP.sexo
        ,TP.fecha_nacimiento
		,TNE.NOMBRE_NIVEL_ENFERMEDAD
		,TR.fecha_registro
        ,TR.observaciones
        ,S.id_sintomas
        ,S.dolor_cabeza
        ,S.estornudos
        ,S.fiebre 
		,S.fatiga 
		,S.tos_seca 
		,S.dificultad_respirar 
		,S.dolor_cuerpo 
		,S.sin_olores 
		,S.dolor_garganta 
		,S.embarazo 
		,S.fecha_sintomas 
		,S.alergias
FROM registro TR
INNER JOIN PERSONA TP ON TR.id_persona = TP.id_persona
INNER JOIN TIPO_REGISTRO TREG ON TR.ID_TIPO_REGISTRO = TREG.ID_TIPO_REGISTRO
INNER JOIN NIVEL_ENFERMEDAD TNE ON TR.id_nivel_enfermedad = TNE.id_nivel_enfermedad
INNER JOIN SINTOMAS S ON TR.id_sintomas = S.id_sintomas