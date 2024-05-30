#Script de creacion de indices


USE EGRESADOS;
set profiling= 1; #Para calcular los tiempos de ejecucion

#Grupo 14 
#Nicolas Zuluaga
#Juan Pablo Montaño Díaz

-- En este script crearemos indices para facilitar y acelerar la busqueda en tablas de grandes volumenes de datos.
-- Dado que nuestra base de datos no cuenta con un número de registros "grande", la creación de indices puede parecer "poco util" 
-- en esta base de datos. Sin embargo, la creación de estos indices está pensada en esta misma base de datos pero implementada
-- a gran escala, es decir, con miles o cientos de miles de datos. 

-- Siendo así, crearemos los siguientes indices:

-- 1. El primer indice lo crearemos en la tabla de datos que, tanto en nuestro ejemplo como en la vida real, es la que 
--    posee un mayor numero de registros. La tabla de datos con la información basica de las personas. 
--    Dado que en la vida real, también es practico y deseable poder buscar a una persona por su nombre, crearemos un indice en esta variable 
--    

        
        select * from persona where PER_NOMBRE= "Juan";
        
		CREATE INDEX indice_nombre_persona ON PERSONA (PER_NOMBRE,PER_APELLIDO) USING btree;

		select * from persona where PER_NOMBRE= "Juan";
        
        set profiling=0;
        show profiles;
        #Vamos a comparar el tiempo de ejecucion de cada indice
        SELECT QUERY_ID, SUM(DURATION) AS  Total_Duration FROM INFORMATION_SCHEMA.PROFILING WHERE QUERY_ID = 2 GROUP BY QUERY_ID;
        SELECT QUERY_ID, SUM(DURATION) AS Total_Duration FROM INFORMATION_SCHEMA.PROFILING WHERE QUERY_ID = 4 GROUP BY QUERY_ID;


-- 2. Así mismo en las tablas de egresados, estudiantes y administrativos, es viable crear un índice, para no repetir el mismo indice anterior

--    2.1 En la tabla de egresados, crearemos un indice en la columna de semestre egreso, ya que es de interés práctico facilitar la busqueda 
--        de en qué semestre se egresó

	set profiling=1;
		select * from egresado where EGR_SEMESTRE_EGRESO>"2017-2";
		create index indice_semestre_egreso on egresado(EGR_SEMESTRE_EGRESO);
		select * from egresado where EGR_SEMESTRE_EGRESO>"2017-2";
       set profiling=0; 
        show profiles;
        #Vamos a comparar el tiempo de ejecucion de cada indice
        SELECT QUERY_ID, SUM(DURATION) AS  Total_Duration FROM INFORMATION_SCHEMA.PROFILING WHERE QUERY_ID = 6 GROUP BY QUERY_ID;
        SELECT QUERY_ID, SUM(DURATION) AS Total_Duration FROM INFORMATION_SCHEMA.PROFILING WHERE QUERY_ID = 8 GROUP BY QUERY_ID;

        
--    2.2 En la tabla de estudiantes, crearemos un indice en la columna de P.A.P.A ya que es importante para varios procesos dentro de la universidad.
--        Como por ejemplo, las convocatorias, inscripción de materias o incluso el acceso a alguna actividad.
set profiling=1;
		select * from estudiante where EST_PAPA>=4.3;
        create index indice_papa on estudiante(EST_PAPA);
		select * from estudiante where EST_PAPA>=4.3;
set profiling=0;
		show profiles;
        #Vamos a comparar el tiempo de ejecucion de cada indice
        SELECT QUERY_ID, SUM(DURATION) AS  Total_Duration FROM INFORMATION_SCHEMA.PROFILING WHERE QUERY_ID = 10 GROUP BY QUERY_ID;
        SELECT QUERY_ID, SUM(DURATION) AS Total_Duration FROM INFORMATION_SCHEMA.PROFILING WHERE QUERY_ID = 12 GROUP BY QUERY_ID;


--    2.3 En la tabla de administrativo, crearemos un índice en la columna de sede, pues es importante filtrar los administrativos por su lugar de trabajo
set profiling=1;
		select * from administrativo where ADM_SEDE="Manizales";
		create index indice_sede on administrativo(ADM_SEDE);
		select * from administrativo where ADM_SEDE="Manizales";

set profiling=0;
		show profiles;
        #Vamos a comparar el tiempo de ejecucion de cada indice
        SELECT QUERY_ID, SUM(DURATION) AS  Total_Duration FROM INFORMATION_SCHEMA.PROFILING WHERE QUERY_ID = 14 GROUP BY QUERY_ID;
        SELECT QUERY_ID, SUM(DURATION) AS Total_Duration FROM INFORMATION_SCHEMA.PROFILING WHERE QUERY_ID = 16 GROUP BY QUERY_ID;



--   3. Finalmente, crearemos indices en las ofertas laborales y las activdades para poder buscar rapidamente por las empresas que 
--     ´pubilcan la oferta laboral y tipo de actividad, esto ayuadrá a facilitar la busqueda por ciertos filtros importantes
set profiling=1;
		select * from actividad where ACT_TIPO="Deportiva";
        create index indice_actividad on actividad(ACT_TIPO);
		select * from actividad where ACT_TIPO="Deportiva";

		select * from oferta_laboral where OFE_CARRERA like "%matemáticas%";
        create index indice_carrera on oferta_laboral(OFE_CARRERA);
		select * from oferta_laboral where OFE_CARRERA like "%matemáticas%";

SET profiling = 0;
show profiles;

#Vamos a comparar el tiempo de ejecucion de cada indice
SELECT QUERY_ID, SUM(DURATION) AS  Total_Duration FROM INFORMATION_SCHEMA.PROFILING WHERE QUERY_ID = 18 GROUP BY QUERY_ID;
SELECT QUERY_ID, SUM(DURATION) AS Total_Duration FROM INFORMATION_SCHEMA.PROFILING WHERE QUERY_ID = 20 GROUP BY QUERY_ID;
SELECT QUERY_ID, SUM(DURATION) AS  Total_Duration FROM INFORMATION_SCHEMA.PROFILING WHERE QUERY_ID = 21 GROUP BY QUERY_ID;
SELECT QUERY_ID, SUM(DURATION) AS Total_Duration FROM INFORMATION_SCHEMA.PROFILING WHERE QUERY_ID = 23 GROUP BY QUERY_ID;


-- Desactivar profiling

SET profiling=0;

-- Reactivar profiling
#SET profiling = 1;


#alter table persona drop index indice_nombre_persona;
#alter table egresado drop index indice_semestre_egreso;
#alter table estudiante drop index indice_papa;
#alter table administrativo drop index indice_sede;
#alter table actividad drop index indice_actividad;
#alter table oferta_laboral drop index indice_carrera;
 