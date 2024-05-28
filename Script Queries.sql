#Scrcip de consultas

USE EGRESADOS;

 ----------- Primera Consulta
 -- El P.A.P.A promedio de los egresados que aplicaron a alguna de las ofertas laborales que son para alguna ingenieria o la modalidad de trabajo es hibrida

 select AVG(EGR_PAPA) as PAPA_PROMEDIO from egresado where EGR_NUM_DOCUMENTO IN (
	select HV_NUM_DOCUMENTO from hojadevida where HV_NUM_DOCUMENTO IN (
		select POS_CEDULA from postulacion where POS_ID_OFERTA IN (
			select OFE_ID from oferta_laboral where OFE_CARRERA like "%Ingeniería%" 
            OR OFE_MODALIDAD_TRABAJO="Híbrido")));

-- --------------------  Segunda consulta

-- Seleccionar las actividades y su número de aplcaintes que tuvieron más de 4 aplicantes.

SELECT ACT.ACT_NOMBRE AS Nombre_Actividad, COUNT(APL.APL_IDENTIFICACION) AS Numero_aplicantes
	FROM Actividad ACT JOIN  Convocatoria CONV ON ACT.ACT_CODIGO = CONV.CON_ACTIVIDAD
		JOIN  Aplicacion APL ON CONV.CON_CODIGO = APL.APL_CODIGO 
			JOIN Persona PER ON APL.APL_IDENTIFICACION = PER.PER_NUM_DOCUMENTO
				GROUP BY  ACT.ACT_NOMBRE;


-- ---------------------- Tercera consulta
-- Mostrar el menor estudiante de la sede Bogotá que accedió a algún servicio.

#Esto tiene sentido si se ve el diagrama de draw.io, es una cadena de joins de las relaciones existentes entre la tabla acceso y el ente facultad
SELECT PER.PER_TIPO_DOCUMENTO,
		PER.PER_NUM_DOCUMENTO,
		PER.PER_NOMBRE,
		PER.PER_APELLIDO,
		MIN(PER.PER_FECHA_NACIMIENTO) AS Fecha_Nacimiento FROM
				acceso ACC
				JOIN
				persona PER ON ACC.ACC_CEDULA = PER.PER_NUM_DOCUMENTO
				JOIN
				estudiante EST ON PER.PER_TIPO_DOCUMENTO = EST.EST_TIPO_DOCUMENTO 
					AND PER.PER_NUM_DOCUMENTO = EST.EST_NUM_DOCUMENTO
				JOIN
				estudiante_estudio_programa ESEP ON EST.EST_TIPO_DOCUMENTO = ESEP.ESEP_TIPO_IDENTIFICACION AND EST.EST_NUM_DOCUMENTO = ESEP.ESEP_IDENTIFICACION
				JOIN
				programa PROG ON ESEP.ESEP_PROGRAMA = PROG.PRO_ID
				JOIN
				departamento DEP ON PROG.PRO_DEPARTAMENTO = DEP.DEP_CODIGO
				JOIN
				facultad FAC ON DEP.DEP_FACULTAD = FAC.FAC_CODIGO
				WHERE
				FAC.FAC_SEDE = 'Bogotá'
					GROUP BY
						PER.PER_TIPO_DOCUMENTO, PER.PER_NUM_DOCUMENTO, PER.PER_NOMBRE, PER.PER_APELLIDO
ORDER BY
    Fecha_Nacimiento DESC
LIMIT 1;


-- ------------------- Cuarta consulta -----------------------
-- Mostrar hojas de vida de los egresados que recibieron una distincion academica
SELECT hojadevida.* FROM distincion #Seleccionamos todas las variables de la hoja de vida
	JOIN persona ON distincion.DISTI_TIPO_IDENTIFICACION = persona.PER_TIPO_DOCUMENTO #Coincidimos los valores de la tabla distincion y persona 
		AND distincion.DISTI_NUM_IDENTIFICACION = persona.PER_NUM_DOCUMENTO
			JOIN
				egresado ON persona.PER_TIPO_DOCUMENTO = egresado.EGR_TIPO_DOCUMENTO 
					AND persona.PER_NUM_DOCUMENTO = egresado.EGR_NUM_DOCUMENTO
						JOIN
							hojadevida ON egresado.EGR_TIPO_DOCUMENTO = hojadevida.HV_TIPO_DOCUMENTO 
							AND egresado.EGR_NUM_DOCUMENTO = hojadevida.HV_NUM_DOCUMENTO
								GROUP BY
								hojadevida.HV_TIPO_DOCUMENTO, hojadevida.HV_NUM_DOCUMENTO
								HAVING
								MAX(distincion.DISTI_TIPO_DISTINCION) = 'Academica'; #MAX se usa porque el comando HAVING necesita una funcion de agregacino como MAX, MIN


-- ------------Quinta consulta 
-- Seleccionar al estudiante más viejo de la facultad ingenieria sede Bogotá.

-- Seleccionamos los atributos que queremos mostrar
SELECT persona.PER_NOMBRE, #Nombre de la persona
 	persona.PER_APELLIDO, #Apellido de la persona
    persona.PER_FECHA_NACIMIENTO, #Fecha de nacimiento de la persona
    facultad.FAC_NOMBRE AS FACULTAD, #Facultad de la persona
    departamento.DEP_NOMBRE AS DEPARTAMENTO, #Departamento del programa
    programa.PRO_NOMBRE AS PROGRAMA #Carrera de la persona
		FROM persona JOIN  estudiante ON 
			persona.PER_TIPO_DOCUMENTO = estudiante.EST_TIPO_DOCUMENTO 
            AND persona.PER_NUM_DOCUMENTO = estudiante.EST_NUM_DOCUMENTO
			JOIN 
		estudiante_estudio_programa ON estudiante.EST_TIPO_DOCUMENTO = estudiante_estudio_programa.ESEP_TIPO_IDENTIFICACION
        AND estudiante.EST_NUM_DOCUMENTO = estudiante_estudio_programa.ESEP_IDENTIFICACION
			JOIN 
			programa ON estudiante_estudio_programa.ESEP_PROGRAMA = programa.PRO_ID
			JOIN 
    departamento ON programa.PRO_DEPARTAMENTO = departamento.DEP_CODIGO
			JOIN 
		facultad ON departamento.DEP_FACULTAD = facultad.FAC_CODIGO
			WHERE 
		facultad.FAC_SEDE = 'Bogotá'
			ORDER BY #Para obtener la maxima edad 
		persona.PER_FECHA_NACIMIENTO ASC
				LIMIT 1; #Para que unicamente muestre al mayor

-- ----------------------- Sexta consulta
-- Mostrar la empresa que recibió mayor cantidad de postulaciones de estudiantes extranjeros.
#Seleccinamos las variables a mostrar
SELECT  empresa.EMP_RAZON_SOCIAL, #Nombre de la empresa
    COUNT(postulacion.POS_CEDULA) AS NUM_POSTULACIONES #Cantidad de postulaciones
		FROM empresa JOIN  oferta_laboral ON empresa.EMP_NIT = oferta_laboral.OFE_EMPRESA_NIT
			JOIN 
				postulacion ON oferta_laboral.OFE_ID = postulacion.POS_ID_OFERTA
				JOIN 
					hojadevida ON postulacion.POS_CEDULA = hojadevida.HV_NUM_DOCUMENTO 
					AND hojadevida.HV_TIPO_DOCUMENTO = 'cedula de extranjeria' #filtramos para detectar extranjeros
					JOIN 
						egresado ON hojadevida.HV_NUM_DOCUMENTO = egresado.EGR_NUM_DOCUMENTO
                        AND hojadevida.HV_TIPO_DOCUMENTO = egresado.EGR_TIPO_DOCUMENTO
							GROUP BY 
								empresa.EMP_RAZON_SOCIAL
								ORDER BY #Ordenamos para obtener al mayor cantidad  
									NUM_POSTULACIONES DESC
									LIMIT 1; #Mostramos el mayor
#Todas las empresas obtuvieron solo una postulacion de egresados extranjeros



-- ------------------------Septima consulta---------------------
-- Mostrar el total de personas que aplicaron a una actividad sociocultural
SELECT  actividad_sociocultural.SOC_CODIGO, 
		COUNT(aplicacion.APL_IDENTIFICACION) AS NUM_APLICACIONES
		FROM 
		actividad_sociocultural	JOIN 
			actividad ON actividad_sociocultural.SOC_CODIGO = actividad.ACT_CODIGO
				JOIN convocatoria ON convocatoria.CON_ACTIVIDAD = actividad.ACT_CODIGO
				JOIN 
				aplicacion ON aplicacion.APL_CODIGO = convocatoria.CON_CODIGO
				GROUP BY 
					actividad_sociocultural.SOC_CODIGO;
#Solo necesitamos hasta aplicacion, pues ahi ya sabemos la cantidad de aplicaciones


-- --------------------------Octava Consulta
-- Servicio más accedido por los egresados que hablan inglés

#Seleccionamos las variables que  vamos a mostrar
SELECT 
    servicios.SERV_NOMBRE, 
    COUNT(acceso.ACC_CODIGO_TRANSACCION) AS NUM_ACCESOS
	FROM servicios JOIN 
    acceso ON servicios.SERV_CODIGO = acceso.ACC_CODIGO_SERVICIO
		JOIN persona ON acceso.ACC_CEDULA = persona.PER_NUM_DOCUMENTO
			JOIN egresado ON persona.PER_NUM_DOCUMENTO = egresado.EGR_NUM_DOCUMENTO 
				AND persona.PER_TIPO_DOCUMENTO = egresado.EGR_TIPO_DOCUMENTO
					JOIN hojadevida ON egresado.EGR_NUM_DOCUMENTO = hojadevida.HV_NUM_DOCUMENTO
						AND egresado.EGR_TIPO_DOCUMENTO = hojadevida.HV_TIPO_DOCUMENTO
							WHERE hojadevida.HV_IDIOMA LIKE '%Inglés%'
								GROUP BY servicios.SERV_NOMBRE
									ORDER BY 
										NUM_ACCESOS DESC LIMIT 1;


--  -------------------------- Novena consulta --------------
-- Adminsitrativos que participaron en el comité que realizó el acta 14569704.

SELECT
    ADM.ADM_TIPO_DOCUMENTO,
    ADM.ADM_NUM_DOCUMENTO,
    ADM.ADM_CARGO,
    ADM.ADM_AREA,
    ADM.ADM_FECHA_INGRESO,
    ADM.ADM_TIPO_CONTRATO,
    ADM.ADM_SEDE
FROM
    administrativo ADM
JOIN
    administrativo_participa_comite APC ON ADM.ADM_TIPO_DOCUMENTO = APC.ADPARCOM_TIPO_DOCUMENTO AND ADM.ADM_NUM_DOCUMENTO = APC.ADPARCOM_NUM_DOCUMENTO
JOIN
    comite COMI ON APC.ADPARCOM_COMI_IDENTIFICADOR = COMI.COMI_IDENTIFICADOR
JOIN
    acta ACT ON COMI.COMI_IDENTIFICADOR = ACT.ACTA_COMITE
WHERE
    ACT.ACTA_ID = 14569704
GROUP BY
    ADM.ADM_TIPO_DOCUMENTO,
    ADM.ADM_NUM_DOCUMENTO
HAVING
    COUNT(*) > 0
LIMIT 0, 1000;



-- ---------------------- Decima consulta --------------
-- Aumentar 0.2 al PAPA de los estudiantes que aplciaron a alguna actividad de investigacion

UPDATE estudiante 
SET EST_PAPA = EST_PAPA + 0.2 
WHERE (EST_TIPO_DOCUMENTO, EST_NUM_DOCUMENTO) IN (
    SELECT DISTINCT est_tipo_doc, est_num_doc
    FROM (
        SELECT 
            estudiante.EST_TIPO_DOCUMENTO AS est_tipo_doc, 
            estudiante.EST_NUM_DOCUMENTO AS est_num_doc
        FROM 
            estudiante 
        JOIN 
            persona ON estudiante.EST_TIPO_DOCUMENTO = persona.PER_TIPO_DOCUMENTO
                AND estudiante.EST_NUM_DOCUMENTO = persona.PER_NUM_DOCUMENTO
        JOIN 
            aplicacion ON persona.PER_TIPO_DOCUMENTO = aplicacion.APL_TIPO_DOCUMENTO
                AND persona.PER_NUM_DOCUMENTO = aplicacion.APL_IDENTIFICACION
        JOIN 
            convocatoria ON aplicacion.APL_CODIGO = convocatoria.CON_CODIGO
        JOIN 
            actividad ON convocatoria.CON_ACTIVIDAD = actividad.ACT_CODIGO
        JOIN 
            actividad_investigacion ON actividad.ACT_CODIGO = actividad_investigacion.INV_CODIGO
    ) AS subconsulta
);

