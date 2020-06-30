CREATE OR REPLACE VIEW V_AGREGAR_REGISTRO_SINTOMAS as
select  id_nivel_enfermedad as NE
        ,nombre_nivel_enfermedad as NNE 
from nivel_enfermedad;