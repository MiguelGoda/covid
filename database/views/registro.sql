CREATE OR REPLACE VIEW V_REGISTRO as
SELECT 	TU.id_usuario
		,TU.id_persona
        ,CONCAT(TP.nombre, ' ', TP.ap_paterno, ' ', TP.ap_materno) as nombre_completo
FROM usuarios TU
INNER JOIN PERSONA TP ON TU.id_persona = TP.id_persona