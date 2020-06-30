CREATE OR REPLACE VIEW V_AGREGAR_REGISTRO_SINTOMAS as
select id_persona, max(id_sintomas) AS id_sintomas 
			from sintomas S 
			group by ID_PERSONA