CREATE OR REPLACE VIEW V_REGISTRAR_USUARIOS as
SELECT 	TP.id_tipo_persona
		,TP.nombre_tipo_persona
        ,P.id_persona 
        ,CONCAT(P.nombre, ' ', P.ap_paterno, ' ', P.ap_materno) as nombre_completo
FROM tipo_persona TP RIGHT JOIN persona P ON TP.id_tipo_persona = P.id_tipo_persona